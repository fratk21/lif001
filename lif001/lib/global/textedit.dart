import 'package:flutter/material.dart';

import 'colors.dart';

Widget inputtex(
    BuildContext context,
    TextEditingController control,
    double height,
    double width,
    int maxline,
    int maxLengh,
    String hinttext,
    IconData icons,
    TextInputType texttip,
    bool gizli,
    Color color,
    Color color2,
    double elevation,
    bool enabled) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: elevation,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Icon(
            icons,
            color: color2,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            enabled: enabled,
            keyboardType: texttip,
            obscureText: gizli,
            maxLines: maxline,
            controller: control,
            cursorColor: color2,
            decoration: InputDecoration(
              labelText: hinttext,
              border: InputBorder.none,
            ),
            style: TextStyle(),
          )),
        ],
      ),
    ),
  );
}
