import 'package:flutter/material.dart';
import 'package:recipe_project/ingredient.dart';
import 'package:recipe_project/model/ingredients_model.dart';
import 'package:recipe_project/model/ingredients_repository.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:intl/intl.dart';
import 'package:recipe_project/model/login.dart';

class AddIngredient extends StatefulWidget {
  var nameList, imgList;
  AddIngredient({this.nameList, this.imgList});
  @override
  _AddIngredientState createState() => _AddIngredientState();
}

List selected=[];
var selectedMap = Map<String, String>();

class _AddIngredientState extends State<AddIngredient> {

  List<Card> _buildGridGrain(BuildContext context) {
    List<IngredientModel> products = IngredientsRepository.loadIngredients(Category.grain);

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
                  // if(selected.contains(product.name))
                  if(widget.nameList.contains(product.name))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,8,0),
                      child: Icon(Icons.circle, size: 5,),
                    ),
                  Text(product.name),
                ],
              ),
            ],
          ),
          onTap: (){
            print('tap: ${product.name}');
            selected.add(product.name);
            selectedMap[product.name] = product.img;
            print('<<map>>\n');
            print(selectedMap);
            addIngredients(currentUserID!.uid, product.name, product.img);
          },
        ),
      );
    }).toList();
  }
  List<Card> _buildGridMeat(BuildContext context) {
    List<IngredientModel> products = IngredientsRepository.loadIngredients(Category.meat);

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
                  // if(selected.contains(product.name))
                  if(widget.nameList.contains(product.name))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,8,0),
                      child: Icon(Icons.circle, size: 5,),
                    ),
                  Text(product.name),
                ],
              ),
            ],
          ),
          onTap: (){
            print('tap: ${product.name}');
            selected.add(product.name);
            selectedMap[product.name] = product.img;
            print('<<map>>\n');
            print(selectedMap);
            addIngredients(currentUserID!.uid, product.name, product.img);
          },
        ),
      );
    }).toList();
  }
  List<Card> _buildGridProcessed(BuildContext context) {
    List<IngredientModel> products = IngredientsRepository.loadIngredients(Category.processed);

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
                  // if(selected.contains(product.name))
                  if(widget.nameList.contains(product.name))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,8,0),
                      child: Icon(Icons.circle, size: 5,),
                    ),
                  Text(product.name, style: TextStyle(fontSize: 10),),
                ],
              ),
            ],
          ),
          onTap: (){
            print('tap: ${product.name}');
            selected.add(product.name);
            selectedMap[product.name] = product.img;
            print('<<map>>\n');
            print(selectedMap);
            // addIngredients(userID, product.name, product.img);
            addIngredients(currentUserID!.uid, product.name, product.img);
          },
        ),
      );
    }).toList();
  }
  List<Card> _buildGridVegetable(BuildContext context) {
    List<IngredientModel> products = IngredientsRepository.loadIngredients(Category.vegetable);

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
                  // if(selected.contains(product.name))
                  if(widget.nameList.contains(product.name))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,8,0),
                      child: Icon(Icons.circle, size: 5,),
                    ),
                  Text(product.name, style: TextStyle(fontSize: 10),),
                ],
              ),
            ],
          ),
          onTap: (){
            print('tap: ${product.name}');
            selected.add(product.name);
            selectedMap[product.name] = product.img;
            print('<<map>>\n');
            print(selectedMap);
            // addIngredients(userID, product.name, product.img);
            addIngredients(currentUserID!.uid, product.name, product.img);
          },
        ),
      );
    }).toList();
  }
  List<Card> _buildGridSeafood(BuildContext context) {
    List<IngredientModel> products = IngredientsRepository.loadIngredients(Category.seafood);

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
                  // if(selected.contains(product.name))
                  if(widget.nameList.contains(product.name))
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,8,0),
                      child: Icon(Icons.circle, size: 5,),
                    ),
                  Text(product.name, style: TextStyle(fontSize: 10),),
                ],
              ),
            ],
          ),
          onTap: (){
            print('tap: ${product.name}');
            selected.add(product.name);
            selectedMap[product.name] = product.img;
            print('<<map>>\n');
            print(selectedMap);
            // addIngredients(userID, product.name, product.img);
            addIngredients(currentUserID!.uid, product.name, product.img);
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('재료 추가하기'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      '곡물',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      childAspectRatio: 3 / 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 2,
                      children: _buildGridGrain(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '고기',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      childAspectRatio: 3 / 5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 2,
                      children: _buildGridMeat(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '채소',
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      childAspectRatio: 3 / 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 2,
                      children: _buildGridVegetable(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '해산물',
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      childAspectRatio: 3 / 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 2,
                      children: _buildGridSeafood(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '가공/유제품',
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 5,
                      childAspectRatio: 3 / 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 2,
                      children: _buildGridProcessed(context),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                RaisedButton(
                  child: Text(
                    '확인',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.deepOrange,
                  padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Ingredient()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addIngredients(String userID, String name,String img) async{
    FirebaseFirestore.instance.collection('selectedIngredients').doc(userID).update({
      // 'name': FieldValue.arrayUnion(['${selectedMap.entries}']),
      // 'img': FieldValue.arrayUnion(['${selectedMap.entries}']),
      'name': FieldValue.arrayUnion(['${name}']),
      'img': FieldValue.arrayUnion(['${img}']),
    }).then((value) {
      print('INGREDIENTS UPDATED');
    }).catchError((error) => print("Failed to add product: $error"));
  }
}

// String userID = 'user1';