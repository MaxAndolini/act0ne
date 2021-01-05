import 'package:act0ne/Market.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'tasks.dart';
import 'profile.dart';

void main() {
  runApp(Beginning());
}

class Beginning extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navi Connection (Working on)',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Begin(),
    );
  }
}

class Begin extends StatefulWidget {
  @override
  _BeginState createState() => _BeginState();
}

class _BeginState extends State<Begin> {
  int positionNumber = 0;
  List<Widget> pages;

  void initState() {
    super.initState();

    pages = [
      Home(),
      Tasks(),
      Market(),
      Profile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[positionNumber],
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.deepOrange[900],
              Colors.white
            ]))),
        title: Image.asset(
          "assets/images/egelogouc.png",
          fit: BoxFit.cover,
          width: 150,
        ),
        // actions: [ for tickets ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: positionNumber,
        selectedItemColor: Colors.deepOrange[600],
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/icons/Home.png"),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/icons/Task.png"),
            ),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/icons/Store.png"),
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/icons/profile.png"),
            ),
            label: 'Profile',
          ),
        ],
        onTap: (int selectedPageNumber) {
          setState(() {
            positionNumber = selectedPageNumber;
          });
        },
      ),
    );
  }
}
