import 'package:act0ne/cat.dart';
import 'package:act0ne/dog.dart';
import 'package:act0ne/other_items.dart';
import 'package:act0ne/toys.dart';
import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> with SingleTickerProviderStateMixin {
  TabController pageController;

  void initState() {
    super.initState();
    pageController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
            indicatorColor: Colors.deepOrange[900],
            labelColor: Colors.deepOrange[900],
            unselectedLabelColor: Colors.grey,
            controller: pageController,
            tabs: [
              Tab(
                child: Text("CAT"),
              ),
              Tab(
                child: Text("DOG"),
              ),
              Tab(
                child: Text("TOYS"),
              ),
              Tab(
                child: Text("OTHERS"),
              ),
            ]),
        Expanded(
          child: TabBarView(
            controller: pageController,
            children: [
              Container(color: Colors.amber, child: Center(child: Cat())),
              Container(color: Colors.red, child: Center(child: Dog())),
              Container(color: Colors.blue, child: Center(child: Toys())),
              Container(
                  color: Colors.purple, child: Center(child: OtherItems()))
            ],
          ),
        ),
      ],
    );
  }
}
