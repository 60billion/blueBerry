import 'dart:async';

import 'package:blueberry/constants/data_keys.dart';
import 'package:blueberry/data/chat_model.dart';
import 'package:blueberry/data/chatroom_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static final ChatService _chatService = ChatService._interal();
  factory ChatService() => _chatService;
  ChatService._interal();

  //todo: crate new chatroom

  Future createNewChatroom(ChatroomModel chatroomModel) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(
            ChatroomModel.generateChatRoomKey(
                chatroomModel.buyerKey, chatroomModel.itemKey));
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    if (!documentSnapshot.exists) {
      await documentReference.set(chatroomModel.toJson());
    }
  }

  //todo: crate new chat
  Future createNewChat(String chatroomKey, ChatModel chatModel) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection(COL_CHATROOMS)
            .doc(chatroomKey)
            .collection(COL_CHATS)
            .doc();

    DocumentReference<Map<String, dynamic>> chatroomDocRef =
        FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(chatroomKey);

    await documentReference.set(chatModel.toJson());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatModel.toJson());
      transaction.update(chatroomDocRef, {
        DOC_LASTMSG: chatModel.msg,
        DOC_LASTMSGTIME: chatModel.createdDate,
        DOC_LASTMSGUSERKEY: chatModel.userKey
      });
    });
  }

  //todo: get chatroom detail

  Stream<ChatroomModel> connectChatroom(String chatroomKey) {
    return FirebaseFirestore.instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .snapshots()
        .transform(snapshotToChatroom);
  }

  var snapshotToChatroom = StreamTransformer<
      DocumentSnapshot<Map<String, dynamic>>,
      ChatroomModel>.fromHandlers(handleData: (snapshot, sink) {
    ChatroomModel chatroom = ChatroomModel.fromSnapshot(snapshot);
    sink.add(chatroom);
  });

  //todo: get chat list

  Future<List<ChatModel>> getChatList(String chatroomKey) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .limit(10)
        .get();

    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatList.add(chatModel);
    });
    return chatList;
  }

  //todo latest chats

  Future<List<ChatModel>> getLatestChats(
      String chatroomKey, DocumentReference currentLatestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .endBeforeDocument(await currentLatestChatRef.get())
        .get();

    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatList.add(chatModel);
    });
    return chatList;
  }

  //todo older chats

  Future<List<ChatModel>> getOlderChats(
      String chatroomKey, DocumentReference oldestChatRef) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .collection(COL_CHATS)
        .orderBy(DOC_CREATEDDATE, descending: true)
        .startAtDocument(await oldestChatRef.get())
        .limit(10)
        .get();

    List<ChatModel> chatList = [];
    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromQuerySnapshot(docSnapshot);
      chatList.add(chatModel);
    });
    return chatList;
  }
}
