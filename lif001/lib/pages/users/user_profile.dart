import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lif001/pages/users/notif.dart';
import 'package:lif001/pages/users/qrcode.dart';
import 'package:lif001/pages/users/user_missions.dart';
import 'package:lif001/pages/users/users_info.dart';
import 'package:lif001/utils/utils.dart';

import '../../services/data.dart';

class user_profile extends StatefulWidget {
  final uid;
  const user_profile({super.key, required this.uid});

  @override
  State<user_profile> createState() => _user_profileState();
}

class _user_profileState extends State<user_profile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: isLoading == false
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  // User card
                  SmallUserCard(
                    cardColor: Colors.red,
                    userName: user!['name'] + ' ' + user!['surname'],
                    userProfilePic: SvgPicture.string(
                      user!['avatar'],
                      width: 250,
                      height: 250,
                    ),
                    onTap: () {},
                  ),

                  SettingsGroup(
                    settingsGroupTitle: "Kullanıcı Bilgileri",
                    items: [
                      SettingsItem(
                        onTap: () {},
                        icons: CupertinoIcons.money_dollar,
                        iconStyle: IconStyle(),
                        title: 'Puan',
                        subtitle: user!['money'].toString(),
                      ),
                      SettingsItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => qrcode(snap: user),
                              ));
                        },
                        icons: CupertinoIcons.qrcode,
                        iconStyle: IconStyle(),
                        title: 'QrCode',
                        subtitle: "Kullanıcının Qrcodunu görün",
                      ),
                      SettingsItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    user_info(uid: widget.uid),
                              ));
                        },
                        icons: Icons.account_tree_rounded,
                        iconStyle:
                            IconStyle(backgroundColor: Colors.yellow[600]),
                        title: 'Kullanıcı Bilgileri',
                        subtitle: "Kullanıcının bilgilerini göster",
                      ),
                      SettingsItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    notif_screen(uid: widget.uid),
                              ));
                        },
                        icons: Icons.notification_add,
                        iconStyle: IconStyle(
                          backgroundColor: Colors.green,
                        ),
                        title: 'Bildirim yolla',
                        subtitle: "Kullanıcıya bildirim yolla ",
                      ),
                      SettingsItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    user_missions(uid: widget.uid),
                              ));
                        },
                        icons: Icons.contacts_rounded,
                        iconStyle: IconStyle(
                          backgroundColor: Colors.purple,
                        ),
                        title: 'Görevler',
                        subtitle: "Kullanıcının yaptığı görevleri görüntüle",
                      ),
                    ],
                  ),
                  SettingsGroup(
                      settingsGroupTitle: "Kullanıcı İşlemleri",
                      items: [
                        SettingsItem(
                          onTap: () async {
                            await FireBaseData().deleteAccount(widget.uid);
                            showSnackBar(context, "Kullanıcı Banlandı");
                          },
                          icons: Icons.delete_forever,
                          iconStyle: IconStyle(
                            backgroundColor: Colors.red,
                          ),
                          title: 'Kullanıcıyı Banla',
                        ),
                      ])
                ],
              ),
      ),
    );
  }
}
