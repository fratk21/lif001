import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lif001/utils/utils.dart';

class userdetailservices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String res = "";
  Future<String?> registerone(String ad, String soyad, String ref,
      String avatarsvg, BuildContext context) async {
    DateTime now = DateTime.now();
    int minute = now.minute;
    int second = now.second;
    int millisecond = now.millisecond;
    Refcontrol(context, ref);
    _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "name": ad,
      "surname": soyad,
      "ref": ref,
      "myref": "$minute" + "$second" + "$millisecond",
      "avatar": avatarsvg,
      "userdetail": 1,
      "money": 100
    });
    res = "succes";
    return res;
  }

  Future<String?> Refcontrol(BuildContext context, String ref) async {
    var control =
        await _firestore.collection("users").where("ref", isEqualTo: ref).get();
    if (control.docs.length == 1) {
      showSnackBar(context, "Böyle bir referans numarası bulunmamaktadır.");
    } else {
      showSnackBar(
          context, "Tebrikler hem sana hemde arkadaşına bonus puan eklendi.");
    }
  }
}
