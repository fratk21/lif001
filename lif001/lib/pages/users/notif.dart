import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lif001/utils/utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../global/elevatedButton.dart';
import '../../services/data.dart';

class notif_screen extends StatefulWidget {
  final uid;
  const notif_screen({super.key, required this.uid});

  @override
  State<notif_screen> createState() => _notif_screenState();
}

class _notif_screenState extends State<notif_screen> {
  FireBaseData firestoreService = FireBaseData();
  List users = [];
  Map<String, dynamic>? user;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    control();
  }

  void control() async {
    if (widget.uid == "1") {
      var getsignaluid =
          await FirebaseFirestore.instance.collection("notif").doc("1").get();
      users.addAll(getsignaluid.data()!["users"]);
      setState(() {
        isLoading = true;
      });
    } else {
      Map<String, dynamic>? fetchedUser =
          await firestoreService.getUserById(widget.uid);
      setState(() {
        user = fetchedUser;
        isLoading = true;
      });
      users.add(user!["OneSignalid"]);
      print(user!["OneSignalid"]);
    }
  }

  TextEditingController _tittlecontroller = TextEditingController();
  TextEditingController _descontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          title: Text("Bildirim Oluştur"),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true),
      body: isLoading == false
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                strokeAlign: 1,
                                color: Colors.grey,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextField(
                              maxLines: 1,
                              controller: _tittlecontroller,
                              decoration: InputDecoration(
                                labelText:
                                    "Lütfen Bildirim Başlığını Yazınız..",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                                strokeAlign: 1,
                                color: Colors.grey,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextField(
                              maxLines: 20,
                              controller: _descontroller,
                              decoration: InputDecoration(
                                labelText:
                                    "Lütfen Bildirim içeriğini Yazınız..",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CustomElevatedButton(
                        text: "Bildirim Oluştur",
                        icon: Icons.arrow_forward_ios,
                        onPressed: () async {
                          if (_tittlecontroller.text.isEmpty ||
                              _descontroller.text.isEmpty) {
                            showSnackBar(context, "Alanları doldurunuz");
                          } else {
                            if (widget.uid != "1") {
                              for (var i = 0; i < users.length; i++) {
                                try {
                                  await OneSignal.shared
                                      .postNotification(OSCreateNotification(
                                    playerIds: [users[i]],
                                    content: _descontroller.text,
                                    heading: _tittlecontroller.text,
                                    sendAfter: DateTime.now().toUtc(),
                                  ));
                                } catch (e) {
                                  print(e);
                                }
                              }
                            } else {
                              for (var i = 0; i < users.length; i++) {
                                try {
                                  await OneSignal.shared
                                      .postNotification(OSCreateNotification(
                                    playerIds: [users[i]],
                                    content: _descontroller.text,
                                    heading: _tittlecontroller.text,
                                    sendAfter: DateTime.now().toUtc(),
                                  ));
                                } catch (e) {
                                  print(e);
                                }
                              }
                            }
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
