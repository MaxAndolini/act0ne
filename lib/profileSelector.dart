import 'package:act0ne/aboutUs.dart';
import 'package:act0ne/profile.dart';
import 'package:act0ne/signin.dart';
import 'package:act0ne/settings.dart';
import 'package:flutter/material.dart';


class ProfileSelector extends StatefulWidget {
  @override
  _ProfileSelectorState createState() => _ProfileSelectorState();
}

class _ProfileSelectorState extends State<ProfileSelector> with SingleTickerProviderStateMixin {
  TabController pageController;

  void initState() {
    super.initState();
    pageController = TabController(length: 3, vsync: this);
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
                child: Text("Profile"),
              ),
              Tab(
                child: Text("Settings"),
              ),
              Tab(
                child: Text("About Us"),
              ),
            ]),
        Expanded(
          child: TabBarView(
            controller: pageController,
            children: [
              Profile(),
              Settings(),
              AboutUs()
            ],
          ),
        ),
      ],
    );
  }
}
