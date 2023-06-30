import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class qrcode extends StatefulWidget {
  final snap;
  const qrcode({super.key, required this.snap});

  @override
  State<qrcode> createState() => _qrcodeState();
}

class _qrcodeState extends State<qrcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "QRCODE",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: QrImageView(
          data:
              'Ad-Soyad : ${widget.snap["name"]}  ${widget.snap["surname"]}\n email: ${widget.snap["email"]}',
          version: QrVersions.auto,
          size: 320,
          gapless: false,
          embeddedImage: AssetImage('assets/logo.png'),
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: Size(80, 80),
          ),
        ),
      ),
    );
  }
}
