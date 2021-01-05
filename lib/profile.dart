import 'package:act0ne/authentication_service.dart';
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
