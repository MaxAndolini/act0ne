import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var name;
  var surname;

  Future<void> getData() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        name = event.get("name");
        surname = event.get("surname");
        print(name);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height / 1.4,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text("SETTINGS",
                      style: TextStyle(fontSize: 40, color: Colors.grey[800])),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(3.0),
                  padding: EdgeInsets.all(15.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Text(
                        "Name:",
                      ),
                      Container(
                          width: MediaQuery.of(context).size.height / 3.6,
                          child: TextField())
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(3.0),
                  padding: EdgeInsets.all(15.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Text(
                        "Surname: ",
                      ),
                      Container(
                          width: MediaQuery.of(context).size.height / 3.6,
                          child: TextField())
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(3.0),
                  padding: EdgeInsets.all(15.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Text(
                        "Birthday:",
                      ),
                      Container(
                          width: MediaQuery.of(context).size.height / 3.6,
                          child: TextField())
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(3.0),
                  padding: EdgeInsets.all(15.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Text(
                        "E-Mail: ",
                      ),
                      Container(
                          width: MediaQuery.of(context).size.height / 3.6,
                          child: TextField())
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.all(3.0),
                  padding: EdgeInsets.all(15.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Text(
                        "Change Avatar",
                      ),
                      Container(
                          width: MediaQuery.of(context).size.height / 3.6,
                          child: TextField())
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
