import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RecipeAddPage extends StatefulWidget {
  const RecipeAddPage({Key? key}) : super(key: key);

  static const mainColor = Color(0x80E33B1E);
  static const backColor = Color(0xffdddddd);
  static const fontColor = Color(0xff969696);

  @override
  State<RecipeAddPage> createState() => _RecipeAddPageState();
}

class _RecipeAddPageState extends State<RecipeAddPage> {

  PickedFile? _image;
  final ImagePicker _getPicker = ImagePicker();

  Future getImageFromGallery() async {
    PickedFile? image = await _getPicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }

  final _peopleList = ['1명','2명','3명'];
  var _peopleDefault = '1명';
  final _timeList = ['1시간 이내','1~2시간','2시간 이상'];
  var _timeDefault = '1시간 이내';
  final _difficultyList = ['하','중','상'];
  var _difficultyDefault = '하';

  var _introduceCount = 3;
  var _orderCount = 3;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: RecipeAddPage.mainColor, size: 30.0,),
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
              margin: EdgeInsets.only(bottom: 20.0,),
              child: Column(
                children: [
                  Text('레시피 제목', style: TextStyle(color: RecipeAddPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeAddPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '해물파전',
                        hintStyle: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0,),
              child: Column(
                children: [
                  Text('요리소개', style: TextStyle(color: RecipeAddPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeAddPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: '파전의 재발견 - 달짝지근한 파와 고소한 불고기로 즐거운 식탁을 만들어 보세요',
                          hintStyle: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0,),
              child: Column(
                children: [
                  Text('대표 사진 등록', style: TextStyle(color: RecipeAddPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeAddPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    child: Center(
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () async => await getImageFromGallery(),
                            icon: Icon(Icons.add_a_photo),
                          ),
                          Text('요리 대표 사진을 등록해 주세요', style: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,),),
                          Center(
                            child: _image == null
                                ? Text('No image selected!')
                                : Image.file(File(_image!.path)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0,),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 10.0,),
                      child: Text('요리 정보', style: TextStyle(color: RecipeAddPage.mainColor, fontWeight: FontWeight.bold),)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('인원', style: TextStyle(fontSize: 10.0,),),
                          DropdownButton(
                            value: _peopleDefault,
                            items: _peopleList.map<DropdownMenuItem<String>>(
                                (String value){
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 10.0,),),
                                  );
                                }).toList(),
                            onChanged: (value) => setState(() => _peopleDefault = value as String),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('시간', style: TextStyle(fontSize: 10.0,),),
                          DropdownButton(
                            value: _timeDefault,
                            items: _timeList.map<DropdownMenuItem<String>>(
                                    (String value){
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 10.0,),),
                                  );
                                }).toList(),
                            onChanged: (value) => setState(() => _timeDefault = value as String),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('난이도', style: TextStyle(fontSize: 10.0,),),
                          DropdownButton(
                            value: _difficultyDefault,
                            items: _difficultyList.map<DropdownMenuItem<String>>(
                                    (String value){
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 10.0,),),
                                  );
                                }).toList(),
                            onChanged: (value) => setState(() => _difficultyDefault = value as String),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0,),
              child: Column(
                children: [
                  Text('요리 소개', style: TextStyle(color: RecipeAddPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeAddPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _introduceCount,
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
                                          child: Text('예) 간장', style: TextStyle(fontSize: 12.0),)
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text('에) 1.5T', style: TextStyle(fontSize: 12.0),)
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
                        Center(
                          child: RaisedButton(
                            child: Text('재료 추가'),
                            onPressed: (){
                              _introduceCount = _introduceCount + 1;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0,),
              child: Column(
                children: [
                  Text('요리 순서', style: TextStyle(color: RecipeAddPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeAddPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _orderCount,
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
                                          child: Center(child: Text('1', style: TextStyle(fontSize: 12.0),))
                                      ),
                                    ),
                                    Flexible(
                                      flex: 5,
                                      child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text('예) 대파는 길게 4등분 한 후 프라이팬 지름에 맞춰 3~4등분하여 준비한다.', style: TextStyle(fontSize: 12.0),)
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: IconButton(
                                        onPressed: () async => await getImageFromGallery(),
                                        icon: Icon(Icons.image_outlined),
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
                        Center(
                          child: RaisedButton(
                            child: Text('요리 순서 추가'),
                            onPressed: (){
                              _orderCount = _orderCount + 1;
                            },
                          ),
                        ),
                      ],
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