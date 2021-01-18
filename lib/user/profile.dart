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
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 100,
                          child: FutureBuilder(
                              future: _getImage(context, document["image"]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: MediaQuery.of(context).size.height /
                                        1.2,
                                    child: snapshot.data,
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: MediaQuery.of(context).size.height /
                                        1.2,
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Container();
                              }),
                        ),
                        Text(
                          document["name"] + " " + document["surname"],
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 10),
                        ),
                        SizedBox(height: 30),
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
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        SizedBox(
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]);
            }));
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
