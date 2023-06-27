import 'dart:math';
import 'dart:typed_data';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lif001/global/size.dart';
import 'package:lif001/global/textedit.dart';
import 'package:lif001/services/firestore_methods.dart';
import 'package:lif001/utils/utils.dart';

import '../../global/elevatedButton.dart';
import '../../global/utils.dart';

class answer_page extends StatefulWidget {
  final snap;
  const answer_page({super.key, required this.snap});

  @override
  State<answer_page> createState() => _answer_pageState();
}

class _answer_pageState extends State<answer_page> {
  late ConfettiController _confettiController;
  TextEditingController _answer = TextEditingController();
  Uint8List? _image;
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cevap"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.snap["soru"].toString().toUpperCase() + " ?",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      widget.snap["type"] == 1
                          ? Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      strokeAlign: 1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: TextField(
                                    maxLines: 20,
                                    controller: _answer,
                                    decoration: InputDecoration(
                                      labelText: "Lütfen Cevabınızı Yazınız..",
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(),
                                  )),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                Stack(
                                  children: [
                                    _image != null
                                        ? InkWell(
                                            onTap: selectImage,
                                            child: Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: MemoryImage(_image!),
                                              )),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: selectImage,
                                            child: Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://www.pngarts.com/files/2/Upload-PNG-Transparent-Image.png'),
                                              )),
                                            ),
                                          ),
                                  ],
                                ),
                                Text(
                                  "Fotoğraf yükleyiniz",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomElevatedButton(
                        text: "Ödülü Kazan",
                        icon: Icons.money_outlined,
                        onPressed: () async {
                          String? res = "";
                          if (widget.snap["type"] == 1) {
                            if (_answer.text.isEmpty) {
                              showSnackBar(
                                  context, "Lütfen soruyu cevaplayınız....");
                            } else {
                              _confettiController.play();
                              await firestoreservices()
                                  .missionaccepttext(widget.snap, _answer.text);
                            }
                          } else {
                            if (_image!.isEmpty) {
                              showSnackBar(
                                  context, "Lütfen soruyu cevaplayınız....");
                            } else {
                              await firestoreservices()
                                  .missionacceptimage(widget.snap, _image!);
                            }
                          }
                          showSnackBar(context, "Görev Tamamlandı :)");
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: -pi / 2,
                emissionFrequency: 0.2,
                numberOfParticles: 20,
                blastDirectionality: BlastDirectionality.explosive,
              ),
            )
          ],
        ),
      ),
    );
  }
}
