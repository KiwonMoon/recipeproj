import 'package:flutter/material.dart';
import 'Recipe.dart';
import 'fav_recipe.dart';
import 'ingredient.dart';
import 'model/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

List marked = [];

class _BookmarkPageState extends State<BookmarkPage> {
  List<Recipe> favList = FavoriteRepository.loadFavList();

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
      itemCount: bookmarkTitle.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        final item = bookmarkTitle[index];
        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            setState(() {
              bookmarkTitle.removeAt(index);
              bookmarkImg.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$item deleted')));
            deleteBookmark(currentUserID!.uid, bookmarkTitle, bookmarkImg);
          },
          background: Container(
            color: Colors.red,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 10),
            visualDensity: VisualDensity(vertical: 4,horizontal: -3),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              child: Image.asset(
                bookmarkImg[index],
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
  Future<void> deleteBookmark(String userID, List title, List img) async {
    FirebaseFirestore.instance
        .collection('bookmark')
        .doc(userID)
        .delete();
    FirebaseFirestore.instance
        .collection('bookmark')
        .doc(userID)
        .set({
      'recipeTitle': FieldValue.arrayUnion(title),
      'img': FieldValue.arrayUnion(img),
    }).then((value) {
      print('DELETE BOOKMARK SUCCESS');
    }).catchError((error) => print("Failed to delete product: $error"));
  }
}
