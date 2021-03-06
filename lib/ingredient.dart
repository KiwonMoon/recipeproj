import 'package:flutter/material.dart';
import 'package:recipe_project/categoryList.dart';
import 'package:recipe_project/ingredient_add.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:intl/intl.dart';
import 'package:recipe_project/recipelistpage.dart';
import 'package:recipe_project/chart.dart';
import 'model/category_repository.dart';
import 'model/category_model.dart';
import 'bookmark.dart';
import 'package:recipe_project/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model/login.dart';
import 'map.dart';
import 'calendar.dart';

class Ingredient extends StatefulWidget {
  @override
  _IngredientState createState() => _IngredientState();
}
List bookmarkImg = [];
List bookmarkTitle = [];
class _IngredientState extends State<Ingredient> {
  List<String> searchNameList = [];
  Future<void> getData() async {
    QuerySnapshot snap = await
    FirebaseFirestore.instance.collection('recipe').get();
    var titleSearch;
    snap.docs.forEach((document) {
      titleSearch = document.data();
      searchNameList.add(titleSearch['recipetitle']);
    });
    print('searchNameList::: $searchNameList');
  }

  List<Card> _buildGridCategory(BuildContext context) {
    List<CategoryModel> products = CategoryRepository.loadCategories();

    if(products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AspectRatio(aspectRatio: 1/1,
                child: Image.asset(
                  product.img,
                ),),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(product.name, style: TextStyle(fontSize: 15),),
                ],
              ),
            ],
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => CateList(categoryName: product.name)));
            //Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage()),);
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List nameList = [];
    List imgList = [];

    if(googlelogin == true) {
      FirebaseFirestore.instance
          .collection('selectedIngredients')//nJUyGFy03UQtfVIAEnCcraydKA53
          .doc('${currentUserID!.uid}')
          .get()
          .then((DocumentSnapshot document) {
        imgList.addAll(document['img']);
        nameList.addAll(document['name']);
      });
      FirebaseFirestore.instance
          .collection('bookmark')
          .doc('${currentUserID!.uid}')
          .get()
          .then((DocumentSnapshot document) {
        bookmarkImg.addAll(document['img']);
        bookmarkTitle.addAll(document['recipeTitle']);
      });
    } else if(selected.length > 0) {
      FirebaseFirestore.instance
          .collection('selectedIngredients')
          .doc('${currentUserID!.uid}')
          .get()
          .then((DocumentSnapshot document) {
        imgList.addAll(document['img']);
        nameList.addAll(document['name']);
      });
    }

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('RECIPE'),
          leading: IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
              size: 33.0,
            ),
            onPressed: () {
              getData();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Search(recipeList: searchNameList)),);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.bookmark_border,
                semanticLabel: 'bookmark',
                size: 33.0,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarkPage()),);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                semanticLabel: 'bookmark',
                size: 33.0,
              ),
              onPressed: () {
                if(googlelogin == true) {
                  googleSignIn.signOut();
                  print('GOOGLE LOGOUT');
                }else {
                  FirebaseAuth.instance.signOut();
                  print('GUEST LOGOUT');
                }
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: '????????????',
              ),
              Tab(
                text: '??????',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: 3 / 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 2,
                            children: _buildGridCategory(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 70,),
                      RaisedButton(
                        child: Text(
                          '?????? ????????????',
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        color: Colors.redAccent,
                        padding: EdgeInsets.fromLTRB(55, 15, 55, 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0))),
                        onPressed: () {
                          //  MapPage
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MapPage()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('selectedIngredients')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return Text("Error: ${snapshot.error}");
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Text("Loading...");
                        default:
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    // if (userID != 'user1')
                                    // if(googlelogin == false && nameList.isEmpty)
                                    if(nameList.isEmpty)
                                      addIngredients(currentUserID!.uid);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddIngredient(
                                                  nameList: nameList,
                                                  imgList: imgList,
                                                )));
                                  },
                                ),
                                // if (userID == 'user1')
                                if(nameList.isNotEmpty)
                                  GridView.count(
                                      crossAxisCount: 5,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      childAspectRatio: 3 / 5,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 2,
                                      children: List.generate(nameList.length,
                                              (index) {
                                            return Card(
                                                child: InkWell(
                                                  child: Column(
                                                    children: <Widget>[
                                                      AspectRatio(
                                                        aspectRatio: 1 / 1,
                                                        child:
                                                        Image.asset(imgList[index]),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(nameList[index]),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (BuildContext context) {
                                                          return AlertDialog(
                                                            title: new Text(
                                                                "????????? ????????? ?????????????????????????"),
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                child: Text('???'),
                                                                onPressed: () {
                                                                  nameList
                                                                      .removeAt(index);
                                                                  imgList
                                                                      .removeAt(index);
                                                                  deleteIngredients(
                                                                      currentUserID!.uid,
                                                                      nameList,
                                                                      imgList);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                              FlatButton(
                                                                child: Text('?????????'),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              )
                                                            ],
                                                          );
                                                        });
                                                  },
                                                ));
                                          })),
                                // if(userID!='user1')
                                if(nameList.isEmpty && selected.isEmpty)
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 60,
                                        ),
                                        Text(
                                          '???????????? ???????????????.\n'
                                              '+ ????????? ?????? ?????? ????????? ??????????????????!',
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
                                    '?????? ??????',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  color: Colors.deepOrange,
                                  padding: EdgeInsets.fromLTRB(55, 15, 55, 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecipeListPage(nameList: nameList)));
                                  },
                                ),
                                SizedBox(height: 5,),
                                RaisedButton(
                                  child: Text(
                                    '?????? ??????',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  color: Colors.deepOrange,
                                  padding: EdgeInsets.fromLTRB(55, 15, 55, 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChartPage()));
                                  },
                                ),
                                SizedBox(height: 5,),
                                RaisedButton(
                                  child: Text(
                                    '?????? ?????? ??????',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  color: Colors.deepOrange,
                                  padding: EdgeInsets.fromLTRB(38, 15, 38, 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Calendar()));
                                  },
                                ),
                              ],
                            ),
                          );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      length: 2,
    );
  }

  Future<void> addIngredients(String userID) async {
    FirebaseFirestore.instance
        .collection('selectedIngredients')
        .doc(userID)
        .set({
      // 'name': FieldValue.arrayUnion(['first']),
      // 'img': FieldValue.arrayUnion(['first']),
    }).then((value) {
      print('INGREDIENTS ADDED');
    }).catchError((error) => print("Failed to add product: $error"));
  }

  Future<void> deleteIngredients(String userID, List name, List img) async {
    FirebaseFirestore.instance
        .collection('selectedIngredients')
        .doc(userID)
        .delete();
    FirebaseFirestore.instance
        .collection('selectedIngredients')
        .doc(userID)
        .set({
      'name': FieldValue.arrayUnion(name),
      'img': FieldValue.arrayUnion(img),
    }).then((value) {
      print('DELETE INGREDIENTS SUCCESS');
    }).catchError((error) => print("Failed to delete product: $error"));
  }
}
