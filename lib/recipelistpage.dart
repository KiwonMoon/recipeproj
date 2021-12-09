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

  Future<List<RecipeModel>> fetchRecipe() async {
    List<RecipeModel> recipes = [];

    var result = await FirebaseFirestore.instance
        .collection("recipe")
        .get();

    result.docs.forEach((element) {
      var recipe = RecipeModel.fromJson(element.data());

      var recipeAvailable = true;

      for(int i = 0; i < recipe.ingredientlist.length; i++) {
        if(!widget.nameList.contains(recipe.ingredientlist[i])) {
          recipeAvailable = false;
        }
      }

      if(recipeAvailable) recipes.add(recipe);
    });

    return recipes;
  }



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
        centerTitle: true,
        title: Text('모앱개 레시피',),
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
        child: FutureBuilder(
            future: fetchRecipe(),
            builder: (BuildContext context, AsyncSnapshot<List<RecipeModel>> snapshot) {
              if(snapshot.hasData == false) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, index) => InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RecipeDetailPage(recipemodel: snapshot.data![index])));
                    },
                    child: Card(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Card(
                              child: Image.network(snapshot.data?[index].imagepath ?? ""),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: ListTile(
                              title: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                                child: Center(
                                  child: Text(snapshot.data?[index].recipetitle ?? "", style: TextStyle(fontSize: 20.0),),
                                ),
                              ),
                              isThreeLine: true,
                              subtitle: Text(snapshot.data?[index].recipeinfo ?? "",),
                              dense: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
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