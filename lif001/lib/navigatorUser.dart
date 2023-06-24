import 'package:flutter/material.dart';
import 'package:lif001/pages/LoginAndRegister/LoginAndRegister.dart';
import 'package:lif001/pages/home/home.dart';
import 'package:lif001/pages/onboarding/onboarding.dart';
import 'package:lif001/pages/profile/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class navigatorUser extends StatefulWidget {
  const navigatorUser({super.key});

  @override
  State<navigatorUser> createState() => _navigatorUserState();
}

class _navigatorUserState extends State<navigatorUser> {
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
        physics: NeverScrollableScrollPhysics(),
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
            title: Text("Görevlerim"),
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

List<Widget> homeScreenItems = [homepages(), profilepages()];
