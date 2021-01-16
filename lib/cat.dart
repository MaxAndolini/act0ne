import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Cat extends StatefulWidget {
  @override
  _CatState createState() => _CatState();
}

class _CatState extends State<Cat> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('market_items')
              .doc('QZ72Zxj6MwCIWKMDF0Oi')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            var docData = snapshot.data;
            return Container(
                child: ListView(children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  elevation: 16,
                                  child: Container(
                                    //container when clicked
                                    padding: new EdgeInsets.all(20.0),
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ListView(
                                      children: <Widget>[
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Do you want to buy this item ?",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  22,
                                              color: Colors.deepOrange[900],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0),
                                              child: Text(
                                                docData['cat_item1'] +
                                                    " : " +
                                                    docData['price1'],
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/icons/token.png",
                                              fit: BoxFit.contain,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Your name :",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white),
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Your Adress :",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white),
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        RaisedButton(
                                          onPressed: () {
                                            _buyItem(docData["price1"],docData["cat_item1"]);
                                          },
                                          child: Text("BUY"),
                                          color: Colors.green[100],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            //Container with photo
                            padding: new EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 2.6,
                            decoration:
                                BoxDecoration(color: Colors.deepOrange[100]),
                            child: Column(
                              children: [
                                Text(
                                  docData['cat_item1'],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              50),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 100,
                                  child: FutureBuilder(
                                      future:
                                          _getImage(context, docData["photo1"]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: snapshot.data,
                                          );
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Container();
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Text(
                                        docData['price1'],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/icons/token.png",
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        //Second Item
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  elevation: 16,
                                  child: Container(
                                    padding: new EdgeInsets.all(20.0),
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ListView(
                                      children: <Widget>[
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Do you want to buy this item ?",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  22,
                                              color: Colors.deepOrange[900],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0),
                                              child: Text(
                                                docData['cat_item2'] +
                                                    " : " +
                                                    docData['price2'],
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/icons/token.png",
                                              fit: BoxFit.contain,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Your name :",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white),
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Your Adress :",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white),
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        RaisedButton(
                                          onPressed: () {_buyItem(docData["price2"],docData["cat_item2"]);
                                          },
                                          child: Text("BUY"),
                                          color: Colors.green[100],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: new EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 2.6,
                            decoration:
                                BoxDecoration(color: Colors.deepOrange[100]),
                            child: Column(
                              children: [
                                Text(
                                  docData['cat_item2'],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              50),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 100,
                                  child: FutureBuilder(
                                      future:
                                          _getImage(context, docData["photo2"]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: snapshot.data,
                                          );
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Container();
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Text(
                                        docData['price2'],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/icons/token.png",
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        //Third Item
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  elevation: 16,
                                  child: Container(
                                    padding: new EdgeInsets.all(20.0),
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ListView(
                                      children: <Widget>[
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Do you want to buy this item ?",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  22,
                                              color: Colors.deepOrange[900],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0),
                                              child: Text(
                                                docData['cat_item3'] +
                                                    " : " +
                                                    docData['price3'],
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/icons/token.png",
                                              fit: BoxFit.contain,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Your name :",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white),
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Your Adress :",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white),
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        RaisedButton(
                                          onPressed: () {_buyItem(docData["price3"],docData["cat_item3"]);
                                          },
                                          child: Text("BUY"),
                                          color: Colors.green[100],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: new EdgeInsets.all(10.0),
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.height / 2.6,
                            decoration:
                                BoxDecoration(color: Colors.deepOrange[100]),
                            child: Column(
                              children: [
                                Text(
                                  docData['cat_item3'],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              50),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 100,
                                  child: FutureBuilder(
                                      future:
                                          _getImage(context, docData["photo3"]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: snapshot.data,
                                          );
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Container();
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Text(
                                        docData['price3'],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/icons/token.png",
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.blue[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: Container(
                                  //container when clicked
                                  padding: new EdgeInsets.all(20.0),
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Do you want to buy this item ?",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22,
                                            color: Colors.deepOrange[900],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.0),
                                            child: Text(
                                              docData['cat_item4'] +
                                                  " : " +
                                                  docData['price4'],
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50),
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/images/icons/token.png",
                                            fit: BoxFit.contain,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Your name :",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            focusColor: Colors.white),
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Your Adress :",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            focusColor: Colors.white),
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      RaisedButton(
                                        onPressed: () {_buyItem(docData["price4"],docData["cat_item4"]);
                                        },
                                        child: Text("BUY"),
                                        color: Colors.green[100],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          //Container with photo
                          padding: new EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 2.6,
                          decoration:
                              BoxDecoration(color: Colors.deepOrange[100]),
                          child: Column(
                            children: [
                              Text(
                                docData['cat_item4'],
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 100,
                                child: FutureBuilder(
                                    future:
                                        _getImage(context, docData["photo4"]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: snapshot.data,
                                        );
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Container();
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Text(
                                      docData['price4'],
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/icons/token.png",
                                    fit: BoxFit.contain,
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      //Second Item
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.blue[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: Container(
                                  padding: new EdgeInsets.all(20.0),
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Do you want to buy this item ?",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22,
                                            color: Colors.deepOrange[900],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.0),
                                            child: Text(
                                              docData['cat_item5'] +
                                                  " : " +
                                                  docData['price5'],
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50),
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/images/icons/token.png",
                                            fit: BoxFit.contain,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Your name :",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            focusColor: Colors.white),
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Your Adress :",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            focusColor: Colors.white),
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      RaisedButton(
                                        onPressed: () {_buyItem(docData["price5"],docData["cat_item5"]);
                                        },
                                        child: Text("BUY"),
                                        color: Colors.green[100],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: new EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.height / 2.6,
                          decoration:
                              BoxDecoration(color: Colors.deepOrange[100]),
                          child: Column(
                            children: [
                              Text(
                                docData['cat_item5'],
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 100,
                                child: FutureBuilder(
                                    future:
                                        _getImage(context, docData["photo5"]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: snapshot.data,
                                        );
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Container();
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Text(
                                      docData['price5'],
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/icons/token.png",
                                    fit: BoxFit.contain,
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      //Third Item
                      InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.blue[100],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  elevation: 16,
                                  child: Container(
                                    padding: new EdgeInsets.all(20.0),
                                    height: MediaQuery.of(context).size.height /
                                        1.5,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ListView(
                                      children: <Widget>[
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Do you want to buy this item ?",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  22,
                                              color: Colors.deepOrange[900],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 4.0),
                                              child: Text(
                                                docData['cat_item6'] +
                                                    " : " +
                                                    docData['price6'],
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/icons/token.png",
                                              fit: BoxFit.contain,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Your name :",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white),
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                          child: Text(
                                            "Your Adress :",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        Center(
                                            child: TextField(
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              focusColor: Colors.white),
                                        )),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22),
                                        RaisedButton(
                                          onPressed: () {_buyItem(docData["price6"],docData["cat_item6"]);
                                          },
                                          child: Text("BUY"),
                                          color: Colors.green[100],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              padding: new EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 2.6,
                              decoration:
                                  BoxDecoration(color: Colors.deepOrange[100]),
                              child: Column(children: [
                                Text(
                                  docData['cat_item6'],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              50),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 100,
                                  child: FutureBuilder(
                                      future:
                                          _getImage(context, docData["photo6"]),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: snapshot.data,
                                          );
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Container();
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 4.0),
                                      child: Text(
                                        docData['price6'],
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                50),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/icons/token.png",
                                      fit: BoxFit.contain,
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                  ],
                                )
                              ])))
                    ]),
                    Row(children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                backgroundColor: Colors.blue[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: Container(
                                  //container when clicked
                                  padding: new EdgeInsets.all(20.0),
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Do you want to buy this item ?",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22,
                                            color: Colors.deepOrange[900],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.0),
                                            child: Text(
                                              docData['cat_item7'] +
                                                  " : " +
                                                  docData['price7'],
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height /
                                                          50),
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/images/icons/token.png",
                                            fit: BoxFit.contain,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Your name :",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            focusColor: Colors.white),
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                        child: Text(
                                          "Your Adress :",
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      Center(
                                          child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            focusColor: Colors.white),
                                      )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22),
                                      RaisedButton(
                                        onPressed: () {_buyItem(docData["price7"],docData["cat_item7"]);
                                        },
                                        child: Text("BUY"),
                                        color: Colors.green[100],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          //Container with photo
                          padding: new EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 3.0,
                          height: MediaQuery.of(context).size.height / 2.6,
                          decoration:
                              BoxDecoration(color: Colors.deepOrange[100]),
                          child: Column(
                            children: [
                              Text(
                                docData['cat_item7'],
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 100,
                                child: FutureBuilder(
                                    future:
                                        _getImage(context, docData["photo7"]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: snapshot.data,
                                        );
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              4,
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Container();
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.0),
                                    child: Text(
                                      docData['price7'],
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/icons/token.png",
                                    fit: BoxFit.contain,
                                    width:
                                        MediaQuery.of(context).size.width / 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ])
                  ])
            ]));
          }),
    );
  }

  _buyItem(String price,String name) {
    int getprice = int.parse(price);
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      if (value.data()["token"] - getprice >= 0) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({"token": (value.data()["token"] - getprice)});
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('The item('+ name +') ordered succesfully!!'),
        ));
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('You dont have enough money'),
        ));
      }
    });
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(value.toString(), fit: BoxFit.scaleDown);
    });
    return image;
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
