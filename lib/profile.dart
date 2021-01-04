import 'package:act0ne/signin.dart';
import 'package:act0ne/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:act0ne/authentication_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Profile(),
    );
  }
}

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
                backgroundColor: Colors.deepOrange[700],
                radius: 100,
                child: FutureBuilder(
                    future: _getImage(context, "avatar2.png"),
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
                /// SETTINGS BUTTON TAP
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(15.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Text(
                        "SETTINGS",
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      "ABOUT US",
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                /// LOG OUT BUTTON TAP
                onTap: () {
                  context.read<AuthenticationService>().signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
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
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
