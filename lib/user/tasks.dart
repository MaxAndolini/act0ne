import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool task1TimeDone = false;
  bool task2TimeDone = false;
  bool task3TimeDone = false;

  bool task1Done = false;
  bool task2Done = false;
  bool task3Done = false;

  int picNumber = 0;
  File _imageFile;

  final imagePicker = ImagePicker();
  PickedFile pickedFile;

  @override
  void initState() {
    super.initState();
    _getTasksDone();
    _timeControl();
    _getRandomTask();
  }

  Future getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    print(pickedFile);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        uploadImageToFirebase();
        print('Your Photo sent');
        if (picNumber == 1) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({'task1_sent': true});
          task1Done = true;
        }
        if (picNumber == 2) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({'task2_sent': true});
          task2Done = true;
        }
        if (picNumber == 3) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .update({'task3_sent': true});
          task3Done = true;
        }
      } else {
        print('Something went wrong.');
      }
    });
  }

  Future uploadImageToFirebase() async {
    String fileName = basename(_imageFile.path);
    print(fileName);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('tasks/$fileName');

    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value) => {
          if (picNumber > 0)
            {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .update({
                'task' + picNumber.toString() + '_image': 'tasks/$fileName',
                'task' + picNumber.toString() + '_sent': true
              }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: new CircularProgressIndicator());
            }
            _getRandomTask();

            var document = snapshot.data;
            return ListView(children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Text(
                    'Daily Task',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange[300]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.deepOrange[300],
                                borderRadius:
                                    BorderRadiusDirectional.circular(6.0),
                                shape: BoxShape.rectangle),
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width / 1.42,
                            padding: EdgeInsets.all(5.00),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(6.0),
                                  shape: BoxShape.rectangle),
                              height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 1.42,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        document['task1_name'],
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              18,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 4.0),
                                                child: Text(
                                                  document['task1_token']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              40),
                                                )),
                                            Image.asset(
                                              'assets/images/icons/token.png',
                                              fit: BoxFit.contain,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: RaisedButton(
                            onPressed: task1Done
                                ? null
                                : () {
                                    setState(() {
                                      picNumber = 1;
                                    });
                                    getImage();
                                  },
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 0,
                      height: MediaQuery.of(context).size.height / 16),
                  Text('Weekly Task',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius:
                                    BorderRadiusDirectional.circular(6.0),
                                shape: BoxShape.rectangle),
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width / 1.42,
                            padding: EdgeInsets.all(5.00),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 1.42,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(6.0),
                                  shape: BoxShape.rectangle),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document['task2_name'],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                18),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 4.0),
                                                child: Text(
                                                  document['task2_token']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              40),
                                                )),
                                            Image.asset(
                                              'assets/images/icons/token.png',
                                              fit: BoxFit.contain,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: RaisedButton(
                            onPressed: task2Done
                                ? null
                                : () {
                                    setState(() {
                                      picNumber = 2;
                                    });

                                    getImage();
                                  },
                            child: Icon(Icons.camera_alt),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 0,
                      height: MediaQuery.of(context).size.height / 16),
                  Text('Monthly Task',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[300])),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green[300],
                                borderRadius:
                                    BorderRadiusDirectional.circular(6.0),
                                shape: BoxShape.rectangle),
                            height: MediaQuery.of(context).size.height / 16,
                            width: MediaQuery.of(context).size.width / 1.42,
                            padding: EdgeInsets.all(5.00),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 16,
                              width: MediaQuery.of(context).size.width / 1.42,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(6.0),
                                  shape: BoxShape.rectangle),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(document['task3_name'],
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                18,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 4.0),
                                                child: Text(
                                                  document['task3_token']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              40),
                                                )),
                                            Image.asset(
                                              'assets/images/icons/token.png',
                                              fit: BoxFit.contain,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: RaisedButton(
                            onPressed: task3Done
                                ? null
                                : () {
                                    setState(() {
                                      picNumber = 3;
                                    });

                                    getImage();
                                  },
                            child: Icon(Icons.camera_alt),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]);
          }),
    );
  }

  

  _getTasksDone() async {
    var recordData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    var getValue = recordData.data();
    if (getValue['task1_sent'] != null) task1Done = getValue['task1_sent'];
    if (getValue['task2_sent'] != null) task2Done = getValue['task2_sent'];
    if (getValue['task3_sent'] != null) task3Done = getValue['task3_sent'];
  }

  _getRandomTask() async {
    if (task1TimeDone) {
      Random random = new Random();
      int randomNumber = random.nextInt(8) + 1;
      var recordData = await FirebaseFirestore.instance
          .collection('tasks')
          .doc('Q8elnpjjwODUNKwp3uu6')
          .get();
      var getValue = recordData.data();
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'task1_id': randomNumber,
        'task1_name': getValue['task' + randomNumber.toString()],
        'task1_image': '',
        'task1_token': getValue['task' + randomNumber.toString() + '_price'],
        'task1_date': Timestamp.fromDate(DateTime.now()),
        'task1_day_limit':
            getValue['task' + randomNumber.toString() + '_day_limit'],
        'task1_sent': false
      });
      task1Done = false;
      task1TimeDone = false;
    }

    if (task2TimeDone) {
      Random random = new Random();
      int randomNumber = random.nextInt(8) + 1;
      var recordData = await FirebaseFirestore.instance
          .collection('tasks')
          .doc('Q8elnpjjwODUNKwp3uu6')
          .get();
      var getValue = recordData.data();
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'task2_id': randomNumber,
        'task2_name': getValue['task' + randomNumber.toString()],
        'task2_image': '',
        'task2_token': getValue['task' + randomNumber.toString() + '_price'],
        'task2_date': Timestamp.fromDate(DateTime.now()),
        'task2_day_limit':
            getValue['task' + randomNumber.toString() + '_day_limit'],
        'task2_sent': false
      });
      task2Done = false;
      task2TimeDone = false;
    }

    if (task3TimeDone) {
      Random random = new Random();
      int randomNumber = random.nextInt(8) + 1;
      var recordData = await FirebaseFirestore.instance
          .collection('tasks')
          .doc('Q8elnpjjwODUNKwp3uu6')
          .get();
      var getValue = recordData.data();
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'task3_id': randomNumber,
        'task3_name': getValue['task' + randomNumber.toString()],
        'task3_image': '',
        'task3_token': getValue['task' + randomNumber.toString() + '_price'],
        'task3_date': Timestamp.fromDate(DateTime.now()),
        'task3_day_limit':
            getValue['task' + randomNumber.toString() + '_day_limit'],
        'task3_sent': false
      });
      task3Done = false;
      task3TimeDone = false;
    }
  }

  _timeControl() async {
    var recordData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    var getValue = recordData.data();
    DateTime givenTime1 = getValue['task1_date'].toDate();
    if (getValue['task1_day_limit'] <=
        DateTime.now().difference(givenTime1).inDays) {
      task1TimeDone = true;
    }

    DateTime givenTime2 = getValue['task2_date'].toDate();
    if (getValue['task2_day_limit'] <=
        DateTime.now().difference(givenTime2).inDays) {
      task2TimeDone = true;
    }

    DateTime givenTime3 = getValue['task3_date'].toDate();
    if (getValue['task3_day_limit'] <=
        DateTime.now().difference(givenTime3).inDays) {
      task3TimeDone = true;
    }
  }
}
