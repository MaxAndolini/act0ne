import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.brown,
      Colors.grey
    ];
    return Scaffold(
        body: CustomScrollView(slivers: [
      title(context, 'General Achievements'),
      SliverToBoxAdapter(
          child: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('tasks')
                      .doc('Q8elnpjjwODUNKwp3uu6')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: new CircularProgressIndicator());
                    }
                    var document = snapshot.data;
                    Map<String, double> dataMap = {
                      "Task 1": document['task1_total'].toDouble(),
                      "Task 2": document['task2_total'].toDouble(),
                      "Task 3": document['task3_total'].toDouble(),
                      "Task 4": document['task4_total'].toDouble(),
                      "Task 5": document['task5_total'].toDouble(),
                      "Task 6": document['task6_total'].toDouble(),
                      "Task 7": document['task7_total'].toDouble(),
                      "Task 8": document['task8_total'].toDouble(),
                      "Task 9": document['task9_total'].toDouble(),
                    };
                    return PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32,
                        chartRadius: MediaQuery.of(context).size.width / 1.7,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.disc,
                        ringStrokeWidth: 32,
                        legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.right,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle:
                                TextStyle(fontWeight: FontWeight.bold)),
                        chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false));
                  }))),
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
