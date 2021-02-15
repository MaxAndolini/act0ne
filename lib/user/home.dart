import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };

    List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
    ];*/

    return Scaffold(
        body: CustomScrollView(slivers: [
      title(context, 'General Achievements'),
      /*PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        colorList: colorList,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        centerText: "HYBRID",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
        ),
      ),*/
      title(context, 'My Achievements'),
      SliverToBoxAdapter(
          child: Container(
              height: MediaQuery.of(context).size.height / 3.0,
              margin: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: new CircularProgressIndicator());
                    }
                    var document = snapshot.data;
                    var tasks = document['tasks'].reversed.toList();
                    return ListView.builder(
                        itemExtent: 40,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                color: Colors.green[200],
                                border: Border.all(width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                              ),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.only(left: 10.0),
                              child: new Text(tasks[index]),
                            ),
                        itemCount: tasks.length);
                  })))
    ]));
  }

  title(BuildContext context, String title) {
    return SliverToBoxAdapter(
        child: Center(
            child: Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(title,
                    style: Theme.of(context).textTheme.headline6.merge(
                        TextStyle(
                            fontSize: 16.0, color: Colors.deepOrange[900]))))));
  }
}
