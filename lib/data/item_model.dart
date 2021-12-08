import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

/// itemKey : "itemKey"
/// userKey : "userKey"
/// imageDownloadUrls : ["imageDownloadUrls"]
/// title : "title"
/// category : "category"
/// price : 10
/// negotiable : false
/// detail : "detail"
/// address : "address"
/// geoFirePoint : "geoFirePoint"
/// createdDate : "createdDate"
/// reference : "reference"

class ItemModel {
  late String itemKey;
  late String userKey;
  late List<String> imageDownloadUrls;
  late String title;
  late String category;
  late int price;
  late bool negotiable;
  late String detail;
  late String address;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  late DocumentReference? reference;

  ItemModel({
    required this.itemKey,
    required this.userKey,
    required this.imageDownloadUrls,
    required this.title,
    required this.category,
    required this.price,
    required this.negotiable,
    required this.detail,
    required this.address,
    required this.geoFirePoint,
    required this.createdDate,
    this.reference,
  });

  ItemModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference) {
    itemKey = json['itemKey'] ?? "";
    userKey = json['userKey'] ?? "";
    imageDownloadUrls = json['imageDownloadUrls'] != null
        ? json['imageDownloadUrls'].cast<String>()
        : [];
    title = json['title'] ?? "";
    category = json['category'] ?? "none";
    price = json['price'] ?? 0;
    negotiable = json['negotiable'] ?? false;
    detail = json['detail'] ?? "";
    address = json['address'] ?? "";
    geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
        (json['geoFirePoint']['geopoint']).longitude);
    createdDate = json['createdDate'] == null
        ? DateTime.now().toUtc()
        : (json['createdDate'] as Timestamp).toDate();
    reference = json['reference'];
  }

  ItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);
  ItemModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['itemKey'] = itemKey;
    map['userKey'] = userKey;
    map['imageDownloadUrls'] = imageDownloadUrls;
    map['title'] = title;
    map['category'] = category;
    map['price'] = price;
    map['negotiable'] = negotiable;
    map['detail'] = detail;
    map['address'] = address;
    map['geoFirePoint'] = geoFirePoint.data;
    map['createdDate'] = createdDate;
    return map;
  }

  static String getitemKey(String uid) {
    String timeInMilli = DateTime.now().microsecondsSinceEpoch.toString();
    return '${uid}_$timeInMilli';
  }
}
