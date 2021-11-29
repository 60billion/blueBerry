import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  Future firestoreTest() async {
    FirebaseFirestore.instance
        .collection("TESTING_COLLECTION")
        .add({"testing": 'testing value', "number": 123});
  }
}
