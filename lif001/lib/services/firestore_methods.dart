import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lif001/services/data.dart';
import 'package:lif001/services/storage_methods.dart';
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

  Future<String?> missionaccepttext(snap, String text) async {
    String mymissionid = const Uuid().v1();

    _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("missions")
        .doc(mymissionid)
        .set({
      "gorevadi": snap["gorevadi"],
      "soru": snap["soru"],
      "puan": snap["puan"],
      "type": snap["type"],
      "missionid": snap["missionid"],
      "mymissionid": mymissionid,
      "createtime": DateTime.now(),
      "answer": text,
    });
    _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'mymissions': FieldValue.arrayUnion([snap["missionid"]])
    });
    res = "ok";
    return res;
  }

  Future<String?> missionacceptimage(snap, Uint8List file) async {
    String missionid = const Uuid().v1();
    String photoUrl =
        await StorageMethods().uploadImageToStorage('answer', file, false);
    _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("missions")
        .doc(missionid)
        .set({
      "gorevadi": snap["gorevadi"],
      "soru": snap["soru"],
      "puan": snap["puan"],
      "type": snap["type"],
      "missionid": missionid,
      "createtime": DateTime.now(),
      "answer": photoUrl,
    });
    _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'mymissions': FieldValue.arrayUnion([snap["missionid"]])
    });
    res = "ok";
    return res;
  }
}
