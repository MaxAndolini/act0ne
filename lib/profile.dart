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
  String username;
  String surname;

  void getData() async {
    var docRef = FirebaseFirestore.instance
        .collection('users')
        .doc('C91Z6pmKD0hE1MQTSkIu');
    var docSnap = await docRef.get();
    var docData = docSnap.data();
    username = docData['name'];
    surname = docData['surname'];
    print(username);
  }

  @override
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 100,
                child: FutureBuilder(
                    future: _getImage(context, "user.png"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: snapshot.data,
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container();
                    }),
              ),
              SizedBox(height: 30),
              Text(
                username + " " + surname,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 30),
              InkWell(
                /// LOG OUT BUTTON TAP
                onTap: () {
                  context.read<AuthenticationService>().signOut(context);
                },
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
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
