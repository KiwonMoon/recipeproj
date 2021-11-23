import 'package:flutter/material.dart';
import 'package:recipe_project/ingredient_add.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:intl/intl.dart';

class Ingredient extends StatefulWidget {
  @override
  _IngredientState createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
  List<Card> _buildSelectedIngredients(BuildContext context) {
    if (selected == null || selected.isEmpty) {
      return const <Card>[];
    }

    return selected.map((select) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // AspectRatio(
              //   aspectRatio: 1 / 1,
              //   child: Image.asset('name'),
              // ),
              SizedBox(
                height: 5,
              ),
              Text(select),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('RECIPE'),
          leading: IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.bookmark_border,
                semanticLabel: 'bookmark',
              ),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: '카테고리',
              ),
              Tab(
                text: '재료',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StreamBuilder<QuerySnapshot>(
                  stream: null,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              addIngredients(userID);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddIngredient()));
                            },
                          ),
                          if (selected.isNotEmpty)
                            GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: selectedMap.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 3 / 5,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 2,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: InkWell(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        AspectRatio(
                                          aspectRatio: 1 / 1,
                                          child: Image.asset(
                                            selectedMap.values.elementAt(index),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(selectedMap.keys.elementAt(index)),
                                      ],
                                    ),
                                    onTap: () {
                                      selectedMap.remove(
                                          selectedMap.keys.elementAt(index));
                                      print(selectedMap);
                                      // AlertDialog(
                                      //   title: new Text("선택한 재료를 삭제하시겠습니까?"),
                                      //   // content: new Text("Alert Dialog body"),
                                      //   actions: <Widget>[
                                      //     FlatButton(
                                      //       onPressed: () {
                                      //         selectedMap.remove(selectedMap.keys.elementAt(index));
                                      //         Navigator.pop(context);
                                      //         print(selectedMap);
                                      //       },
                                      //       child: new Text("예"),
                                      //     ),
                                      //     FlatButton(
                                      //       onPressed: () {
                                      //         Navigator.pop(context);
                                      //       },
                                      //       child: new Text("아니오"),
                                      //     ),
                                      //   ],
                                      // );
                                    },
                                  ),
                                );
                              },
                            ),
                          if (selected.isEmpty)
                            Container(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 60,),
                                  Text(
                                    '냉장고가 비었습니다.\n'
                                    '+ 버튼을 눌러 나의 재료를 추가해보세요!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: 40,
                          ),
                          RaisedButton(
                            child: Text(
                              '요리 보기',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            color: Colors.deepOrange,
                            padding: EdgeInsets.fromLTRB(55, 15, 55, 15),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      length: 2,
    );
  }
  Future<void> addIngredients(String userID) async{
    FirebaseFirestore.instance.collection('selectedIngredients').doc(userID).set({
      'name': FieldValue.arrayUnion(['first']),
      'img': FieldValue.arrayUnion(['first']),
    }).then((value) {
      print('INGREDIENTS ADDED');
    }).catchError((error) => print("Failed to add product: $error"));
  }
}
