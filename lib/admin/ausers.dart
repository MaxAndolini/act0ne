import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> litems = [];
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("users").get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: new CircularProgressIndicator());
            }
            var document = snapshot.data.docs;
            document.forEach((data) {
              String variable = data.get("name") +
                  " " +
                  data.get("surname") +
                  ": " +
                  data.get("token").toString();

              litems.add(variable);
            });

            return CustomScrollView(
              slivers: [
                _title(context, 'Users'),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
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
            );
          }),
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
}
