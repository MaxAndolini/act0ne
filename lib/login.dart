import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primaryColor: Colors.green,
        backgroundColor: Colors.cyan[50],
        secondaryHeaderColor: Colors.cyan[300],
        accentColor: Colors.cyan, 
        scaffoldBackgroundColor: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: Container(        //BACKGROUND
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Theme.of(context).primaryColor,Theme.of(context).accentColor ])),
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              FlutterLogo(
                size: 70,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Container(  //BOX AROUND ITEMS
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Theme.of(context).backgroundColor,
                    Theme.of(context).secondaryHeaderColor,
                  ]),
                  color: Theme.of(context).backgroundColor,
                ),
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width - 50,
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(                   ////// USERNAME CONTAINER 
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.3, 1],
                              colors: [Theme.of(context).backgroundColor,Theme.of(context).accentColor])),
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 130,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(                   ////// PASSWORD CONTAINER
                       decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.3, 1],
                              colors: [Theme.of(context).backgroundColor,Theme.of(context).accentColor])),
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 130,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(      //LOGIN BUTTON
                      alignment: Alignment.center,
                     decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor,
                      gradient: LinearGradient(colors: [
                        Theme.of(context).backgroundColor,
                        Theme.of(context).secondaryHeaderColor,
                      ]),
                    ),
                      height: MediaQuery.of(context).size.height / 17,
                      width: 150,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            color: Colors.grey[800]),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(         //SIGN IN
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor,
                      gradient: LinearGradient(colors: [
                        Theme.of(context).backgroundColor,
                        Theme.of(context).secondaryHeaderColor,
                      ]),
                    ),
                    height: MediaQuery.of(context).size.height / 17,
                    width: 150,
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
                          color: Colors.grey[800]),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(    //SIGN UP
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).backgroundColor,
                      gradient: LinearGradient(colors: [
                        Theme.of(context).secondaryHeaderColor,
                        Theme.of(context).backgroundColor,
                      ]),
                    ),
                    height: MediaQuery.of(context).size.height / 17,
                    width: 150,
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 30,
                          color: Colors.grey[800]),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



