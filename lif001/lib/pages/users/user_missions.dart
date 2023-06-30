import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:lif001/global/size.dart';

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
  bool isLoading = false;
  List missions = [];
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    var docs = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .get();

    missions = docs.data()!["mymissions"];
    print(missions);
    setState(() {
      missions;
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: !isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : missions.isEmpty
              ? Center(
                  child: Text("Kullanıcı görev yapmamıştır."),
                )
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.uid)
                      .collection("missions")
                      .where("missionid", whereIn: missions)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    print(snapshot.data!.docs.length);
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (ctx, index) => Container(
                        child: SizedBox(
                          width: width(context),
                          child: Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Text(snapshot.data!.docs[index].data()["soru"] +
                                    " ?"),
                                snapshot.data!.docs[index].data()["type"] == 2
                                    ? Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data!.docs[index]
                                                    .data()["answer"]))),
                                      )
                                    : Text(snapshot.data!.docs[index]
                                        .data()["answer"])
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
