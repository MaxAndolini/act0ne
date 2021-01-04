import 'package:act0ne/authentication_service.dart';
import 'package:act0ne/signup.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepOrange[900],
      body: Center(
        child: Container(
          //BACKGROUND
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepOrange[900], Colors.deepOrange[100]])),
          child: ListView(children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
                  child: Image.asset(
                    "assets/images/egelogouc.png",
                    height: 70,
                  ),
                ),
                Text(
                  "SIGN IN",
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
                  margin: EdgeInsets.only(top: 20.0),
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Text(
                          "E-Mail",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        ////// USERNAME CONTAINER
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: emailController,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                        child: Text(
                          "Password",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        ////// PASSWORD CONTAINER
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
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: AnimatedButton(
                          color: Colors.deepOrange[500],
                          height: MediaQuery.of(context).size.height / 17,
                          width: 150,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height / 40,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            context.read<AuthenticationService>().signIn(
                              scaffold: _scaffoldKey.currentState,
                              aContext: context,
                              email: emailController.text,
                              password: passwordController.text,
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
                          "FORGOT PASSWORD",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 55,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          context.read<AuthenticationService>().signIn(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: AnimatedButton(
                        color: Colors.deepOrange[500],
                        height: MediaQuery.of(context).size.height / 17,
                        width: 150,
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 55,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          context.read<AuthenticationService>().signIn(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
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
}
