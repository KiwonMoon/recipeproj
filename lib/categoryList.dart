import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_project/recipeaddpage.dart';
import 'package:recipe_project/recipedetailpage.dart';
import 'package:recipe_project/recipelistpage.dart';

import 'bookmark.dart';
import 'model/recipe_model.dart';

class CateList extends StatefulWidget {
  String categoryName;
  CateList({required this.categoryName});
  @override
  _CateListState createState() => _CateListState();
}

class _CateListState extends State<CateList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('RECIPE',),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border_outlined, size: 33.0,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarkPage()),);
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('recipe')
              .where("recipecategory", isEqualTo: widget.categoryName)
          // .where('ingredientlist', arrayContains: widget.nameList[0])
              .snapshots(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (ctx, index) => InkWell(
                onTap: (){
                  RecipeModel recipemodel = RecipeModel(recipecategory: snapshot.data?.docs[index]['recipecategory'], recipetitle: snapshot.data?.docs[index]['recipetitle'],
                      recipeinfo: snapshot.data?.docs[index]['recipeinfo'], imagepath: snapshot.data?.docs[index]['imagepath'],
                      peoplecount: snapshot.data?.docs[index]['peoplecount'], cookingtime: snapshot.data?.docs[index]['cookingtime'],
                      difficulty: snapshot.data?.docs[index]['difficulty'], ingredientlist: snapshot.data?.docs[index]['ingredientlist'],
                      quantitylist: snapshot.data?.docs[index]['quantitylist'], cookinfolist: snapshot.data?.docs[index]['cookinfolist'],
                      cookimglist: snapshot.data?.docs[index]['cookimglist']);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RecipeDetailPage(recipemodel: recipemodel)));
                },
                child: Card(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Card(
                          child: Image.network(snapshot.data?.docs[index]['imagepath']),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: ListTile(
                          title: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                            child: Center(
                              child: Text(snapshot.data?.docs[index]['recipetitle'], style: TextStyle(fontSize: 20.0),),
                            ),
                          ),
                          isThreeLine: true,
                          subtitle: Text(snapshot.data?.docs[index]['recipeinfo'],),
                          dense: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecipeAddPage()));
        },
      ),
    );
  }
}
