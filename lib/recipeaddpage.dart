import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';



class RecipeAddPage extends StatefulWidget {
  const RecipeAddPage({Key? key}) : super(key: key);

  static const mainColor = Color(0x80E33B1E);
  static const backColor = Color(0xffdddddd);
  static const fontColor = Color(0xff969696);

  @override
  State<RecipeAddPage> createState() => _RecipeAddPageState();
}

class _RecipeAddPageState extends State<RecipeAddPage> {

  FirebaseAuth auth = FirebaseAuth.instance;

  PickedFile? _image;
  PickedFile? _selectedimage;
  final ImagePicker _getPicker = ImagePicker();

  List ingredientList = [];
  List quantityList = [];
  List cookinfoList = [];
  List cookimgList = [];
  String ingredientinput = "";
  String quantityinput = "";
  String cookinfoinput = "";
  int counter = 0;

  final titleController = TextEditingController();
  final introductionController = TextEditingController();
  final ingredientController = TextEditingController();

  Future getImageFromGallery() async {
    PickedFile? image = await _getPicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }

  Future getcookingImageFromGallery() async {
    PickedFile? image = await _getPicker.getImage(source: ImageSource.gallery);
    setState(() {
      _selectedimage = image!;
    });
  }

  Future<void> _uploadFile(String fileName) async {
    File file = File(fileName);
    try {
      // 스토리지에 업로드할 파일 경로
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('recipe')
          .child('${DateTime.now().millisecondsSinceEpoch}.png');

      // 파일 업로드
      final uploadTask = firebaseStorageRef.putFile(
          file, SettableMetadata(contentType: 'image/png'));

      // 완료까지 기다림
      await uploadTask.whenComplete(() => null);

      // 업로드 완료 후 url
      final downloadUrl = await firebaseStorageRef.getDownloadURL();

      print(downloadUrl);
      // 문서 작성
      await FirebaseFirestore.instance.collection('recipe').doc(titleController.text).set({
        'recipetitle': titleController.text,
        'recipeinfo': introductionController.text,
        'imagepath': downloadUrl,
        'peoplecount': _peopleDefault,
        'cookingtime': _timeDefault,
        'difficulty': _difficultyDefault,
        'ingredientlist': FieldValue.arrayUnion(ingredientList),
        'quantitylist': FieldValue.arrayUnion(quantityList),
        'cookinfolist': FieldValue.arrayUnion(cookinfoList),
        'cookimglist': FieldValue.arrayUnion(cookimgList),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> rankUpload(String ingredient) async {
    int like =0;
    await FirebaseFirestore.instance.collection('rank').doc(ingredient).get()
        .then((DocumentSnapshot document) {
      // like = document['counter'];
      counter = document['counter'];
      print('기존 like: $counter');
      setState(() {
        counter++;
        // like++;
      });
    });
    await FirebaseFirestore.instance.collection('rank').doc(ingredient).update({
      'counter': counter,
    });
  }

  Future<String> _cookinfouploadFile(String fileName) async {
    File file = File(fileName);
    try {
      // 스토리지에 업로드할 파일 경로
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('recipe')
          .child('${DateTime.now().millisecondsSinceEpoch}.png');

      // 파일 업로드
      final uploadTask = firebaseStorageRef.putFile(
          file, SettableMetadata(contentType: 'image/png'));

      // 완료까지 기다림
      await uploadTask.whenComplete(() => null);

      // 업로드 완료 후 url
      final downloadUrl = await firebaseStorageRef.getDownloadURL();
      return downloadUrl;
      // cookimgList.add(downloadUrl);
      // print(cookimgList);
    } catch (e) {
      print(e);
      return "";
    }
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

    // FirebaseFirestore.instance
    //     .collection('recipe')
    //     .doc('${currentUserID!.uid}')
    //     .get()
    //     .then((DocumentSnapshot document) {
    //   imgList.addAll(document['img']);
    //   nameList.addAll(document['name']);
    // });

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
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: RecipeAddPage.mainColor,),
            onPressed: (){
              _uploadFile(_image!.path);
              Navigator.pop(context);
            },
          ),
        ],
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
                      controller: titleController,
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
                      controller: introductionController,
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
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0, bottom: 50.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeAddPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        children: [
                          _image == null ? IconButton(
                            onPressed: () async => await getImageFromGallery(),
                            icon: Icon(Icons.add_a_photo),
                          ) : Image.file(File(_image!.path), fit: BoxFit.contain,),
                          Text('요리 대표 사진을 등록해 주세요', style: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,),),
                          Center(
                            child: _image == null
                                ? Text('No image selected!')
                                : IconButton(
                                  onPressed: () async => await getImageFromGallery(),
                                  icon: Icon(Icons.add_a_photo),
                            ),
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
                          itemCount: ingredientList.length,
                          itemBuilder: (BuildContext context, int index){
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            ingredientList[index],
                                            style: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            quantityList[index],
                                            style: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          setState(() {
                                            ingredientList.removeAt(index);
                                            quantityList.removeAt(index);
                                            print(ingredientList);
                                            print(quantityList);
                                          });
                                        },
                                        icon: Icon(Icons.delete, size: 20.0, color: Colors.red,),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Center(
                          child: RaisedButton(
                            child: Text('재료 추가'),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("Add Todolist"),
                                        content: Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText: '간장',
                                                      hintStyle: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,)
                                                  ),
                                                  onChanged: (String value) {
                                                    ingredientinput = value;
                                                  },
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintText: '예) 1.5T',
                                                      hintStyle: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,)
                                                  ),
                                                  onChanged: (String value) {
                                                    quantityinput = value;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          FlatButton(onPressed: (){
                                            setState(() {
                                              ingredientList.add(ingredientinput);
                                              quantityList.add(quantityinput);
                                              print(ingredientList);
                                              print(quantityList);
                                              rankUpload(ingredientinput);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                              child: Text("Add"))
                                        ]
                                    );
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
                          itemCount: cookinfoList.length,
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
                                          child: Center(child: Text((index + 1).toString(), style: TextStyle(fontSize: 12.0),))
                                      ),
                                    ),
                                    Flexible(
                                      flex: 5,
                                      child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(cookinfoList[index], style: TextStyle(fontSize: 12.0),)
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: cookimgList[index] == ""
                                          ? Text('No image')
                                          : Image.network(cookimgList[index], fit: BoxFit.cover,),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        Center(
                          child: RaisedButton(
                            child: Text('요리 추가'),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text("Add Todolist"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              _selectedimage == null ? Text('요리 대표 사진을 등록해 주세요', style: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,),)
                                              : Image.file(File(_selectedimage!.path), fit: BoxFit.contain,),
                                              Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: Center(child: Text((cookinfoList.length + 1).toString(), style: TextStyle(fontSize: 12.0),))
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 5,
                                                    child: Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: TextField(
                                                          decoration: InputDecoration(
                                                              hintText: '예) 대파는 길게 4등분 한 후 프라이팬 지름에 맞춰 3~4등분하여 준비한다.',
                                                              hintStyle: TextStyle(color: RecipeAddPage.fontColor, fontSize: 10.0,)
                                                          ),
                                                          onChanged: (String value) {
                                                            cookinfoinput = value;
                                                          },
                                                        ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: IconButton(
                                                      onPressed: () async => await getcookingImageFromGallery(),
                                                      icon: Icon(Icons.image_outlined),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(onPressed: () async{
                                            Future<String> selectedimagepath = _cookinfouploadFile(_selectedimage!.path);
                                            String pathpath = await selectedimagepath;
                                            setState((){
                                              cookinfoList.add(cookinfoinput);
                                              cookimgList.add(pathpath);
                                              print(cookinfoList);
                                              print(pathpath);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Add"))
                                        ]
                                    );
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
          ],
        ),
      ),
    );
  }


}