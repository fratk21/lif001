import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../../cards/user_mission_card.dart';
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
  List mymissions = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    mymissions.add(FirebaseAuth.instance.currentUser!.uid);
    Map<String, dynamic>? fetchedUser = await firestoreService
        .getUserById(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      user = fetchedUser;
      isLoading = true;
      mymissions.addAll(user!["mymissions"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == false
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('mission')
                      .where("state", isEqualTo: 1)
                      .where("missionid", whereNotIn: mymissions)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length == 0
                          ? 1
                          : snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Widget result;
                        if (snapshot.data!.docs.isEmpty) {
                          result = Container(
                              child: Center(
                                  child: Text(
                                      "Herhangi bir görev bulunmamaktadır.")));
                        } else {
                          result = user_mission_card(
                              snapshot.data!.docs[index], context);
                        }

                        return result;
                      },
                    );
                  },
                ),
              ),
            ),
          );
  }
}
