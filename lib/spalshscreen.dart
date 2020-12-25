import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart'; // Do not forget the declare this importation in the pupspec.yaml file in your IDE
import 'login.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false, //you can remove if you want
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SplashScreen(
      gradientBackground: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.4, 0.6, 0.8],
        colors: [Colors.green,Colors.cyan],
      ),

      seconds: 10,
      backgroundColor: Colors.cyan[50],
      image: Image.asset(
          "assets/images/egelogoyazı.png"), // Do not forget the declare the image into the pubspec.yaml
      loaderColor: Colors.green[800],
      photoSize: 125.0,
      navigateAfterSeconds: Login(),
    );
  }
}

class MainScreen extends StatelessWidget {
  //the class  must be consist StateFull widget espically for Login Page
  @override // so you need to reformat code
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Welcome To The Mustafa's Screen"),
      ),
      body: Center(
          child: (Text(
        "Fill  your own codes entire this page ",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ))),
    );
  }
}
