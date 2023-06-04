import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lif001/navigatorAdmin.dart';
import 'package:lif001/navigatorUser.dart';

class routes {
  void login(BuildContext context) {
    var userinfo = getdata();
    if (userinfo["state"] == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => navigatorUser(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => navigatorAdmin(),
          ));
    }
  }
}

getdata() async {
  var userSnap = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  return userSnap;
}
