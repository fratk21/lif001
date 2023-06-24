import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lif001/global/size.dart';
import 'package:lif001/global/textedit.dart';

import '../../global/elevatedButton.dart';
import '../../global/utils.dart';

class answer_page extends StatefulWidget {
  final snap;
  const answer_page({super.key, required this.snap});

  @override
  State<answer_page> createState() => _answer_pageState();
}

class _answer_pageState extends State<answer_page> {
  TextEditingController _answer = TextEditingController();
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cevap"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
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
                                width: 5,
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
                    text: "Görev Oluştur",
                    icon: Icons.arrow_forward_ios,
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
