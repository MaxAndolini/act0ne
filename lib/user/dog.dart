import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Dog extends StatefulWidget {
  @override
  _DogState createState() => _DogState();
}

class _DogState extends State<Dog> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController adressController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('market_items')
              .doc('ln7hUZU7RMAvRX2oUtV8')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: new CircularProgressIndicator());
            }
            var document = snapshot.data;
            nameController.text = "";
            adressController.text = "";
            return Container(
                child: ListView(children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      //First Item
                      _listItem(context, document['dog_item1'],
                          document['price1'], document['photo1']),

                      //Second Item
                      _listItem(context, document['dog_item2'],
                          document['price2'], document['photo2']),

                      //Third Item
                      _listItem(context, document['dog_item3'],
                          document['price3'], document['photo3'])
                    ]),
                    Row(children: [
                      //Fourth Item
                      _listItem(context, document['dog_item4'],
                          document['price4'], document['photo4']),

                      //Fifth Item
                      _listItem(context, document['dog_item5'],
                          document['price5'], document['photo5']),

                      //Sixth Item
                      _listItem(context, document['dog_item6'],
                          document['price6'], document['photo6'])
                    ]),
                    Row(children: [
                      //Seventh Item
                      _listItem(context, document['dog_item7'],
                          document['price7'], document['photo7'])
                    ])
                  ])
            ]));
          }),
    );
  }

  _listItem(BuildContext context, String name, String price, String imageName) {
    return InkWell(
      onTap: () => _showDialog(context, name, price),
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 2.8,
        decoration: BoxDecoration(color: Colors.deepOrange[100]),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              height: MediaQuery.of(context).size.height / 18,
              child: Text(name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height / 50)),
            ),
            FutureBuilder(
                future: _getImage(context, imageName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null)
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Center(child: CircularProgressIndicator()));
                    else
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(image: snapshot.data));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return Container();
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text(
                        price,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 50),
                      )),
                  Image.asset(
                    "assets/images/icons/token.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width / 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _showDialog(BuildContext context, String name, String price) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              elevation: 16,
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 60,
                                  bottom:
                                      MediaQuery.of(context).size.height / 60),
                              child: Text("Do you want to buy this item?",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    color: Colors.deepOrange[900],
                                  ))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Text(
                                    name + " : " + price,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50),
                                  )),
                              Image.asset(
                                "assets/images/icons/token.png",
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width / 20,
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 60,
                                  bottom:
                                      MediaQuery.of(context).size.height / 60),
                              child: Text("Your name :",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          TextField(
                              controller: nameController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration:
                                  InputDecoration(focusColor: Colors.white)),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 60,
                                  bottom:
                                      MediaQuery.of(context).size.height / 60),
                              child: Text("Your Address :",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.width / 22),
                            child: TextField(
                              controller: adressController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration:
                                  InputDecoration(focusColor: Colors.white),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () => _buyItem(name, price,
                                nameController.text, adressController.text),
                            child: Text("BUY"),
                            color: Colors.green[100],
                          )
                        ],
                      )
                    ],
                  )));
        });
  }

  _buyItem(String orderName, String orderPrice, String name, String adress) {
    FirebaseFirestore.instance
        .collection("Orders")
        .doc("tImH8cjhBGx4XT3AfJfx")
        .get()
        .then((value) {
      FirebaseFirestore.instance
          .collection("Orders")
          .doc("tImH8cjhBGx4XT3AfJfx")
          .update({
        'total_order_number': (value.data()["total_order_number"] + 1),
      });
      FirebaseFirestore.instance
          .collection("Orders")
          .doc("tImH8cjhBGx4XT3AfJfx")
          .update({
        'buyer_name' + (value.data()["total_order_number"] + 1).toString(): name,
        'adress' + (value.data()["total_order_number"] + 1).toString(): adress,
        'order_name' + (value.data()["total_order_number"] + 1).toString(): orderName,
        'order_price' + (value.data()["total_order_number"] + 1).toString():
            orderPrice,
      });
    });

    int getPrice = int.parse(orderPrice);
    return FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      if (value.data()["token"] - getPrice >= 0) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({"token": (value.data()["token"] - getPrice)});
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content:
              Text('The item(' + orderName + ') is ordered successfully!!'),
        ));
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('You dont have enough money'),
        ));
      }
    });
  }

  Future<Object> _getImage(BuildContext context, String imageName) async {
    ImageProvider image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = NetworkImage(value.toString());
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
