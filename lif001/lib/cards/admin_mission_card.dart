import 'package:flutter/material.dart';
import 'package:lif001/global/size.dart';
import 'package:lif001/services/firestore_methods.dart';

firestoreservices _firestoreservices = firestoreservices();
Widget admin_mission_card(snap, BuildContext context) {
  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(20),
                  child: snap["type"] == 1
                      ? Image(
                          image: AssetImage("assets/text.png"),
                          fit: BoxFit.cover)
                      : Image(
                          image: AssetImage("assets/image.png"),
                          fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                richtext('Görev Adı:', snap["gorevadi"]),
                richtext('Soru:', snap["soru"]),
                richtext('Puan:', snap["puan"].toString()),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ClipRect(
          child: Row(
            children: [
              SizedBox(
                width: width(context) / 2 - 14,
                height: 34,
                child: ElevatedButton.icon(
                    onPressed: () {
                      _firestoreservices.mission_state(snap);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          snap["state"] == 1 ? Colors.black : Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    icon: snap["state"] == 1
                        ? Icon(Icons.close)
                        : Icon(Icons.check),
                    label:
                        Text(snap["state"] == 1 ? "Pasife Al" : "Aktif Yap")),
              ),
              SizedBox(
                width: width(context) / 2 - 14,
                height: 34,
                child: ElevatedButton.icon(
                    onPressed: () {
                      _firestoreservices.mission_delete(snap["missionid"]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(20)),
                      ),
                    ),
                    icon: Icon(Icons.delete_forever),
                    label: Text("Sil")),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget richtext(String kalin, String ince) {
  return Container(
    width: 220,
    child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: kalin,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          TextSpan(
            text: ince,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
