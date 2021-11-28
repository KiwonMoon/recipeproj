import 'package:flutter/material.dart';

class RecipeAddPage extends StatelessWidget {
  const RecipeAddPage({Key? key}) : super(key: key);

  static const mainColor = Color(0x80E33B1E);
  static const backColor = Color(0xffdddddd);
  static const fontColor = Color(0xff969696);
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
      body: SafeArea(
        minimum: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Text('레시피 제목', style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '해물파전',
                        hintStyle: TextStyle(color: fontColor, fontSize: 10.0,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text('요리소개', style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: '파전의 재발견 - 달짝지근한 파와 고소한 불고기로 즐거운 식탁을 만들어 보세요',
                          hintStyle: TextStyle(color: fontColor, fontSize: 10.0,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text('대표 사진 등록', style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: '요리 대표 사진을 등록해 주세요',
                          hintStyle: TextStyle(color: fontColor, fontSize: 10.0,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text('요리 정보', style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Text('인원'),
                  //         DropdownButton<String>(
                  //           value: '선택',
                  //           items: <String>[ '1명', '2명'],
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Text('시간'),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Text('난이도'),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text('요리 소개', style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: '요리 대표 사진을 등록해 주세요',
                          hintStyle: TextStyle(color: fontColor, fontSize: 10.0,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text('요리 순서', style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: '요리 대표 사진을 등록해 주세요',
                          hintStyle: TextStyle(color: fontColor, fontSize: 10.0,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}