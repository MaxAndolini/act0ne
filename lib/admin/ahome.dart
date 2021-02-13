import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> nameList = [], imageList = [];
    List<int> tokenList = [];
    return Scaffold(
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection("users").get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: new CircularProgressIndicator());
            }
            var document = snapshot.data.docs;
            document.forEach((data) {
              String variable =
                  data.get("name") + " " + data.get("surname") + ": ";

              if (data.get("task1_approve") == 1) {
                nameList.add(variable + data.get("task1_name"));
                imageList.add(data.get("task1_image"));
                tokenList.add(data.get("task1_token"));
              }
              if (data.get("task2_approve") == 1) {
                nameList.add(variable + data.get("task2_name"));
                imageList.add(data.get("task2_image"));
                tokenList.add(data.get("task2_token"));
              }
              if (data.get("task3_approve") == 1) {
                nameList.add(variable + data.get("task3_name"));
                imageList.add(data.get("task3_image"));
                tokenList.add(data.get("task3_token"));
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
                                  _showDialog(context, nameList[index],
                                      tokenList[index], imageList[index]);
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

  _showDialog(BuildContext context, String name, int price, String imageName) {
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
                              child: Text("REVIEW",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width / 22,
                                    color: Colors.deepOrange[900],
                                  ))),
                          Container(
                            padding: EdgeInsets.only(bottom: 20.0),
                            height: MediaQuery.of(context).size.height / 13,
                            child: Text(
                              name + " : " + price.toString(),
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
                                  if (snapshot.data == null)
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  else
                                    return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image(image: snapshot.data));
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
                                    onPressed: () => {},
                                    child: Text("ACCEPT"),
                                    color: Colors.lightGreenAccent,
                                  )),
                              RaisedButton(
                                onPressed: () => {},
                                child: Text("REJECT"),
                                color: Colors.redAccent,
                              )
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
