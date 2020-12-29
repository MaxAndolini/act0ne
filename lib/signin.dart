import 'package:act0ne/begin.dart';
import 'package:act0ne/signup.dart';
import 'package:flutter/material.dart';
import 'package:act0ne/authentication_service.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  height: 60,
                ),
                Image.asset(
                  "assets/images/egelogouc.png",
                  height: 70,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "SIGN IN",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //BOX AROUND ITEMS
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange[100]),
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height / 2.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Username",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        ////// USERNAME CONTAINER
                        child: TextField(
                          controller: emailController,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        ////// PASSWORD CONTAINER
                        child: TextField(
                          controller: passwordController,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width - 130,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {},
                        child: InkWell(
                          //LOGIN BUTTON
                          onTap: () {
                            context.read<AuthenticationService>().signIn(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Begin()),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.deepOrange[500]),
                            height: MediaQuery.of(context).size.height / 17,
                            width: 150,
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 30,
                                  color: Colors.white),
                            ),
                          ),
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
                    Container(
                      //Terms
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange[500]),
                      height: MediaQuery.of(context).size.height / 17,
                      width: 150,
                      child: Text(
                        "TERMS",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      //SIGN UP
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.deepOrange[500]),
                        height: MediaQuery.of(context).size.height / 17,
                        width: 150,
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height / 30,
                              color: Colors.white),
                        ),
                      ),
                    )
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
