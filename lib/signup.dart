import 'package:act0ne/authentication_service.dart';
import 'package:act0ne/signin.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  String birthdayController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepOrange[900],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepOrange[900], Colors.deepOrange[100]])),
          child: ListView(children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Image.asset(
                    "assets/images/egelogouc.png",
                    height: 70,
                  ),
                ),
                Text(
                  "SIGN UP",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Container(
                  //BOX AROUND ITEMS
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange[100]),
                  margin: EdgeInsets.only(top: 10.0),
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _title(context, "Name"),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: nameController,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 23,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      _title(context, "Surname"),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: surnameController,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 23,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      _title(context, "E-Mail"),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: emailController,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 23,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      _title(context, "Birthday"),
                      AnimatedButton(
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height / 23,
                        width: MediaQuery.of(context).size.width - 130,
                        child: Text(
                          birthdayController == null
                              ? ("Change Birthday")
                              : birthdayController,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 55,
                              color: Colors.black),
                        ),
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1900, 1, 1),
                              maxTime: DateTime(DateTime.now().year - 18,
                                  DateTime.now().month, DateTime.now().day),
                              onChanged: (date) {}, onConfirm: (date) {
                            setState(() {
                              birthdayController =
                                  date.toString().split(" ").first;
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                      ),
                      _title(context, "Password"),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 23,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      _title(context, "Repeat Password"),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: password2Controller,
                            obscureText: true,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 23,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: AnimatedButton(
                          color: Colors.deepOrange[500],
                          height: MediaQuery.of(context).size.height / 17,
                          width: 150,
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height / 40,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            context.read<AuthenticationService>().signUp(
                                  scaffold: _scaffoldKey.currentState,
                                  aContext: context,
                                  name: nameController.text,
                                  surname: surnameController.text,
                                  email: emailController.text,
                                  birthday: birthdayController,
                                  password: passwordController.text,
                                  password2: password2Controller.text,
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 5.0),
                      child: AnimatedButton(
                        color: Colors.deepOrange[500],
                        height: MediaQuery.of(context).size.height / 17,
                        width: 150,
                        child: Text(
                          "TERMS",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 55,
                              color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: AnimatedButton(
                        color: Colors.deepOrange[500],
                        height: MediaQuery.of(context).size.height / 17,
                        width: 150,
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 55,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }

  _title(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 6.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 50,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
