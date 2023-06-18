import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseData {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<List<Map<String, dynamic>>> getUsers() async {
    QuerySnapshot querySnapshot = await _usersCollection.get();

    List<Map<String, dynamic>> users = [];
    querySnapshot.docs.forEach((doc) {
      users.add(doc.data() as Map<String, dynamic>);
    });

    return users;
  }

  Future<Map<String, dynamic>?> getUserById(String userId) async {
    DocumentSnapshot documentSnapshot =
        await _usersCollection.doc(userId).get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>?;
    }

    return null;
  }

  Future<void> freezeAccount(String userId) async {
    await _usersCollection.doc(userId).update({'state': 2});
  }

  Future<void> deleteAccount(String userId) async {
    await _usersCollection.doc(userId).update({'state': 3});
  }
}
