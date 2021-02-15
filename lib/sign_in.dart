import 'package:act0ne/authentication_service.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.deepOrange[900],
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Colors.deepOrange[900],
                      Colors.deepOrange[100]
                    ])),
                child: ListView(children: [
                  Column(children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child:
                            Image.asset('assets/images/logo.png', height: 70)),
                    Text('SIGN IN',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepOrange[100]),
                        margin: EdgeInsets.only(top: 10.0),
                        width: MediaQuery.of(context).size.width - 50,
                        height: MediaQuery.of(context).size.height / 3.6,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              title(context, 'E-Mail'),
                              Container(
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                          controller: emailController)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  height:
                                      MediaQuery.of(context).size.height / 23,
                                  width:
                                      MediaQuery.of(context).size.width - 130),
                              title(context, 'Password'),
                              Container(
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                          controller: passwordController,
                                          obscureText: true)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  height:
                                      MediaQuery.of(context).size.height / 23,
                                  width:
                                      MediaQuery.of(context).size.width - 130),
                              Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: AnimatedButton(
                                      color: Colors.deepOrange[500],
                                      height:
                                          MediaQuery.of(context).size.height /
                                              17,
                                      width: 150,
                                      child: Text('LOGIN',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  40,
                                              color: Colors.white)),
                                      onPressed: () {
                                        context
                                            .read<AuthenticationService>()
                                            .signIn(
                                                scaffoldKey,
                                                context,
                                                emailController.text,
                                                passwordController.text);
                                      }))
                            ])),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10.0, right: 5.0),
                          child: AnimatedButton(
                              color: Colors.deepOrange[500],
                              height: MediaQuery.of(context).size.height / 17,
                              width: 150,
                              child: Text('FORGOT PASSWORD',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              55,
                                      color: Colors.white)),
                              onPressed: () {})),
                      Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: AnimatedButton(
                            color: Colors.deepOrange[500],
                            height: MediaQuery.of(context).size.height / 17,
                            width: 150,
                            child: Text('SIGN UP',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height / 55,
                                    color: Colors.white)),
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, '/signUp'),
                          ))
                    ])
                  ])
                ]))));
  }

  title(BuildContext context, String title) {
    return Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 6.0),
        child: Text(title,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 50,
                fontWeight: FontWeight.bold)));
  }
}
