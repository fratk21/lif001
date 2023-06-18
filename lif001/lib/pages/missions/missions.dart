import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lif001/pages/missions/missions_add.dart';

class missions_page extends StatefulWidget {
  const missions_page({super.key});

  @override
  State<missions_page> createState() => _missions_pageState();
}

class _missions_pageState extends State<missions_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görevler"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => missions_add(),
                    ));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('missions').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                            child:
                                Text("Herhangi bir görev bulunmamaktadır.")));
                  } else {
                    result = Container();
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
