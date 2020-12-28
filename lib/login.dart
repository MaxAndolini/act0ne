import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: Center(
        child: Container(
          //BACKGROUND
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.deepOrange[900], Colors.deepOrange[100]])),
          child: Column(
            children: [
              SizedBox(
                height: 120,
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
                     child:  TextField(),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width - 130,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      //LOGIN BUTTON
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange[500]),
                      height: MediaQuery.of(context).size.height / 17,
                      width: 150,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 30,
                            color: Colors.white),
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
                    //SIGN IN
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
                  Container(
                    //SIGN UP
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
