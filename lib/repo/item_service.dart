import 'package:blueberry/constants/data_keys.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  static final ItemService _itemService = ItemService._interal();
  factory ItemService() => _itemService;
  ItemService._interal();

  Future createNewItem(
      ItemModel itemModel, String itemKey, String userKey) async {
    DocumentReference<Map<String, dynamic>> itemDocReference =
        FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);

    DocumentReference<Map<String, dynamic>> userItemDocReference =
        FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(COL_USERS_ITEMS)
            .doc(itemKey);

    final DocumentSnapshot documentSnapshot = await itemDocReference.get();

    if (!documentSnapshot.exists) {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(itemDocReference, itemModel.toJson());
        transaction.set(userItemDocReference, itemModel.toMinJson());
      });
    }
  }

  Future<ItemModel> getItem(String itemKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();
    ItemModel itemModel = ItemModel.fromSnapshot(documentSnapshot);
    return itemModel;
  }

  Future<List<ItemModel>> getItems() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection(COL_ITEMS);
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await collectionReference.get();

    List<ItemModel> items = [];

    for (var i = 0; i < snapshot.size; i++) {
      ItemModel itemModel = ItemModel.fromQuerySnapshot(snapshot.docs[i]);
      items.add(itemModel);
    }
    return items;
  }

  Future<List<ItemModel>> getuserItems(String userKey,
      {String? itemKey}) async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection(COL_USERS)
            .doc(userKey)
            .collection(COL_USERS_ITEMS);
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await collectionReference.get();

    List<ItemModel> items = [];

    for (var i = 0; i < snapshot.size; i++) {
      ItemModel itemModel = ItemModel.fromQuerySnapshot(snapshot.docs[i]);
      if (!(itemKey != null && itemKey == itemModel.itemKey)) {
        items.add(itemModel);
      }
    }
    return items;
  }
}
