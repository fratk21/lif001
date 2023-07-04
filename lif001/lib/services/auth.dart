import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class auth_services {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? res = "";
  Future<String?> login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        final status = await OneSignal.shared.getDeviceState();
        final String? osUserID = status?.userId;
        FirebaseFirestore.instance
            .collection('users')
            .doc(
              FirebaseAuth.instance.currentUser!.uid,
            )
            .update({"OneSignalid": osUserID});
        await _firestore.collection("notif").doc("1").update({
          "users": FieldValue.arrayUnion([osUserID])
        });
        res = "ok";
      } else {
        res = "Lütfen Tüm Alanları Doldurunuz";
      }
    } catch (err) {
      res = err.toString();
      return res;
    }

    return res;
  }

  Future<String?> register(String? email, String? password) async {
    try {
      if (email!.isNotEmpty && password!.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final status = await OneSignal.shared.getDeviceState();
        final String? osUserID = status?.userId;
        await _firestore.collection("users").doc(cred.user!.uid).set({
          "email": email,
          "uid": cred.user!.uid,
          "state": 1,
          "userdetail": 0,
          "createdate": DateTime.now(),
          "mymissions": [],
          "OneSignalid": osUserID
        });
        await _firestore.collection("notif").doc("1").update({
          "users": FieldValue.arrayUnion([osUserID])
        });
        res = "Success";
      } else {}
    } catch (e) {
      print(e);
    }
    return res;
  }

  out() async {
    return await _auth.signOut();
  }

  Future<String?> ResetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.toString());
  }
}
