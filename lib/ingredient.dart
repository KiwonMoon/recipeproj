import 'package:flutter/material.dart';
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

class Ingredient extends StatefulWidget {
  @override
  _IngredientState createState() => _IngredientState();
}

class _IngredientState extends State<Ingredient> {
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

    FirebaseFirestore.instance
        .collection('selectedIngredients')
        .doc('$userID')
        .get()
        .then((DocumentSnapshot document) {
      imgList.addAll(document['img']);
      nameList.addAll(document['name']);
    });

    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text('RECIPE'),
          leading: IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Search()),);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.bookmark_border,
                semanticLabel: 'bookmark',
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarkPage()),);
              },
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
                                    if (userID != 'user1')
                                      addIngredients(userID);
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
                                if (userID == 'user1')
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
                                                        "선택한 재료를 삭제하시겠습니까?"),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        child: Text('예'),
                                                        onPressed: () {
                                                          nameList
                                                              .removeAt(index);
                                                          imgList
                                                              .removeAt(index);
                                                          deleteIngredients(
                                                              userID,
                                                              nameList,
                                                              imgList);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      FlatButton(
                                                        child: Text('아니오'),
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
                                if(userID!='user1')
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 60,
                                        ),
                                        Text(
                                          '냉장고가 비었습니다.\n'
                                              '+ 버튼을 눌러 나의 재료를 추가해보세요!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                /*if (selected.isNotEmpty)
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          AspectRatio(
                                            aspectRatio: 1 / 1,
                                            child: Image.asset(
                                              selectedMap.values
                                                  .elementAt(index),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(selectedMap.keys
                                              .elementAt(index)),
                                        ],
                                      ),
                                      onTap: () {
                                        selectedMap.remove(
                                            selectedMap.keys.elementAt(index));
                                        print(selectedMap);
                                      },
                                    ),
                                  );
                                },
                              ),
                            if (selected.isEmpty)
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Text(
                                      '냉장고가 비었습니다.\n'
                                      '+ 버튼을 눌러 나의 재료를 추가해보세요!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),*/
                                SizedBox(
                                  height: 40,
                                ),
                                RaisedButton(
                                  child: Text(
                                    '요리 보기',
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
                                                RecipeListPage()));
                                  },
                                ),
                                SizedBox(height: 5,),
                                RaisedButton(
                                  child: Text(
                                    '요리 보기',
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

// List nameList = [];
// List imgList = [];
