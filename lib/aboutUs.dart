import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: ListView(
          children: [
            Center(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    Text(
                      "About Us",
                      style: TextStyle(fontSize: 50, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "We are 4 students of Izmir University of Economics. We realised that there are people who try to take care of the environment"+
                        " and the animals around them. We decided to support these people with our mobile application and encourage them."+
                        " If you have any feedbacks please contact us! ",
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
