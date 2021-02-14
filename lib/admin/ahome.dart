import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: new CircularProgressIndicator());
            }
            List<String> documentIDList = [], nameList = [], imageList = [];
            List<int> typeList = [], tokenList = [];

            var document = snapshot.data.docs;
            document.forEach((data) {
              String variable =
                  data.get('name') + ' ' + data.get('surname') + ': ';

              if (data.get('task1_sent')) {
                documentIDList.add(data.documentID);
                nameList.add(variable + data.get('task1_name'));
                imageList.add(data.get('task1_image'));
                typeList.add(1);
                tokenList.add(data.get('task1_token'));
              }
              if (data.get('task2_sent')) {
                documentIDList.add(data.documentID);
                nameList.add(variable + data.get('task2_name'));
                imageList.add(data.get('task2_image'));
                typeList.add(2);
                tokenList.add(data.get('task2_token'));
              }
              if (data.get('task3_sent')) {
                documentIDList.add(data.documentID);
                nameList.add(variable + data.get('task3_name'));
                imageList.add(data.get('task3_image'));
                typeList.add(3);
                tokenList.add(data.get('task3_token'));
              }
            });

            return CustomScrollView(
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
                              margin: EdgeInsets.all(5.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                ),
                                color: Colors.orangeAccent,
                                child: Text(nameList[index]),
                                onPressed: () {
                                  _showDialog(
                                      _scaffoldKey,
                                      context,
                                      documentIDList[index],
                                      nameList[index],
                                      tokenList[index],
                                      typeList[index],
                                      imageList[index]);
                                },
                              ),
                            ),
                        itemCount: nameList.length),
                  ),
                ),
              ],
            );
          }),
    );
  }

  _showDialog(scaffold, BuildContext context, String documentID, String name,
      int price, int type, String imageName) {
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
                              child: Text('REVIEW',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    color: Colors.deepOrange[900],
                                  ))),
                          Container(
                            padding: EdgeInsets.only(bottom: 20.0),
                            height: MediaQuery.of(context).size.height / 13,
                            child: Text(
                              name + ' : ' + price.toString(),
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height / 50),
                            ),
                          ),
                          FutureBuilder(
                              future: _getImage(context, imageName),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  var imageData = snapshot.data;
                                  if (snapshot.data == null)
                                    imageData = AssetImage(
                                        'assets/images/icons/error.png');
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image(image: imageData));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                }
                                return Container();
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: RaisedButton(
                                      child: Text('ACCEPT'),
                                      color: Colors.lightGreenAccent,
                                      onPressed: () => {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(documentID)
                                                .get()
                                                .then((value) {
                                              FirebaseStorage.instance
                                                  .ref()
                                                  .child(value.data()['task' +
                                                      type.toString() +
                                                      '_image'])
                                                  .delete();

                                              FirebaseFirestore.instance
                                                  .collection('tasks')
                                                  .doc('Q8elnpjjwODUNKwp3uu6')
                                                  .update({
                                                'task' +
                                                        value.data()['task' +
                                                            type.toString() +
                                                            '_id'] +
                                                        '_total':
                                                    FieldValue.increment(1)
                                              });

                                              FirebaseFirestore.instance
                                                  .collection('tasks')
                                                  .doc(documentID)
                                                  .update({
                                                'task': FieldValue.arrayUnion([
                                                  (name.split(': ').last +
                                                      ' : (' +
                                                      price.toString() +
                                                      ')')
                                                ])
                                              });

                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(documentID)
                                                  .update({
                                                'token':
                                                    FieldValue.increment(price),
                                                'task' +
                                                    type.toString() +
                                                    '_name': '',
                                                'task' +
                                                    type.toString() +
                                                    '_image': '',
                                                'task' +
                                                    type.toString() +
                                                    '_token': 0,
                                                'task' +
                                                    type.toString() +
                                                    '_sent': false,
                                                'total_tasks':
                                                    FieldValue.increment(1)
                                              }).then((value) => {
                                                        Navigator.pop(context),
                                                        scaffold.currentState
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    'The task(' +
                                                                        name +
                                                                        ') is accepted!')))
                                                      });
                                            })
                                          })),
                              RaisedButton(
                                  child: Text('REJECT'),
                                  color: Colors.redAccent,
                                  onPressed: () => FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(documentID)
                                          .get()
                                          .then((value) {
                                        FirebaseStorage.instance
                                            .ref()
                                            .child(value.data()['task' +
                                                type.toString() +
                                                '_image'])
                                            .delete();
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(documentID)
                                            .update({
                                          'task' + type.toString() + '_image':
                                              '',
                                          'task' + type.toString() + '_token':
                                              0,
                                          'task' + type.toString() + '_sent':
                                              false
                                        }).then((value2) => {
                                                  Navigator.pop(context),
                                                  scaffold.currentState
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'The task(' +
                                                                  name +
                                                                  ') is rejected!')))
                                                });
                                      }))
                            ],
                          )
                        ],
                      )
                    ],
                  )));
        });
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
