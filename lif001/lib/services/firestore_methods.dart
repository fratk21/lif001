import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
String res = "";

class firestoreservices {
  Future<String?> add_missions(
      String gorevadi, String soru, int puan, int type) async {
    String missionid = const Uuid().v1();
    try {
      _firestore.collection("mission").doc(missionid).set({
        "gorevadi": gorevadi,
        "soru": soru,
        "puan": puan,
        "type": type,
        "missionid": missionid,
        "createDate": DateTime.now(),
        "state": 1
      });
      res = "ok";
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    }
  }

  Future<String?> mission_delete(String id) async {
    _firestore.collection("mission").doc(id).delete();
  }

  Future<String?> mission_state(snap) async {
    _firestore
        .collection("mission")
        .doc(snap["missionid"])
        .update(snap["state"] == 1 ? {"state": 0} : {"state": 1});
  }
}
