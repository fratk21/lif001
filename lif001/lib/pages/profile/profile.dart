import 'dart:ui';

import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lif001/pages/LoginAndRegister/LoginAndRegister.dart';

import '../../routes/routes.dart';
import '../../services/data.dart';

class profilepages extends StatefulWidget {
  const profilepages({super.key});

  @override
  State<profilepages> createState() => _profilepagesState();
}

class _profilepagesState extends State<profilepages> {
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
    return Padding(
      padding: const EdgeInsets.all(10),
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
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: CupertinoIcons.money_dollar,
                      iconStyle: IconStyle(),
                      title: 'Points',
                      subtitle: user!['money'].toString(),
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.info_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'About',
                      subtitle: "Learn more about LIF3",
                    ),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.contacts_rounded,
                      iconStyle: IconStyle(
                        backgroundColor: Colors.purple,
                      ),
                      title: 'Kvkk',
                      subtitle: "Kvkk contracts",
                    ),
                  ],
                ),
                // You can add a settings title
                SettingsGroup(
                  settingsGroupTitle: "Account",
                  items: [
                    SettingsItem(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const loginpage()),
                            (Route route) => false);
                      },
                      icons: Icons.exit_to_app_rounded,
                      title: "Sign Out",
                    ),
                    SettingsItem(
                      onTap: () async {
                        await FireBaseData().freezeAccount(
                            FirebaseAuth.instance.currentUser!.uid);
                        if (!mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const loginpage()),
                            (Route route) => false);
                      },
                      icons: CupertinoIcons.snow,
                      title: "Freeze Account",
                      titleStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SettingsItem(
                      onTap: () async {
                        await FireBaseData().deleteAccount(
                            FirebaseAuth.instance.currentUser!.uid);
                        if (!mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const loginpage()),
                            (Route route) => false);
                      },
                      icons: CupertinoIcons.delete_solid,
                      title: "Delete Account",
                      titleStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
