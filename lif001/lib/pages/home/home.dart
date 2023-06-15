import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class homepages extends StatefulWidget {
  const homepages({super.key});

  @override
  State<homepages> createState() => _homepagesState();
}

class _homepagesState extends State<homepages> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  int money = 0;
  bool loading = false;
  void getdata() async {
    try {
      var usersnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      setState(() {
        money = usersnap.data()!['money'];
      });
    } catch (e) {
      print("eee :$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: Image.asset('assets/logo.png'),
              title: Text("LIF3"),
              actions: [
                Row(
                  children: [
                    Icon(Icons.monetization_on_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(money.toString()),
                  ],
                )
              ],
            ),
            body: SingleChildScrollView());
  }
}
