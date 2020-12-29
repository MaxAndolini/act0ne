import 'package:act0ne/main.dart';
import 'package:act0ne/signin.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SplashScreen(
      gradientBackground: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.deepOrange[900], Colors.deepOrange[100]],
      ),

      seconds: 3,
      image: Image.asset(
          "assets/images/egelogouc.png"), // Do not forget the declare the image into the pubspec.yaml
      loaderColor: Colors.black,
      photoSize: 125.0,
      navigateAfterSeconds: SignIn(),
    );
  }
}
