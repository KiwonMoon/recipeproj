import 'package:flutter/material.dart';
import 'recipeaddpage.dart';
import 'recipedetailpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/recipe_model.dart';
import 'bookmark.dart';

class RecipeListPage extends StatefulWidget {
  List nameList = [];
  RecipeListPage({required this.nameList, Key? key}): super(key: key);
  // RecipeListPage({Key? key}) : super(key: key);

  static const mainColor = Color(0x80E33B1E);
  static const mainBackgroundColor = Color(0xffE598BB);

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  @override
  Widget build(BuildContext context) {
    print('${widget.nameList}');

    return Scaffold(
      backgroundColor: RecipeListPage.mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: RecipeListPage.mainColor, size: 30.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('모앱개 레시피', style: TextStyle(color: Colors.black,),),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border_outlined, color: Colors.black, size: 33.0,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => BookmarkPage()),);
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('recipe')
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
                              child: Text(snapshot.data?.docs[index]['recipetitle'], style: TextStyle(fontSize: 18.0),),
                            ),
                          ),
                          isThreeLine: true,
                          subtitle: Text(snapshot.data?.docs[index]['recipeinfo'], style: TextStyle(fontSize: 10.0),),
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
