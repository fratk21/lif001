import 'package:flutter/material.dart';

import '../../global/colors.dart';
import '../../global/elevatedButton.dart';
import '../../global/size.dart';
import '../../global/textedit.dart';

class missions_add extends StatefulWidget {
  const missions_add({super.key});

  @override
  State<missions_add> createState() => _missions_addState();
}

class _missions_addState extends State<missions_add> {
  bool radiobutton_image = false;
  bool radiobutton_text = false;
  int selectedvalue = 1;
  TextEditingController _gorevadi = TextEditingController();
  TextEditingController _gorevsorusu = TextEditingController();
  TextEditingController _gorevpuani = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görev Oluştur"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Image.asset("assets/text.png"),
                          value: 1,
                          groupValue: selectedvalue,
                          onChanged: (values) {
                            radiohandle(values!);
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Image.asset("assets/image.png"),
                          value: 2,
                          groupValue: selectedvalue,
                          onChanged: (values) {
                            radiohandle(values!);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  inputtex(
                      context,
                      _gorevadi,
                      50,
                      width(context),
                      1,
                      50,
                      "Görev Adı",
                      Icons.add_chart,
                      TextInputType.name,
                      false,
                      Colors.white,
                      Colors.blue,
                      15,
                      true),
                  inputtex(
                      context,
                      _gorevsorusu,
                      50,
                      width(context),
                      1,
                      50,
                      "Görev Sorusu",
                      Icons.question_mark_outlined,
                      TextInputType.name,
                      false,
                      Colors.white,
                      Colors.blue,
                      15,
                      true),
                  inputtex(
                      context,
                      _gorevpuani,
                      50,
                      width(context),
                      1,
                      50,
                      "Görev Puanı",
                      Icons.star,
                      TextInputType.number,
                      false,
                      Colors.white,
                      Colors.blue,
                      15,
                      true),
                ],
              ),
              Column(
                children: [
                  CustomElevatedButton(
                    text: "Görev Oluştur",
                    icon: Icons.arrow_forward_ios,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int radiobuttonvalue() {
    if (radiobutton_image) {
      return 1;
    } else if (radiobutton_text) {
      return 2;
    } else {
      return 0;
    }
  }

  void radiohandle(int value) {
    setState(() {
      selectedvalue = value;
    });
  }
}
