
import 'package:act0ne/authentication_service.dart';
import 'package:act0ne/user/market.dart';
import 'package:act0ne/user/tasks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin/ahome.dart';
import 'admin/ausers.dart';
import 'user/home.dart';
import 'user/profile_selector.dart';

class Begin extends StatefulWidget {
  @override
  _BeginState createState() => _BeginState();
}

class _BeginState extends State<Begin> {
  int positionNumber = 0;
  List<Widget> pages, pages2;

  void initState() {
    super.initState();

    pages = [
      Home(),
      Tasks(),
      Market(),
      ProfileSelector(),
    ];

    pages2 = [
      AHome(),
      AUsers(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new CircularProgressIndicator();
              }
              var document = snapshot.data;
              return document["admin"] == 0
                  ? pages[positionNumber]
                  : pages2[positionNumber];
            }),
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.deepOrange[900], Colors.white]))),
          title: Image.asset(
            "assets/images/egelogouc.png",
            fit: BoxFit.cover,
            width: 150,
          ),
          actions: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return new CircularProgressIndicator();
                  }
                  var document = snapshot.data;
                  return document["admin"] == 0
                      ? Container(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(document["token"].toString(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ),
                              Image.asset(
                                "assets/images/icons/token.png",
                                fit: BoxFit.contain,
                                width: 32,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width / 4.6,
                          child: RaisedButton(
                            onPressed: () {
                              context
                                  .read<AuthenticationService>()
                                  .signOut(context);
                            },
                            child: Text(
                              "Log Out",
                              style: TextStyle(fontSize: 15),
                            ),
                            color: Colors.deepOrange[400],
                          ),
                        );
                })
          ],
        ),
        bottomNavigationBar: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new CircularProgressIndicator();
              }
              var document = snapshot.data;
              return document["admin"] == 0
                  ? BottomNavigationBar(
                      currentIndex: positionNumber,
                      selectedItemColor: Colors.deepOrange[600],
                      type: BottomNavigationBarType.fixed,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/images/icons/Home.png"),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/images/icons/Task.png"),
                          ),
                          label: 'Task',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/images/icons/Store.png"),
                          ),
                          label: 'Store',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/images/icons/profile.png"),
                          ),
                          label: 'Profile',
                        ),
                      ],
                      onTap: (int selectedPageNumber) {
                        setState(() {
                          positionNumber = selectedPageNumber;
                        });
                      },
                    )
                  : BottomNavigationBar(
                      currentIndex: positionNumber,
                      selectedItemColor: Colors.deepOrange[600],
                      type: BottomNavigationBarType.fixed,
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/images/icons/Home.png"),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/images/icons/profile.png"),
                          ),
                          label: 'Users',
                        ),
                      ],
                      onTap: (int selectedPageNumber) {
                        setState(() {
                          positionNumber = selectedPageNumber;
                        });
                      },
                    );
            }));
  }
}
