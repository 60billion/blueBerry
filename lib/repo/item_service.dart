import 'package:blueberry/constants/data_keys.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  static final ItemService _itemService = ItemService._interal();
  factory ItemService() => _itemService;
  ItemService._interal();

  Future createNewItem(Map<String, dynamic> json, String itemKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    if (!documentSnapshot.exists) {
      await documentReference.set(json);
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
      ItemModel itemModel = ItemModel.fromSnapshot(snapshot.docs[i]);
      items.add(itemModel);
    }
    return items;
  }
}
