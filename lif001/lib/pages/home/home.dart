import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/data.dart';

class homepages extends StatefulWidget {
  const homepages({super.key});

  @override
  State<homepages> createState() => _homepagesState();
}

class _homepagesState extends State<homepages> {
  FireBaseData firestoreService = FireBaseData();
  Map<String, dynamic>? user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    Map<String, dynamic>? fetchedUser = await firestoreService
        .getUserById(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      user = fetchedUser;
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: Image.asset('assets/logo.png'),
              title: Text("LIF3"),
            ),
            body: SingleChildScrollView());
  }
}
