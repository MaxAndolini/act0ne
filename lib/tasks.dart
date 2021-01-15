import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

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

  File _imageFile ;
  final imagePicker = ImagePicker();
  PickedFile pickedFile ;

    Future getImage() async{
      final pickedFile =  await imagePicker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
          print("Your Photo sent");
          uploadImageToFirebase();
        } else {
          print("Something went wrong.");
        }
      });
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('TaskPhotos/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) =>
          FirebaseFirestore.instance.collection("users")
              .doc(FirebaseAuth.instance.currentUser.uid).update({"Taskimage":"TaskPhotos/$fileName"}),
    );
  }


/*
  Random random = Random();

  List<Task> dailyTasksList = [
    Task.withdailyTasks("Give cup of food"),
    Task.withdailyTasks("Give some love"),
    Task.withdailyTasks("Play with animals"),
  ];

  List<Task> weeklyTasksList = [
    Task.withweeklyTasks("Visit animal shelter"),
    Task.withweeklyTasks("Make goods for animals"),
    Task.withweeklyTasks("Visit animal shelter"),
    Task.withweeklyTasks("Watch film about animals"),
  ];

  List<Task> monthlyTasksList = [
    Task.withmonthlyTasks("Donate the animal foundation "),
    Task.withmonthlyTasks("Construct a animal shelter"),
    Task.withmonthlyTasks("Adopt a animal"),
  ];
*/

/*
  int _counter = 10;
  Timer _timer;

  void _startTimer() {
    _counter =  TimeOfDay.hoursPerDay;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
      stream: FirebaseFirestore.instance
      .collection('Tasks')
      .doc('Q8elnpjjwODUNKwp3uu6')
      .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: new CircularProgressIndicator());
        }
        var taskData = snapshot.data;

        return ListView(children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 0, height: 100.0),
              Text("Daily Task", textAlign: TextAlign.left),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadiusDirectional.circular(6.0),
                      shape: BoxShape.rectangle),
                  height: 50,
                  width: 275,
                  padding: EdgeInsets.all(5.00),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(6.0),
                        shape: BoxShape.rectangle),
                    height: 50,
                    width: 275,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Text(taskData["task5"]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(onPressed:getImage ,
                child: Icon(Icons.camera_alt),
              ),

              //(_counter > 0)
              //  ? Text('')
             /* Text(
                'Lets try to new task',
                style: TextStyle(color: Colors.amber),

              ),
              */
              /* RaisedButton(
                onPressed: () => _startTimer(),
                child: Text("You have 24 hours to complete this task"),
              ),*/
              /*Text(
                '$_counter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),*/

              SizedBox(width: 0, height: 100.0),
              Text("Weekly Task"),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadiusDirectional.circular(6.0),
                      shape: BoxShape.rectangle),
                  height: 50,
                  width: 275,
                  padding: EdgeInsets.all(5.00),
                  child: Container(
                    height: 50,
                    width: 275,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(6.0),
                        shape: BoxShape.rectangle),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(taskData["task2"])
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(onPressed:getImage ,
                child: Icon(Icons.camera_alt),
              ),
              SizedBox(width: 0, height: 100.0),
              Text("Monthly Tasks"),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadiusDirectional.circular(6.0),
                      shape: BoxShape.rectangle),
                  height: 50,
                  width: 275,
                  padding: EdgeInsets.all(5.00),
                  child: Container(
                    height: 50,
                    width: 275,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(6.0),
                        shape: BoxShape.rectangle),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(taskData["task3"]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              RaisedButton(onPressed:getImage ,
                child: Icon(Icons.camera_alt),
              ),
            ],
          ),
        ]);
      }),
    );
  }




}

