import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Dog extends StatefulWidget {
  @override
  _DogState createState() => _DogState();
}

class _DogState extends State<Dog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('market_items')
              .doc('ln7hUZU7RMAvRX2oUtV8')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            var docData = snapshot.data;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(docData['dog_item1'] +
                        ": " +
                        docData['price1'] +
                        docData['photo1']),
                  ),
                  Container(
                    child: Text(docData['dog_item2'] +
                        ": " +
                        docData['price2'] +
                        docData['photo2']),
                  ),
                  Container(
                    child: Text(docData['dog_item3'] +
                        ": " +
                        docData['price3'] +
                        docData['photo3']),
                  ),
                  Container(
                    child: Text(docData['dog_item4'] +
                        ": " +
                        docData['price4'] +
                        docData['photo4']),
                  ),
                  Container(
                    child: Text(docData['dog_item5'] +
                        ": " +
                        docData['price5'] +
                        docData['photo5']),
                  ),
                  Container(
                    child: Text(docData['dog_item6'] +
                        ": " +
                        docData['price6'] +
                        docData['photo6']),
                  ),
                  Container(
                    child: Text(docData['dog_item7'] +
                        ": " +
                        docData['price7'] +
                        docData['photo7']),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
