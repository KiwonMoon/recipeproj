import 'package:flutter/material.dart';


class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  static const mainColor = Color(0x80E33B1E);
  // static const mainfont = "Himelody";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor, size: 30.0,),
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
              ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.bookmark_border_outlined, color: Colors.black, size: 30.0,),
                  onPressed: (){},
                ),
              ),
              ListTile(
                title: Container(
                  child: Center(
                    child: Text('해물 파전', style: TextStyle(fontSize: 30),),
                  ),
                ),
                subtitle: Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 50),
                  child: Center(
                    child: Text('“파전의 재발견 - 달짝지근한 파와 고소한 불고기로 즐거운 식탁을 만들어 보세요”'),
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
                          Text('2인분', style: TextStyle(fontSize: 11.0,),),
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
                          Text('30분 이내', style: TextStyle(fontSize: 11.0,),),
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
                          Text('초급', style: TextStyle(fontSize: 11.0,),),
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
                  color: mainColor,
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
                      itemCount: 5,
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
                                      child: Text('쪽파', style: TextStyle(fontSize: 12.0),)
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text('두줌', style: TextStyle(fontSize: 12.0),)
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
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          margin: EdgeInsets.only(bottom: 5.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: Image.asset('images/grain/corn.png',),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                                child: Flexible(
                                  flex: 1,
                                  child: Text('1'),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Text('대파는 길게 4등분 한 후 프라이팬 지름에 맞춰 3~4등분하여 준비한다.', style: TextStyle(fontSize: 11.0),),
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