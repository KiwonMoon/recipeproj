import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // FocusNode myFocusNode;
  final TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                  width: 380,
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
                          onChanged: (text) {},
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
                          onPressed: () {},
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
                            });
                          },
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
}
