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
      home: Tasks(),
    );
  }
}

class Tasks extends StatefulWidget {

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
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
        body:ListView(
                  children: [Column(
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
          ),]
        ),
      ),
    );



  }
}

