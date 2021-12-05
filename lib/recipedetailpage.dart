import 'package:flutter/material.dart';
import 'model/recipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'recipeeditpage.dart';


class RecipeDetailPage extends StatefulWidget {
  final RecipeModel recipemodel;
  const RecipeDetailPage({required this.recipemodel});

  static const mainColor = Color(0x80E33B1E);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {

  void deleteDoc(String docID) {
    FirebaseFirestore.instance.collection('recipe').doc(docID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: RecipeDetailPage.mainColor, size: 30.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('모앱개 레시피', style: TextStyle(color: Colors.black,),),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RecipeEditPage(recipemodel: widget.recipemodel)));
            },
            icon: Icon(Icons.edit, color: RecipeDetailPage.mainColor, size: 30.0,),
          ),
          IconButton(
            onPressed: (){
              deleteDoc(widget.recipemodel.recipetitle);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete, color: RecipeDetailPage.mainColor, size: 30.0,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Image.network(widget.recipemodel.imagepath, width: 600, height: 240, fit: BoxFit.cover,),
              ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.bookmark_border_outlined, color: Colors.black, size: 30.0,),
                  onPressed: (){
                    print(widget.recipemodel.recipetitle);
                  },
                ),
              ),
              ListTile(
                title: Container(
                  child: Center(
                    child: Text(widget.recipemodel.recipetitle, style: TextStyle(fontSize: 30),),
                  ),
                ),
                subtitle: Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
                  child: Center(
                    child: Text(widget.recipemodel.recipeinfo),
                  ),
                ),
                isThreeLine: true,
                dense: true,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.person_outline,
                          ),
                          Text(widget.recipemodel.peoplecount, style: TextStyle(fontSize: 11.0,),),
                        ],
                      ),
                      padding: EdgeInsets.all(25.0),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.access_time,
                          ),
                          Text(widget.recipemodel.cookingtime, style: TextStyle(fontSize: 11.0,),),
                        ],
                      ),
                      padding: EdgeInsets.all(25.0),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.star_border,
                          ),
                          Text(widget.recipemodel.difficulty, style: TextStyle(fontSize: 11.0,),),
                        ],
                      ),
                      padding: EdgeInsets.all(25.0),
                    ),
                  ],
                ),
              ),
              Container(
                child: Divider(
                  indent: 15,
                  endIndent: 15,
                  thickness: 1,
                  color: RecipeDetailPage.mainColor,
                ),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text('기본재료', style: TextStyle(fontSize: 12.0),)
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text('')
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.recipemodel.ingredientlist.length,
                      itemBuilder: (BuildContext context, int index){
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(widget.recipemodel.ingredientlist[index], style: TextStyle(fontSize: 12.0),)
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(widget.recipemodel.quantitylist[index], style: TextStyle(fontSize: 12.0),)
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text('조리순서', style: TextStyle(fontSize: 12.0),)
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text('')
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.recipemodel.cookinfolist.length,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 7,
                                child: Image.network(widget.recipemodel.cookimglist[index]),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Flexible(
                                flex: 1,
                                child: Text((index + 1).toString()),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Flexible(
                                flex: 10,
                                child: Text(widget.recipemodel.cookinfolist[index], style: TextStyle(fontSize: 11.0),),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}