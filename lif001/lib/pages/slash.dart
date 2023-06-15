import 'package:flutter/material.dart';

import '../routes/routes.dart';

class slash extends StatefulWidget {
  const slash({super.key});

  @override
  State<slash> createState() => _slashState();
}

class _slashState extends State<slash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    routes().login(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
