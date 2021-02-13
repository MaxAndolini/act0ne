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
                return Center(child: new CircularProgressIndicator());
              }
              var document = snapshot.data;
              return new ListView(children: [
                Container(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FutureBuilder(
                                future: _getImage(context, document["image"]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return CircleAvatar(
                                        radius: 85,
                                        backgroundColor: Colors.grey,
                                        child: CircleAvatar(
                                            radius: 80,
                                            backgroundImage: snapshot.data));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircleAvatar(
                                        radius: 85,
                                        backgroundColor: Colors.grey,
                                        child: CircleAvatar(radius: 80));
                                  }
                                  return Container();
                                }),
                            Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                    document["name"] +
                                        " " +
                                        document["surname"],
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                10))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Text(
                                    document['token'].toString(),
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                10),
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/icons/token.png",
                                  fit: BoxFit.contain,
                                  width: MediaQuery.of(context).size.width / 10,
                                )
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 20),
                                width: MediaQuery.of(context).size.width / 2,
                                child: RaisedButton(
                                  onPressed: () {
                                    context
                                        .read<AuthenticationService>()
                                        .signOut(context);
                                  },
                                  child: Text(
                                    "Log Out",
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  color: Colors.orange[100],
                                ))
                          ],
                        )))
              ]);
            }));
  }

  Future<Object> _getImage(BuildContext context, String imageName) async {
    ImageProvider image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = NetworkImage(value.toString());
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
