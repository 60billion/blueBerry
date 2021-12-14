import 'dart:developer';

import 'package:blueberry/data/chat_model.dart';
import 'package:blueberry/data/chatroom_model.dart';
import 'package:blueberry/repo/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatNotifier extends ChangeNotifier {
  late ChatroomModel _chatroomModel;
  List<ChatModel> _chatList = [];
  late String _chatroomKey;

  ChatNotifier(this._chatroomKey) {
    ChatService().connectChatroom(_chatroomKey).listen((chatroomModel) {
      this._chatroomModel = chatroomModel;

      if (this._chatList.isEmpty) {
        ChatService().getChatList(_chatroomKey).then((chatList) {
          _chatList.addAll(chatList);
          notifyListeners();
        });
      } else {
        if (_chatList[0].reference == null) _chatList.removeAt(0);
        ChatService()
            .getLatestChats(this._chatroomKey, _chatList[0].reference!)
            .then((latestChat) {
          _chatList.insertAll(0, latestChat);
          notifyListeners();
        });
      }
    });
  }
  void addNewChat(ChatModel chatModel) {
    _chatList.insert(0, chatModel);
    notifyListeners();
    ChatService().createNewChat(_chatroomKey, chatModel);
  }

  ChatroomModel get chatroomModel => _chatroomModel;
  List<ChatModel> get chatList => _chatList;
  String get chatroomKey => _chatroomKey;
}
