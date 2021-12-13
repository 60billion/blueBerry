import 'package:blueberry/constants/data_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// chatKey : "chatKey"
/// msg : "msg"
/// createdDate : "createdDate"
/// userKey : "userKey"
/// reference : "reference"

class ChatModel {
  late String chatKey;
  late String msg;
  late DateTime createdDate;
  late String userKey;
  DocumentReference? reference;

  ChatModel({
    required this.chatKey,
    required this.msg,
    required this.createdDate,
    required this.userKey,
    this.reference,
  });

  ChatModel.fromJson(Map<String, dynamic> json, this.chatKey, this.reference) {
    chatKey = json[DOC_CHATKEY] ?? "";
    msg = json[DOC_MSG] ?? "";
    createdDate = json[DOC_CREATEDDATE] == null
        ? DateTime.now().toUtc()
        : (json[DOC_CREATEDDATE] as Timestamp).toDate();
    userKey = json[DOC_USERKEY] ?? "";
    reference = json['reference'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map[DOC_CHATKEY] = chatKey;
    map[DOC_MSG] = msg;
    map[DOC_CREATEDDATE] = createdDate;
    map[DOC_USERKEY] = userKey;
    map['reference'] = reference;
    return map;
  }

  ChatModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  ChatModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);
}
