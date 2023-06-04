import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:lif001/pages/LoginAndRegister/avatarAndusername/avatar.dart';
import 'package:lif001/pages/onboarding/onboarding.dart';
import 'package:lif001/services/auth.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class _loginpageState extends State<loginpage> {
  Duration get loginTime => Duration(milliseconds: 2250);
  auth_services _auth = auth_services();

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    //   return Future.delayed(loginTime).then((_) async {
    //     String? res = await _auth.login(data.name, data.password);
    //     return res;
//    });
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      String? res = await _auth.register(data.name, data.password);
      return res;
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
    return FlutterLogin(
      title: 'ECORP',
      logo: AssetImage('assets/1.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => avatarAndUsername(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
