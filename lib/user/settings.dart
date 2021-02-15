import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  bool control = false;
  String birthdayController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: new CircularProgressIndicator());
              }
              var document = snapshot.data;

              if (control == false) {
                nameController.text = document['name'];
                surnameController.text = document['surname'];
                birthdayController = document['birthday'];
              }

              return new Container(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: ListView(children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Container(
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Row(children: [
                                    Text('Name:',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                37,
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.height /
                                                3.6,
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: TextField(
                                            controller: nameController,
                                            style: TextStyle(fontSize: 20)))
                                  ])),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Row(children: [
                                    Text('Surname:',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                37,
                                            fontWeight: FontWeight.bold)),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.height /
                                                3.6,
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: TextField(
                                            controller: surnameController,
                                            style: TextStyle(fontSize: 20)))
                                  ])),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 40,
                              ),
                              Container(
                                  margin: EdgeInsets.all(3.0),
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Row(children: [
                                    Text('Birthday:',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                37,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                50),
                                    AnimatedButton(
                                        color: Colors.white,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                23,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                            birthdayController == null
                                                ? ('Change Birthday')
                                                : birthdayController,
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    40,
                                                color: Colors.black)),
                                        onPressed: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(1900, 1, 1),
                                              maxTime: DateTime(
                                                  DateTime.now().year - 18,
                                                  DateTime.now().month,
                                                  DateTime.now().day),
                                              onChanged: (date) {},
                                              onConfirm: (date) {
                                            setState(() {
                                              control = true;
                                              birthdayController = date
                                                  .toString()
                                                  .split(' ')
                                                  .first;
                                            });
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                        })
                                  ])),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 20),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          Container(
                                              child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      3,
                                                  child: RaisedButton(
                                                      onPressed: () => getImage(
                                                          scaffoldKey),
                                                      child: Text(
                                                          'Change Avatar',
                                                          style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  35)),
                                                      color: Colors.blue[100])))
                                        ])),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        child: RaisedButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(FirebaseAuth
                                                      .instance.currentUser.uid)
                                                  .update({
                                                'name': nameController.text,
                                                'surname':
                                                    surnameController.text,
                                                'birthday': birthdayController
                                              });
                                            },
                                            child: Text('Save Changes',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            30)),
                                            color: Colors.orange[100]))
                                  ])
                            ])
                      ])));
            }));
  }

  Future getImage(scaffold) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String fileName = basename(imageFile.path);

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) {
        String image = value.data()['image'];
        if (image != 'user.png') {
          FirebaseStorage.instance.ref().child(image).delete().catchError(
              (error) => scaffold.currentState.showSnackBar(
                  SnackBar(content: Text('The avatar could not be deleted!'))));
        }
      }).catchError((error) => scaffold.currentState
              .showSnackBar(SnackBar(content: Text('The user not found!'))));
      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref()
          .child('uploads/$fileName')
          .putFile(imageFile);
      taskSnapshot.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({'image': 'uploads/$fileName'}).then((value) {
          scaffold.currentState.showSnackBar(
              SnackBar(content: Text('The avatar changed successfully!!')));
        }).catchError((error) => scaffold.currentState.showSnackBar(
                SnackBar(content: Text('The image could not be sent!'))));
      }).catchError((error) => scaffold.currentState.showSnackBar(
          SnackBar(content: Text('The image could not be sent!'))));
    } else
      scaffold.currentState.showSnackBar(
          SnackBar(content: Text('The image could not be sent!')));
  }
}
