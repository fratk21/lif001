import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lif001/pages/users/user_profile.dart';
import 'package:lif001/services/data.dart';

class userspage extends StatefulWidget {
  const userspage({super.key});

  @override
  State<userspage> createState() => _userspageState();
}

class _userspageState extends State<userspage> {
  FireBaseData firestoreService = FireBaseData();
  List<Map<String, dynamic>> userList = [];
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

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
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Icon(Icons.search, color: Colors.black),
        title: TextFormField(
          cursorColor: Colors.black,
          style: TextStyle(color: Colors.black),
          controller: searchController,
          decoration: const InputDecoration(
              labelText: 'Kullanıcı ara...',
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: "DancingScript-VariableFont_wght",
                  fontWeight: FontWeight.bold)),
          onFieldSubmitted: (String _) {
            setState(() {
              if (searchController.text == "") {
                isShowUsers = false;
              } else {
                isShowUsers = true;
              }
            });
            print(_);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.send, color: Colors.black))
        ],
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'name',
                    isGreaterThanOrEqualTo: searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => user_profile(
                                  uid: (snapshot.data! as dynamic).docs[index]
                                      ["uid"]),
                            ));
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          leading: SvgPicture.string(
                            (snapshot.data! as dynamic).docs[index]['avatar'],
                            width: 50,
                            height: 50,
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]['name'],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : userList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> user = userList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  user_profile(uid: user["uid"]),
                            ));
                      },
                      child: ListTile(
                        leading: SvgPicture.string(
                          user['avatar'],
                          width: 50,
                          height: 50,
                        ),
                        title: Text(user['name'] + ' ' + user['surname']),
                        subtitle: Text(user['email']),
                        trailing: Text('Point: ${user['money']}'),
                        tileColor: user["state"] == 1
                            ? Colors.green[100]
                            : user["state"] == 2
                                ? Colors.yellow
                                : user["state"] == 0
                                    ? Colors.blue[100]
                                    : Colors.red[100],
                      ),
                    );
                  },
                ),
    );
  }
}
