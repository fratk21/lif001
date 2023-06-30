import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lif001/global/size.dart';
import 'package:lif001/global/textedit.dart';

import '../../services/data.dart';

class user_info extends StatefulWidget {
  final uid;
  const user_info({super.key, required this.uid});

  @override
  State<user_info> createState() => _user_infoState();
}

class _user_infoState extends State<user_info> {
  FireBaseData firestoreService = FireBaseData();
  Map<String, dynamic>? user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    Map<String, dynamic>? fetchedUser =
        await firestoreService.getUserById(widget.uid);
    setState(() {
      user = fetchedUser;
      isLoading = true;
    });
  }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          title: Text(
            "Kullanıcı bilgileri",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true),
      body: isLoading == false
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                inputtex(
                    context,
                    _controller,
                    50,
                    width(context),
                    1,
                    60,
                    "Ad : ${user!["name"]}",
                    Icons.account_circle_outlined,
                    TextInputType.name,
                    false,
                    Colors.white,
                    Colors.black,
                    15,
                    false),
                inputtex(
                    context,
                    _controller,
                    50,
                    width(context),
                    1,
                    60,
                    "Soyad : ${user!["surname"]}",
                    Icons.account_circle_outlined,
                    TextInputType.name,
                    false,
                    Colors.white,
                    Colors.black,
                    15,
                    false),
                inputtex(
                    context,
                    _controller,
                    50,
                    width(context),
                    1,
                    60,
                    "Email : ${user!["email"]}",
                    Icons.mail_lock,
                    TextInputType.name,
                    false,
                    Colors.white,
                    Colors.black,
                    15,
                    false),
                inputtex(
                    context,
                    _controller,
                    50,
                    width(context),
                    1,
                    60,
                    "Puan : ${user!["money"]}",
                    CupertinoIcons.money_dollar,
                    TextInputType.name,
                    false,
                    Colors.white,
                    Colors.black,
                    15,
                    false),
                inputtex(
                    context,
                    _controller,
                    50,
                    width(context),
                    1,
                    60,
                    "Yaptığı Görev Sayısı : ${user!["mymissions"].length.toString()}",
                    Icons.work_history_outlined,
                    TextInputType.name,
                    false,
                    Colors.white,
                    Colors.black,
                    15,
                    false),
              ],
            ),
    );
  }
}
