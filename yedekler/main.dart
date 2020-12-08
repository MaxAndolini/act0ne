import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Image dogPic = Image.asset(
      'assets/images/dog.png',
      width: 170,
    );
    Image envPic = Image.asset(
      'assets/images/env.png',
      width: 120,
    );
    Image seaPic = Image.asset('assets/images/sea.png', width: 90);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
          ],
        ),
        backgroundColor: Colors.lightBlue[300],
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Transform.rotate(
                child: dogPic,
                angle:1/3,
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Transform.rotate(
                child: envPic,
                angle:-1/6,
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Transform.rotate(
                child: seaPic,
                angle:-1/3,
              ),
            )
          ],
        ));
  }
}
