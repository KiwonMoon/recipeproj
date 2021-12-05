import 'package:flutter/material.dart';
import 'model/recipe_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeDetailPage extends StatefulWidget {
  final RecipeModel recipemodel;
  const RecipeDetailPage({required this.recipemodel});

  static const mainColor = Color(0x80E33B1E);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference bookmarks =
  FirebaseFirestore.instance.collection('bookmark');
  List<dynamic> imgs = [];
  List<dynamic> recipeTitles = [];
  IconData bookmarkIcon = Icons.bookmark_border_outlined;

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

    if(recipeTitles.contains(widget.recipemodel.recipetitle)) {
      setState(() {
        bookmarkIcon = Icons.bookmark_outlined;
      });
    }

  }

  Future<void> addOrDeleteBookmark() async {

    if(!recipeTitles.contains(widget.recipemodel.recipetitle)) {
      imgs.add(widget.recipemodel.imagepath);
      recipeTitles.add(widget.recipemodel.recipetitle);

      var currentUser = _auth.currentUser!;

      bookmarks.doc(currentUser.uid).update({
        'img': imgs,
        'recipeTitle': recipeTitles
        // 42
      }).catchError((error) => print("Failed to add bookmark: $error"));

      setState(() {
        bookmarkIcon = Icons.bookmark_outlined;
      });

      const snackBar = SnackBar(
          behavior: SnackBarBehavior.floating, content: Text('BOOKMARKED!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {

      imgs.remove(widget.recipemodel.imagepath);
      recipeTitles.remove(widget.recipemodel.recipetitle);

      var currentUser = _auth.currentUser!;

      bookmarks.doc(currentUser.uid).update({
        'img': imgs,
        'recipeTitle': recipeTitles
        // 42
      }).catchError((error) => print("Failed to add bookmark: $error"));

      setState(() {
        bookmarkIcon = Icons.bookmark_border_outlined;
      });

      const snackBar = SnackBar(
          behavior: SnackBarBehavior.floating, content: Text('BOOKMARKED DELETED!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    fetchBookmarks();
    super.initState();
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: [
              Image.network(widget.recipemodel.imagepath, width: 600, height: 240, fit: BoxFit.cover,),
              ListTile(
                trailing: IconButton(
                  icon: Icon(bookmarkIcon, color: Colors.black, size: 30.0,),
                  onPressed: (){
                    addOrDeleteBookmark();

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
                                child: Text((widget.recipemodel.cookinfolist.length + 1).toString()),
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
        // slivers: [
        //   SliverAppBar(
        //     expandedHeight: 200.0,
        //     automaticallyImplyLeading: false,
        //     flexibleSpace: FlexibleSpaceBar(
        //       background: Image.asset('images/grain/corn.png', fit: BoxFit.fitWidth,),
        //     ),
        //   ),
        //   SliverToBoxAdapter(
        //     child: SafeArea(
        //       child: Container(
        //         child: Column(
        //           children: [
        //             ListTile(
        //               trailing: IconButton(
        //                 icon: Icon(Icons.bookmark_border_outlined, color: Colors.black, size: 30.0,),
        //                 onPressed: (){},
        //               ),
        //             ),
        //             ListTile(
        //               title: Container(
        //                 child: Center(
        //                   child: Text('해물 파전', style: TextStyle(fontSize: 30),),
        //                 ),
        //               ),
        //               subtitle: Container(
        //                 padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
        //                 child: Center(
        //                   child: Text('“파전의 재발견 - 달짝지근한 파와 고소한 불고기로 즐거운 식탁을 만들어 보세요”'),
        //                 ),
        //               ),
        //               isThreeLine: true,
        //               dense: true,
        //             ),
        //             Container(
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Container(
        //                     child: Column(
        //                       children: [
        //                         Icon(
        //                           Icons.person_outline,
        //                         ),
        //                         Text('2인분', style: TextStyle(fontSize: 11.0,),),
        //                       ],
        //                     ),
        //                     padding: EdgeInsets.all(25.0),
        //                   ),
        //                   Container(
        //                     child: Column(
        //                       children: [
        //                         Icon(
        //                           Icons.access_time,
        //                         ),
        //                         Text('30분 이내', style: TextStyle(fontSize: 11.0,),),
        //                       ],
        //                     ),
        //                     padding: EdgeInsets.all(25.0),
        //                   ),
        //                   Container(
        //                     child: Column(
        //                       children: [
        //                         Icon(
        //                           Icons.star_border,
        //                         ),
        //                         Text('초급', style: TextStyle(fontSize: 11.0,),),
        //                       ],
        //                     ),
        //                     padding: EdgeInsets.all(25.0),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               child: Divider(
        //                 indent: 15,
        //                 endIndent: 15,
        //                 thickness: 1,
        //                 color: mainColor,
        //               ),
        //             ),
        //             Container(
        //               margin: EdgeInsets.all(16.0),
        //               child: Column(
        //                 children: <Widget>[
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                     children: [
        //                       Flexible(
        //                         flex: 1,
        //                         child: Container(
        //                             width: MediaQuery.of(context).size.width,
        //                             child: Text('기본재료', style: TextStyle(fontSize: 12.0),)
        //                         ),
        //                       ),
        //                       Flexible(
        //                         flex: 1,
        //                         child: Container(
        //                             width: MediaQuery.of(context).size.width,
        //                             child: Text('')
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   Divider(
        //                     thickness: 2,
        //                     color: Colors.black,
        //                   ),
        //                   ListView.builder(
        //                     shrinkWrap: true,
        //                     itemCount: 5,
        //                     itemBuilder: (BuildContext context, int index){
        //                       return Column(
        //                         children: [
        //                           Row(
        //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                             children: [
        //                               Flexible(
        //                                 flex: 1,
        //                                 child: Container(
        //                                     width: MediaQuery.of(context).size.width,
        //                                     child: Text('쪽파', style: TextStyle(fontSize: 12.0),)
        //                                 ),
        //                               ),
        //                               Flexible(
        //                                 flex: 1,
        //                                 child: Container(
        //                                     width: MediaQuery.of(context).size.width,
        //                                     child: Text('두줌', style: TextStyle(fontSize: 12.0),)
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                           Divider(
        //                             thickness: 1,
        //                             color: Colors.black,
        //                           ),
        //                         ],
        //                       );
        //                     },
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               margin: EdgeInsets.all(16.0),
        //               child: Column(
        //                 children: <Widget>[
        //                   Container(
        //                     margin: EdgeInsets.only(bottom: 5.0),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                       children: [
        //                         Flexible(
        //                           flex: 1,
        //                           child: Container(
        //                               width: MediaQuery.of(context).size.width,
        //                               child: Text('조리순서', style: TextStyle(fontSize: 12.0),)
        //                           ),
        //                         ),
        //                         Flexible(
        //                           flex: 1,
        //                           child: Container(
        //                               width: MediaQuery.of(context).size.width,
        //                               child: Text('')
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   ListView.builder(
        //                     shrinkWrap: true,
        //                     itemCount: 5,
        //                     itemBuilder: (BuildContext context, int index){
        //                       return Container(
        //                         margin: EdgeInsets.only(bottom: 5.0),
        //                         child: Row(
        //                           children: [
        //                             Flexible(
        //                               flex: 3,
        //                               child: Image.asset('images/grain/corn.png',),
        //                             ),
        //                             Container(
        //                               margin: EdgeInsets.only(left: 5.0, right: 5.0),
        //                               child: Flexible(
        //                                 flex: 1,
        //                                 child: Text('1'),
        //                               ),
        //                             ),
        //                             Flexible(
        //                               flex: 5,
        //                               child: Text('대파는 길게 4등분 한 후 프라이팬 지름에 맞춰 3~4등분하여 준비한다.', style: TextStyle(fontSize: 11.0),),
        //                             ),
        //                           ],
        //                         ),
        //                       );
        //                     },
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}