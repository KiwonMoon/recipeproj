import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class Search extends StatefulWidget {
  List<String> recipeList;
  Search({required this.recipeList});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> emptyList = [""];
  List<String> items = [];
  String recipeName = '';
  String searchText = '';
  bool _IsClick = false;
  // List<String> searchNameList = [];
  // FocusNode myFocusNode;
  final TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _IsClick = false;
    // myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // myFocusNode.dispose();
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double widthSize = screenSize.width;
    double heightSize = screenSize.height;

    return Scaffold(
      appBar: AppBar(title: Text('Search'),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: <Widget>[
                Container(
                  width: widthSize*0.95,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[50],
                      // border: Border.all(
                      //     width: 1.8, color: Colors.deepOrangeAccent),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 15,),
                      Container(
                        width: 265,
                        height: 45,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          // focusNode: myFocusNode,
                          controller: myController,
                          decoration: InputDecoration(
                              hintText: '레시피 이름',
                              // hintStyle: TextStyle(fontSize: 12),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white))),
                          onChanged: (text) {
                            recipeName = text;
                          },
                        ),
                      ),
                      Container(
                        width: 42,
                        height: 40,
                        child: IconButton(
                          // color: Colors.deepOrange,
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.deepOrange,
                          ),
                          iconSize: 30,
                          onPressed: () {
                            // getData();
                            setState(() {
                              recipeName = recipeName;
                              // _buildList();
                              _IsClick = true;
                            });
                            // print(searchNameList);
                          },
                        ),
                      ),
                      Container(
                        width: 42,
                        height: 40,
                        child: IconButton(
                          icon: Icon(
                            Icons.replay_rounded,
                            color: Colors.deepOrange,
                          ),
                          iconSize: 30,
                          onPressed: () {
                            setState(() {
                              myController.clear();
                              _IsClick = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if(_IsClick == true)
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 360,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                            children: _IsClick ? _searchList():_buildList(),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Future<void>searchData(String name) async{
  //   List<DocumentSnapshot> templist;
  //   List<Map<dynamic, dynamic>> list = [];
  //   Future<QuerySnapshot> lists;
  //   lists = FirebaseFirestore.instance
  //       .collection('recipe')
  //       .where('$name', isGreaterThanOrEqualTo: '$name')
  //       .get();
  //
  //   templist = lists;
  // }

  List<itemName> _buildList() {
    return emptyList.map((contact) => new itemName(contact)).toList();
  }

  List<RecipeTile> _searchList() {
    widget.recipeList.map((contact) => RecipeTile(contact)).toList();
    // items.map((contact) => RecipeTile(contact)).toList();
    List<String> _searchList = [];
    for(int i =0; i<widget.recipeList.length; i++) {
      String name = widget.recipeList.elementAt(i);
      if(name.toLowerCase().contains(recipeName.toLowerCase())){
        _searchList.add(name);
      }
    }
    // return searchNameList.map((contact) => RecipeTile(contact)).toList();
    return _searchList.map((contact) => RecipeTile(contact)).toList();
  }
}


class itemName extends StatelessWidget {
  final String name;
  itemName(this.name);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(20, 0, 8, 0),
      title: Text(this.name),
    );
  }
}

class RecipeTile extends StatelessWidget {
  final String name;
  RecipeTile(this.name);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(28, 0, 8, 0),
      title: Text(this.name),
      onTap: (){
        print('tap : ${this.name}');
      },
    );
  }
}