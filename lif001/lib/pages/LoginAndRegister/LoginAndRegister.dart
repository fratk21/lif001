import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:lif001/pages/LoginAndRegister/avatarAndusername/avatar.dart';
import 'package:lif001/pages/onboarding/onboarding.dart';
import 'package:lif001/routes/routes.dart';
import 'package:lif001/services/auth.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  Duration get loginTime => Duration(milliseconds: 2250);
  auth_services _auth = auth_services();

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      String? res = await _auth.login(data.name, data.password);
      routes().login(context);
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      String? res = await _auth.register(data.name, data.password);
      routes().login(context);
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) async {
      String? res = await _auth.ResetPassword(name);
      return res!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FlutterLogin(
        title: 'LIF3',
        logo: AssetImage('assets/logo.png'),
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {},
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
