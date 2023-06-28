import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lif001/global/snackbars.dart';
import 'package:lif001/navigatorAdmin.dart';
import 'package:lif001/navigatorUser.dart';
import 'package:lif001/pages/LoginAndRegister/avatarAndusername/avatar.dart';
import 'package:lif001/services/data.dart';

import '../pages/LoginAndRegister/LoginAndRegister.dart';

class routes {
  void login(BuildContext context) async {
    var userSnap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userSnap.data()!["userdetail"] == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => avatarAndUsername(),
          ));
    } else {
      if (userSnap.data()!["state"] == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => navigatorUser(),
            ));
      } else if (userSnap.data()!["state"] == 2) {
        FireBaseData().nofreezeAccount(FirebaseAuth.instance.currentUser!.uid);
        SnackbarService.showSnackbar(context, 'Hesabınız Aktif Edildi.');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => navigatorUser(),
            ));
      } else if (userSnap.data()!["state"] == 3) {
        SnackbarService.showSnackbar(context, 'Hesabınız silinmiştir.');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const loginpage()),
            (Route route) => false);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => navigatorAdmin(),
            ));
      }
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
