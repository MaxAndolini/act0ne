import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AHome extends StatelessWidget {
  final List<String> litems = [
    "The number of stray dogs fed: 100",
    "The number of stray cats fed: 100",
    "The number of plastic sent for recyling: 100",
    "The number of paper sent for recyling: 100",
    "The number of glass sent for recyling: 100",
    "The number of metal sent for recyling: 100",
    "The number of cell sent for recyling: 100",
  ];

  @override
  Widget build(BuildContext context) {
    _deneme();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _title(context, 'Tasks'),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.4,
              margin: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: ListView.builder(
                  itemExtent: 40,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          border: Border.all(width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.only(left: 10.0),
                        child: new Text(litems[index]),
                      ),
                  itemCount: litems.length),
            ),
          ),
        ],
      ),
    );
  }

  _title(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(title,
              style: Theme.of(context).textTheme.headline6.merge(
                  TextStyle(fontSize: 16.0, color: Colors.deepOrange[900]))),
        ),
      ),
    );
  }

  _deneme() async {
    final QuerySnapshot result =
    await FirebaseFirestore.instance.collection('users').get();
    final List<DocumentSnapshot> documents = result.docs;

    documents.forEach((data) => print(data.id));
  }
}
