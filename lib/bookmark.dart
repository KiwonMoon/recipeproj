import 'package:flutter/material.dart';
import 'package:recipe_project/model/recipe_model.dart';
import 'package:recipe_project/recipedetailpage.dart';
import 'Recipe.dart';
import 'fav_recipe.dart';
import 'model/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

List marked = [];

class _BookmarkPageState extends State<BookmarkPage> {
  //List<Recipe> favList = FavoriteRepository.loadFavList();
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference bookmarks =
  FirebaseFirestore.instance.collection('bookmark');
  List<dynamic> imgs = [];
  List<dynamic> recipeTitles = [];

  Future<dynamic> fetchBookmarks() async {
    var currentUser = _auth.currentUser!;
    var result = await FirebaseFirestore.instance
        .collection("bookmark")
        .doc(currentUser.uid)
        .get();


    result.data()!.forEach((key, value) {
      if (key == "img") {
        imgs = value as List;
      }
      else if (key == "recipeTitle") {
        recipeTitles = value as List;
      }
    });

    setState(() {});
  }

  Future<dynamic> findRecipe(String recipeTitle) async {
    var result = await FirebaseFirestore.instance
        .collection("recipe")
        .doc(recipeTitle)
        .get();

    RecipeModel recipeModel = RecipeModel.fromJson(result.data()!);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RecipeDetailPage(recipemodel: recipeModel)));
  }

  @override
  void initState() {
    fetchBookmarks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List markTitle = [];
    // List markImg = [];
    // FirebaseFirestore.instance
    //     .collection('bookmark')
    //     .doc('${currentUserID!.uid}')
    //     .get()
    //     .then((DocumentSnapshot document) {
    //   markImg.addAll(document['img']);
    //   markTitle.addAll(document['recipeTitle']);
    //   print('$markTitle');
    // }).catchError((error) => print("Failed to load bookmark: $error"));

    // if(googlelogin == true) {
    //   FirebaseFirestore.instance
    //       .collection('bookmark')
    //       .doc('${currentUserID!.uid}')
    //       .get()
    //       .then((DocumentSnapshot document) {
    //     markImg.addAll(document['img']);
    //     markTitle.addAll(document['recipeTitle']);
    //   });
    // }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("북마크 리스트"),
      ),
      body: ListView.separated(
        itemCount: recipeTitles.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(),
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          final item = recipeTitles[index];
          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              setState(() {
                recipeTitles.removeAt(index);
                imgs.removeAt(index);
              });
              updateBookmark(currentUserID!.uid);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$item deleted')));

            },
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              onTap: () {
                findRecipe(recipeTitles[index]);
                print("press");
              },
              contentPadding: EdgeInsets.only(left: 10),
              visualDensity: VisualDensity(vertical: 4,horizontal: -3),
              leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                child: Image.asset(
                  imgs[index],
                  fit: BoxFit.cover,
                  width: 140,
                ),
              ),
              title: Text(
                item,
                style: TextStyle(color: Colors.black),
              ),
              // subtitle: Text(
              //   item.description,
              //   style: TextStyle(color: Colors.grey),
              // ),
            ),
          );
        },
      ),
    );
  }
  Future<void> updateBookmark(String userID) async {
    var currentUser = _auth.currentUser!;

    bookmarks.doc(currentUser.uid).update({
      'img': imgs,
      'recipeTitle': recipeTitles
      // 42
    }).then((value) {
      print('DELETE BOOKMARK SUCCESS');
    }).catchError((error) => print("Failed to add bookmark: $error"));

  }
}
