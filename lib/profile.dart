import 'dart:ffi';

import 'package:act0ne/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Image my_image_url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return new ListView(children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 100,
                          child: Image.network(document['image']),
                        ),
                        SizedBox(height: 30),
                        Text(document['name']+" "+document['surname'],style: TextStyle(fontSize: 30),),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            context
                                .read<AuthenticationService>()
                                .signOut(context);
                          },
                          child: Container(
                            margin: EdgeInsets.all(15.0),
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: Row(
                              children: [
                                Text(
                                  "LOG OUT",
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            }));
  }

 
}
