import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:lif001/global/size.dart';
import 'package:lif001/pages/answer/answer.dart';
import 'package:lif001/services/firestore_methods.dart';

firestoreservices _firestoreservices = firestoreservices();
Widget user_mission_card(snap, BuildContext context) {
  var options = Options(format: Format.rgbArray, luminosity: Luminosity.light);
  var color = RandomColor.getColor(options);
  final controller = FlipCardController();
  // Flip the card programmatically
  int randomNumber = Random().nextInt(6) + 1;
  int randomNumber2 = Random().nextInt(6) + 1;
  controller.flipcard();
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FlipCard(
      rotateSide: RotateSide.top,
      onTapFlipping:
          true, //When enabled, the card will flip automatically when touched.
      axis: FlipAxis.vertical,
      controller: controller,
      frontWidget: Card(
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none),
        color: Color.fromARGB(255, color[0], color[1], color[2]),
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              " ",
              style: TextStyle(fontSize: 20),
            ),
            Container(
                height: 200,
                child: Image.asset('assets/cards/$randomNumber.png',
                    fit: BoxFit.cover)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      'assets/cards/award.png',
                    )),
                Text(
                  snap["puan"].toString() + " Puanlık soru için tıklayınız..",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )
              ],
            )
          ],
        ),
      ),
      backWidget: Card(
        color: Color.fromARGB(255, color[0], color[1], color[2]),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none),
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              snap["soru"] + "?",
              style: TextStyle(fontSize: 20),
            ),
            Container(
                height: 200,
                child: Image.asset('assets/cards/$randomNumber2.png',
                    fit: BoxFit.cover)),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => answer_page(snap: snap),
                      ));
                },
                child: Text("Soruyu Cevapla"))
          ],
        ),
      ),
    ),
  );
}
