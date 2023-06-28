import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/data.dart';

class user_missions extends StatefulWidget {
  final uid;
  const user_missions({super.key, required this.uid});

  @override
  State<user_missions> createState() => _user_missionsState();
}

class _user_missionsState extends State<user_missions> {
  FireBaseData firestoreService = FireBaseData();
  Map<String, dynamic>? user;
  Map<String, dynamic>? mission;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    Map<String, dynamic>? fetchedUser =
        await firestoreService.getUserById(widget.uid);
     mission =(await FirebaseFirestore.instance
        .collection("mission")
        .where("missionid", whereIn: fetchedUser!["mymissions"])) as Map<String, dynamic>?;
    setState(() {
      user = fetchedUser;
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ,
    );
  }
}
