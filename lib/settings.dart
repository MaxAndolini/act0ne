import 'package:flutter/material.dart';


class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[900],
      body: Container(
        height: MediaQuery.of(context).size.height / 1.4,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "SETTINGS",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      "Name:",
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      "Surname: ",
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      "Birthday:",
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      "E-Mail: ",
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      "Telephone Number: ",
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                padding: EdgeInsets.all(15.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Text(
                      "Change Avatar",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
