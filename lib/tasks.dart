import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Random random = Random();

  List<Task> dailyTasksList = [
    Task.withdailyTasks("Give cup of water"),
    Task.withdailyTasks("Give cup of food"),
    Task.withdailyTasks("Give some love"),
    Task.withdailyTasks("Play with animals"),
  ];


  List<Task> weeklyTasksList =[
    Task.withweeklyTasks("Visit animal shelter"),
    Task.withweeklyTasks("Make goods for animals"),
    Task.withweeklyTasks("Visit animal shelter"),
    Task.withweeklyTasks("Watch film about animals"),

  ];

  List<Task> monthlyTasksList =[
    Task.withmonthlyTasks("Donate the animal foundation "),
    Task.withmonthlyTasks("Construct a animal shelter"),
    Task.withmonthlyTasks("Adopt a animal"),

  ];

  int _counter = 10  ;
  Timer _timer ;

  void _startTimer(){
    _counter = 10  ;
    if (_timer != null){
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(_counter > 0 ){
          _counter-- ;
        }else{
          _timer.cancel();
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child:Scaffold(

        drawer: Drawer(
          child: ListView(

            children: <Widget>[
              DrawerHeader(
                child:CircleAvatar(

                  backgroundImage:AssetImage("assets/images/egelogo .png" , ) ,
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


        body:Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width:0, height:100.0 ),
            Text("Daily Task" , textAlign: TextAlign.left),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color:Colors.cyan,
                    borderRadius: BorderRadiusDirectional.circular(6.0),
                    shape: BoxShape.rectangle
                ),
                height:50,
                width: 275,
                padding:EdgeInsets.all(5.00) ,
                child: Container(
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(6.0),
                      shape: BoxShape.rectangle
                  ),
                  height:50,
                  width: 275,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: <Widget>[
                          Text(dailyTasksList[random.nextInt(dailyTasksList.length)].dailyTasks,
                            style: TextStyle(fontStyle: FontStyle.normal ,   // font style will change
                              fontWeight: FontWeight.bold ,
                              height: 2.1,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
            (_counter > 0 )? Text('') : Text('Lets try to new task', style: TextStyle(color: Colors.amber), ),
            RaisedButton(
              onPressed: () => _startTimer(),
              child: Text("You have 24 hours to complete this task"),
            ),
            Text('$_counter' ,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30 ,
              ),
            ),
            SizedBox(width:0, height:100.0 ),
            Text("Weekly Task" ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color:Colors.cyan,
                    borderRadius: BorderRadiusDirectional.circular(6.0),
                    shape: BoxShape.rectangle
                ),
                height:50,
                width: 275,
                padding:EdgeInsets.all(5.00),

                child: Container(

                  height: 50,
                  width: 275,
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(6.0),
                      shape: BoxShape.rectangle
                  ),
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(weeklyTasksList[random.nextInt(weeklyTasksList.length)].weeklyTasks ,
                            style: TextStyle(fontStyle: FontStyle.normal ,   // font style will change
                              fontWeight: FontWeight.bold ,
                              height: 2.1,

                            ),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width:0, height:100.0 ),
            Text("Monthly Tasks"),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color:Colors.cyan,
                    borderRadius: BorderRadiusDirectional.circular(6.0),
                    shape: BoxShape.rectangle
                ),
                height:50,
                width: 275,
                padding:EdgeInsets.all(5.00) ,

                child: Container(
                  height: 50,
                  width: 275,
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(6.0),
                      shape: BoxShape.rectangle
                  ),
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(monthlyTasksList[random.nextInt(monthlyTasksList.length)].dailyTasks,
                            style: TextStyle(fontStyle: FontStyle.normal ,   // font style will change
                              fontWeight: FontWeight.bold ,
                              height: 2.1,

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        appBar: AppBar(backgroundColor: Theme.of(context).accentColor ,
          title: Image.asset("assets/images/egelogo .png",
            fit : BoxFit.cover, width: 125, ),
          actions: [
            Text("Ticket  =  0 " ,   // will be dinamic
              textAlign: TextAlign.center,
              style: TextStyle( fontStyle: FontStyle.italic),
            )
          ],
          toolbarHeight: 60.0,
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/Home.png"),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/Task.png"),
              ),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/Store.png"),
              ),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/profile.png"),
              ),
              label: 'Profile',
            ),

          ],
        ),
      ),
    );



  }
}

