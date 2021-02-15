import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Functions {
  listBuyItem(scaffold, BuildContext context, String name, int price,
      String imageName, Color color) {
    return InkWell(
        onTap: () => showBuyDialog(scaffold, context, name, price),
        child: Container(
            padding: EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(color: color),
            child: Column(children: [
              Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  height: MediaQuery.of(context).size.height / 18,
                  child: Text(name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 50))),
              FutureBuilder(
                  future: getImage(context, imageName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var imageData = snapshot.data;
                      if (snapshot.data == null)
                        imageData = AssetImage('assets/images/icons/error.png');
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(image: imageData));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Center(child: CircularProgressIndicator()));
                    }
                    return Container();
                  }),
              Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Text(price.toString(),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            50))),
                        Image.asset('assets/images/icons/token.png',
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width / 20)
                      ]))
            ])));
  }

  showBuyDialog(scaffold, BuildContext context, String name, int price) {
    TextEditingController nameController = new TextEditingController();
    TextEditingController addressController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          nameController.text = "";
          addressController.text = "";
          return Dialog(
              backgroundColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              elevation: 16,
              child: Container(
                  padding: EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ListView(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 60,
                                  bottom:
                                      MediaQuery.of(context).size.height / 60),
                              child: Text('Do you want to buy this item?',
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
                                      name + ' : ' + price.toString(),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              50),
                                    )),
                                Image.asset('assets/images/icons/token.png',
                                    fit: BoxFit.contain,
                                    width:
                                        MediaQuery.of(context).size.width / 20)
                              ]),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 60,
                                  bottom:
                                      MediaQuery.of(context).size.height / 60),
                              child: Text('Your name :',
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
                              child: Text('Your Address :',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.width / 22),
                              child: TextField(
                                  controller: addressController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      focusColor: Colors.white))),
                          RaisedButton(
                              child: Text('BUY'),
                              color: Colors.green[100],
                              onPressed: () => buyItem(
                                  scaffold,
                                  context,
                                  name,
                                  price,
                                  nameController.text,
                                  addressController.text))
                        ])
                  ])));
        });
  }

  buyItem(scaffold, BuildContext context, String orderName, int orderPrice,
      String name, String address) async {
    await FirebaseFirestore.instance
        .collection('market_orders')
        .doc('XdZPDnc7ouywfZHmHmjM')
        .get()
        .then((value) {
      String number = (value.data()['total_order_number'] + 1).toString();
      FirebaseFirestore.instance
          .collection('market_orders')
          .doc('XdZPDnc7ouywfZHmHmjM')
          .set({
        'buyer_name' + number: name,
        'address' + number: address,
        'order_name' + number: orderName,
        'order_price' + number: orderPrice,
        'total_order_number': FieldValue.increment(1)
      }).catchError((error) => scaffold.currentState.showSnackBar(
              SnackBar(content: Text('Failed to buy: ' + orderName + '!'))));
    }).catchError((error) => scaffold.currentState.showSnackBar(
            SnackBar(content: Text('Failed to buy: ' + orderName + '!'))));
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      Navigator.pop(context);
      if ((value.data()['token'] - orderPrice) > 0) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .update({'token': (value.data()['token'] - orderPrice)})
            .then((value) => {
                  scaffold.currentState.showSnackBar(SnackBar(
                      content: Text('The item(' +
                          orderName +
                          ') is ordered successfully!!')))
                })
            .catchError((error) => scaffold.currentState.showSnackBar(
                SnackBar(content: Text('Failed to buy: ' + orderName + '!'))));
      } else
        scaffold.currentState.showSnackBar(
            SnackBar(content: Text('You dont have enough money!')));
    }).catchError((error) => scaffold.currentState.showSnackBar(
            SnackBar(content: Text('Failed to buy: ' + orderName + '!'))));
  }

  Future<Object> getImage(BuildContext context, String imageName) async {
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
