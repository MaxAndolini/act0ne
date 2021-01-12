import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Toys extends StatefulWidget {
  @override
  _ToysState createState() => _ToysState();
}

class _ToysState extends State<Toys> {
  String item1 = '';
  String item2 = '';
  String item3 = '';
  String item4 = '';
  String item5 = '';
  String item6 = '';
  String item7 = '';
  String price1 = '';
  String price2 = '';
  String price3 = '';
  String price4 = '';
  String price5 = '';
  String price6 = '';
  String price7 = '';
  String photo1 = '';
  String photo2 = '';
  String photo3 = '';
  String photo4 = '';
  String photo5 = '';
  String photo6 = '';
  String photo7 = '';

  void getData() async {
    var docRef = FirebaseFirestore.instance
        .collection('market_items')
        .doc('z7bsoMskte4hBZ9PrIkU');
    var docSnap = await docRef.get();
    var docData = docSnap.data();
    item1 = docData['item1'];
    item2 = docData['item2'];
    item3 = docData['item3'];
    item4 = docData['item4'];
    item5 = docData['item5'];
    item6 = docData['item6'];
    item7 = docData['item7'];
    price1 = docData['price1'];
    price2 = docData['price2'];
    price3 = docData['price3'];
    price4 = docData['price4'];
    price5 = docData['price5'];
    price6 = docData['price6'];
    price7 = docData['price7'];
    photo1 = docData['photo1'];
    photo2 = docData['photo2'];
    photo3 = docData['photo3'];
    photo4 = docData['photo4'];
    photo5 = docData['photo5'];
    photo6 = docData['photo6'];
    photo7 = docData['photo7'];

    print(docData);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
