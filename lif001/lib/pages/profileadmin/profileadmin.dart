import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lif001/pages/missions/missions.dart';

import '../../services/data.dart';
import '../LoginAndRegister/LoginAndRegister.dart';

class profileadmin extends StatefulWidget {
  const profileadmin({super.key});

  @override
  State<profileadmin> createState() => _profileadminState();
}

class _profileadminState extends State<profileadmin> {
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => missions_page(),
                            ));
                      },
                      icons: CupertinoIcons.chart_bar,
                      iconStyle: IconStyle(),
                      title: 'Missions',
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
                  ],
                ),
              ],
            ),
    );
  }
}
