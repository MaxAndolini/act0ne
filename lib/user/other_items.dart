import 'package:act0ne/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OtherItems extends StatefulWidget {
  @override
  _OtherItemsState createState() => _OtherItemsState();
}

class _OtherItemsState extends State<OtherItems> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final func = new Functions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('market_items')
              .doc('L9HgfKvybbxIbe8ttV5w')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: new CircularProgressIndicator());
            }
            var document = snapshot.data;
            return Container(
                child: ListView(children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      //First Item
                      func.listBuyItem(
                          _scaffoldKey,
                          context,
                          document['other_item1'],
                          document['price1'],
                          document['photo1'],
                          Colors.deepOrange[100]),

                      //Second Item
                      func.listBuyItem(
                          _scaffoldKey,
                          context,
                          document['other_item2'],
                          document['price2'],
                          document['photo2'],
                          Colors.green[100]),

                      //Third Item
                      func.listBuyItem(
                          _scaffoldKey,
                          context,
                          document['other_item3'],
                          document['price3'],
                          document['photo3'],
                          Colors.blue[100])
                    ]),
                    Row(children: [
                      //Fourth Item
                      func.listBuyItem(
                          _scaffoldKey,
                          context,
                          document['other_item4'],
                          document['price4'],
                          document['photo4'],
                          Colors.blue[100]),

                      //Fifth Item
                      func.listBuyItem(
                          _scaffoldKey,
                          context,
                          document['other_item5'],
                          document['price5'],
                          document['photo5'],
                          Colors.deepOrange[100]),

                      //Sixth Item
                      func.listBuyItem(
                          _scaffoldKey,
                          context,
                          document['other_item6'],
                          document['price6'],
                          document['photo6'],
                          Colors.green[100])
                    ]),
                    Row(children: [
                      //Seventh Item
                      func.listBuyItem(
                          _scaffoldKey,
                          context,
                          document['other_item7'],
                          document['price7'],
                          document['photo7'],
                          Colors.green[100])
                    ])
                  ])
            ]));
          }),
    );
  }
}
