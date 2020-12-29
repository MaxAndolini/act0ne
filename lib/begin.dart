import 'package:act0ne/Market.dart';
import 'package:act0ne/signin.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'tasks.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navi Connection (Working on)',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
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
      drawer: Drawer(
          child: ListView(

            children: <Widget>[
              DrawerHeader(
                child:CircleAvatar(

                  backgroundImage:AssetImage("assets/images/egelogo.png" , ) ,  // Here Profile picture comes
                  minRadius: 30.3,
                  backgroundColor:Colors.indigo,
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
              ),
              Card(

                child: ListTile(
                  title: Text("Explore" ) ,
                  trailing: Icon(Icons.explore_outlined) ,
                  onTap: (){
                    Navigator.pop(context);  // This code will point the settings page then you can reach your  needs
                  },
                ),
              ),
              Card(

                child: ListTile(
                  title: Text("Massages") ,
                  trailing: Icon(Icons.mail_outline) ,
                  onTap: (){
                    Navigator.pop(context);  // This code will point the settings page then you can reach your  needs
                  },
                ),
              ),

              Card(

                child: ListTile(
                  title: Text("Notifications") ,
                  trailing: Icon(Icons.notifications_active_outlined) ,
                  onTap: (){
                    Navigator.pop(context);  // This code will point the settings page then you can reach your  needs
                  },
                ),
              ),

              Card(
                child: ListTile(
                  trailing: Icon(Icons.settings) ,
                  title: Text("Settings") ,
                  onTap: (){
                    Navigator.pop(context);  // This code will point the settings page then you can reach your  needs
                  },
                ),
              )],

          ),

        ),

      body: pages[positionNumber],
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
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
