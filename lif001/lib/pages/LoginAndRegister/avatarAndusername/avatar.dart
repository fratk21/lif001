import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lif001/global/colors.dart';
import 'package:lif001/global/elevatedButton.dart';
import 'package:lif001/global/size.dart';
import 'package:lif001/global/textedit.dart';
import 'package:lif001/routes/routes.dart';
import 'package:lif001/services/userdetail.dart';
import 'package:random_avatar/random_avatar.dart';

class avatarAndUsername extends StatefulWidget {
  const avatarAndUsername({super.key});

  @override
  State<avatarAndUsername> createState() => _avatarAndUsernameState();
}

class _avatarAndUsernameState extends State<avatarAndUsername> {
  final TextEditingController _controllerad = TextEditingController();
  final TextEditingController _controllersoyad = TextEditingController();
  final TextEditingController _controllerref = TextEditingController();

  @override
  String svgCode = RandomAvatarString('saytoonz', trBackground: false);
  String selectedGender = "Erkek";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SvgPicture.string(
                svgCode,
                width: 250,
                height: 250,
              ),
              Container(
                width: 180,
                child: CustomElevatedButton(
                  text: "Avatar Oluştur",
                  icon: Icons.gesture_rounded,
                  onPressed: () {
                    String svg = RandomAvatarString(
                      DateTime.now().toIso8601String(),
                      trBackground: false,
                    );
                    setState(() {
                      svgCode = svg;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              inputtex(
                  context,
                  _controllerad,
                  50,
                  width(context),
                  1,
                  50,
                  "Adınız",
                  Icons.person,
                  TextInputType.name,
                  false,
                  Colors.white,
                  orange,
                  15,
                  true),
              SizedBox(
                height: 10,
              ),
              inputtex(
                  context,
                  _controllersoyad,
                  50,
                  width(context),
                  1,
                  50,
                  "Soyadınız",
                  Icons.person,
                  TextInputType.name,
                  false,
                  Colors.white,
                  orange,
                  15,
                  true),
              SizedBox(
                height: 10,
              ),
              inputtex(
                  context,
                  _controllerref,
                  50,
                  width(context),
                  1,
                  50,
                  "Referans No",
                  Icons.person,
                  TextInputType.name,
                  false,
                  Colors.white,
                  orange,
                  15,
                  true),
              SizedBox(
                height: (MediaQuery.of(context).size.height / 2) - 200,
              ),
              CustomElevatedButton(
                text: "Devam Et",
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  userdetailservices().registerone(
                      _controllerad.text,
                      _controllersoyad.text,
                      _controllerref.text,
                      svgCode,
                      context);
                  routes().login(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
