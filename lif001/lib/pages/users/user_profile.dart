import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                ],
              ),
      ),
    );
  }
}
