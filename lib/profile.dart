import 'package:act0ne/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:act0ne/authentication_service.dart';

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

class Profile extends StatelessWidget {
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
                child: Icon(
                  Icons.people_alt_rounded,
                ),
              ),
              SizedBox(height: 30),
              Container(
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
}
