import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lif001/services/data.dart';

class userspage extends StatefulWidget {
  const userspage({super.key});

  @override
  State<userspage> createState() => _userspageState();
}

class _userspageState extends State<userspage> {
  FireBaseData firestoreService = FireBaseData();
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    List<Map<String, dynamic>> users = await firestoreService.getUsers();
    setState(() {
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> user = userList[index];
                return ListTile(
                  leading: SvgPicture.string(
                    user['avatar'],
                    width: 50,
                    height: 50,
                  ),
                  title: Text(user['name'] + ' ' + user['surname']),
                  subtitle: Text(user['email']),
                  trailing: Text('Point: ${user['money']}'),
                );
              },
            ),
    );
  }
}
