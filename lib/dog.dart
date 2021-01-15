import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Dog extends StatefulWidget {
  @override
  _DogState createState() => _DogState();
}

class _DogState extends State<Dog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('market_items')
              .doc('ln7hUZU7RMAvRX2oUtV8')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            var docData = snapshot.data;
            return Container(
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(color: Colors.deepOrange[100]),
                      child: Column(
                        children: [
                          Text(docData['dog_item1']),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 100,
                              child: FutureBuilder(
                                  future:
                                      _getImage(context, docData["photo1"]),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: snapshot.data,
                                      );
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Container();
                                  }),
                            ),
                          ),
                          Text(docData['price1'])
                        ],
                      ),
                    ),
                    Container(
                      child: Text(docData['dog_item2'] +
                          ": " +
                          docData['price2'] +
                          docData['photo2']),
                    ),
                    Container(
                      child: Text(docData['dog_item3'] +
                          ": " +
                          docData['price3'] +
                          docData['photo3']),
                    ),
                    Container(
                      child: Text(docData['dog_item4'] +
                          ": " +
                          docData['price4'] +
                          docData['photo4']),
                    ),
                    Container(
                      child: Text(docData['dog_item5'] +
                          ": " +
                          docData['price5'] +
                          docData['photo5']),
                    ),
                    Container(
                      child: Text(docData['dog_item6'] +
                          ": " +
                          docData['price6'] +
                          docData['photo6']),
                    ),
                    Container(
                      child: Text(docData['dog_item7'] +
                          ": " +
                          docData['price7'] +
                          docData['photo7']),
                    ),
                  ],
                ),
              ]),
            );
          }),
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(value.toString(), fit: BoxFit.scaleDown);
    });
    return image;
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
