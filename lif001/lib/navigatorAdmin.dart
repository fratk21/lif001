import 'package:flutter/material.dart';
import 'package:lif001/pages/LoginAndRegister/LoginAndRegister.dart';
import 'package:lif001/pages/profileadmin/profileadmin.dart';
import 'package:lif001/pages/users/user.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class navigatorAdmin extends StatefulWidget {
  const navigatorAdmin({super.key});

  @override
  State<navigatorAdmin> createState() => _navigatorAdminState();
}

class _navigatorAdminState extends State<navigatorAdmin> {
  int _selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() {
          _selectedIndex = i;
          pageController.jumpToPage(_selectedIndex);
        }),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Kullanıcılar"),
            selectedColor: Colors.purple,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profil"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

List<Widget> homeScreenItems = [userspage(), profileadmin()];
