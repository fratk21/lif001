import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lif001/global/colors.dart';
import 'package:lif001/global/elevatedButton.dart';
import 'package:lif001/global/size.dart';
import 'package:lif001/global/textedit.dart';
import 'package:random_avatar/random_avatar.dart';

class avatarAndUsername extends StatefulWidget {
  const avatarAndUsername({super.key});

  @override
  State<avatarAndUsername> createState() => _avatarAndUsernameState();
}

class _avatarAndUsernameState extends State<avatarAndUsername> {
  final TextEditingController _controller = TextEditingController();
  @override
  String svgCode = RandomAvatarString('saytoonz', trBackground: true);

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
                width: 500,
                height: 500,
              ),
              Container(
                width: 150,
                child: CustomElevatedButton(
                  text: "Generate",
                  icon: Icons.gesture_rounded,
                  onPressed: () {
                    String svg = RandomAvatarString(
                      DateTime.now().toIso8601String(),
                      trBackground: true,
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
                  _controller,
                  50,
                  width(context),
                  1,
                  50,
                  "username",
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
              CustomElevatedButton(
                text: "Devam Et",
                icon: Icons.arrow_forward_ios,
                onPressed: () {
                  String svg = RandomAvatarString(
                    DateTime.now().toIso8601String(),
                    trBackground: true,
                  );
                  setState(() {
                    svgCode = svg;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
