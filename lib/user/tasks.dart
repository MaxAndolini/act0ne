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
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool task1Done = false;
  bool task2Done = false;
  bool task3Done = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: new CircularProgressIndicator());
              }
              var document = snapshot.data;

              if (document['task1_sent'] != null)
                task1Done = document['task1_sent'];
              if (document['task2_sent'] != null)
                task2Done = document['task2_sent'];
              if (document['task3_sent'] != null)
                task3Done = document['task3_sent'];

              if (document['task1_name'].isEmpty) task1Done = true;
              if (document['task2_name'].isEmpty) task2Done = true;
              if (document['task3_name'].isEmpty) task3Done = true;

              if (document['task1_day_limit'] <=
                  DateTime.now()
                      .difference(document['task1_date'].toDate())
                      .inDays) getRandomTask(1);

              if (document['task2_day_limit'] <=
                  DateTime.now()
                      .difference(document['task2_date'].toDate())
                      .inDays) getRandomTask(2);

              if (document['task3_day_limit'] <=
                  DateTime.now()
                      .difference(document['task3_date'].toDate())
                      .inDays) getRandomTask(3);

              return ListView(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Text('Daily Task',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange[300])),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrange[300],
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                6.0),
                                        shape: BoxShape.rectangle),
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    width: MediaQuery.of(context).size.width /
                                        1.42,
                                    padding: EdgeInsets.all(5.00),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(6.0),
                                            shape: BoxShape.rectangle),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                16,
                                        width:
                                            MediaQuery.of(
                                                        context)
                                                    .size
                                                    .width /
                                                1.42,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(document['task1_name'],
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                18)),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              4.0),
                                                                  child: Text(
                                                                      document[
                                                                              'task1_token']
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height / 40))),
                                                              Image.asset(
                                                                  'assets/images/icons/token.png',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      20)
                                                            ]))
                                                  ])
                                            ])))),
                            Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: RaisedButton(
                                    onPressed: task1Done
                                        ? null
                                        : () => getImage(_scaffoldKey, 1),
                                    child: Icon(Icons.camera_alt)))
                          ])),
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
                                            BorderRadiusDirectional.circular(
                                                6.0),
                                        shape: BoxShape.rectangle),
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    width: MediaQuery.of(context).size.width /
                                        1.42,
                                    padding: EdgeInsets.all(5.00),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                16,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.42,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadiusDirectional.circular(
                                                    6.0),
                                            shape: BoxShape.rectangle),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      document['task2_name'],
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              18),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              4.0),
                                                                  child: Text(
                                                                    document[
                                                                            'task2_token']
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.height /
                                                                                40),
                                                                  )),
                                                              Image.asset(
                                                                  'assets/images/icons/token.png',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      20)
                                                            ]))
                                                  ])
                                            ])))),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: RaisedButton(
                                onPressed: task2Done
                                    ? null
                                    : () => getImage(_scaffoldKey, 2),
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
                          child: Row(children: [
                            Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green[300],
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                6.0),
                                        shape: BoxShape.rectangle),
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    width: MediaQuery.of(context).size.width /
                                        1.42,
                                    padding: EdgeInsets.all(5.00),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                16,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.42,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadiusDirectional.circular(
                                                    6.0),
                                            shape: BoxShape.rectangle),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(document['task3_name'],
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                18)),
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              4.0),
                                                                  child: Text(
                                                                    document[
                                                                            'task3_token']
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.height /
                                                                                40),
                                                                  )),
                                                              Image.asset(
                                                                  'assets/images/icons/token.png',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      20)
                                                            ]))
                                                  ])
                                            ])))),
                            Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: RaisedButton(
                                  onPressed: task3Done
                                      ? null
                                      : () => getImage(_scaffoldKey, 3),
                                  child: Icon(Icons.camera_alt),
                                ))
                          ]))
                    ])
              ]);
            }));
  }

  Future getImage(scaffold, int task) async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      try {
        File imageFile = File(pickedFile.path);
        String fileName = basename(imageFile.path);
        TaskSnapshot taskSnapshot = await FirebaseStorage.instance
            .ref()
            .child('tasks/$fileName')
            .putFile(imageFile);
        taskSnapshot.ref.getDownloadURL().then((value) => {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .update({
                'task' + task.toString() + '_image': 'tasks/$fileName',
                'task' + task.toString() + '_sent': true
              }).catchError((error) => scaffold.currentState.showSnackBar(
                      SnackBar(content: Text('The image could not be sent!')))),
              scaffold.currentState.showSnackBar(
                  SnackBar(content: Text('The task submitted successfully!!'))),
              setState(() {
                if (task == 1) task1Done = true;
                if (task == 2) task2Done = true;
                if (task == 3) task3Done = true;
              })
            });
      } catch (error) {
        scaffold.currentState.showSnackBar(
            SnackBar(content: Text('The task could not be sent!')));
      }
    } else
      scaffold.currentState
          .showSnackBar(SnackBar(content: Text('The task could not be sent!')));
  }

  getRandomTask(int task) async {
    Random random = new Random();
    int randomNumber = random.nextInt(8) + 1;
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc('Q8elnpjjwODUNKwp3uu6')
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'task' + task.toString() + '_id': randomNumber,
        'task' + task.toString() + '_name':
            value.data()['task' + randomNumber.toString()],
        'task' + task.toString() + '_image': '',
        'task' + task.toString() + '_token':
            value.data()['task' + randomNumber.toString() + '_price'],
        'task' + task.toString() + '_date': Timestamp.fromDate(DateTime.now()),
        'task' + task.toString() + '_day_limit':
            value.data()['task' + randomNumber.toString() + '_day_limit'],
        'task' + task.toString() + '_sent': false
      });
      setState(() {
        if (task == 1) task1Done = false;
        if (task == 2) task2Done = false;
        if (task == 3) task3Done = false;
      });
    });
  }
}
