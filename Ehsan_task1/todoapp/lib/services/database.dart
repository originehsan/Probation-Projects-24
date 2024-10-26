import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .set(userInfoMap);
  }
}

class DatabaseMethodsAdd {
  Future<void> addWork(String work, String id, String userId, String collection) async {
    return await FirebaseFirestore.instance.collection(collection).doc(id).set({
      'Work': work,
      'Id': id,
      'userId': userId,
      'IsChecked': false,
    });
  }

  Stream<QuerySnapshot> getAllWork(String day, String userId) {
    return FirebaseFirestore.instance
        .collection(day)
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}

class DatabaseMethodsDelete {
  Future<void> deleteWork(String id, String collection) async {
    await FirebaseFirestore.instance.collection(collection).doc(id).delete();
  }
}

class DatabaseMethodsUpdate {
  Future<void> updateWorkCheckedState(String id, bool isChecked, String collection) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .update({'IsChecked': isChecked});
  }
}
