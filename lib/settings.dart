import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            var document = snapshot.data;
            return new Container(
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
                            style: TextStyle(
                                fontSize: 40, color: Colors.grey[800])),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(3.0),
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            Text(
                              "Name:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.height / 3.6,
                                child: TextField(
                                  style: TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                    hintText: document["name"],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(3.0),
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            Text(
                              "Surname:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.height / 3.6,
                                child: TextField(
                                  style: TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                    hintText: document["surname"],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(3.0),
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            Text(
                              "Birthday:",
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.height / 3.6,
                                child: TextField(
                                  style: TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                    hintText: document["birthday"],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.all(3.0),
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          children: [
                            Text(
                              "Change Avatar",style:TextStyle(fontSize: 20)
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            );
          }),
    );
  }
}
