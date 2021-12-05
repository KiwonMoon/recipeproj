import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'model/recipe_model.dart';



class RecipeEditPage extends StatefulWidget {
  final RecipeModel recipemodel;
  const RecipeEditPage({required this.recipemodel});

  static const mainColor = Color(0x80E33B1E);
  static const backColor = Color(0xffdddddd);
  static const fontColor = Color(0xff969696);

  @override
  State<RecipeEditPage> createState() => _RecipeEditPageState();
}

class _RecipeEditPageState extends State<RecipeEditPage> {

  FirebaseAuth auth = FirebaseAuth.instance;

  PickedFile? _image;
  PickedFile? _selectedimage;
  final ImagePicker _getPicker = ImagePicker();

  String recipecategory = "";
  String recipetitle = "";
  String recipeinfo = "";

  List ingredientList = [];
  List quantityList = [];
  List cookinfoList = [];
  List cookimgList = [];
  String ingredientinput = "";
  String quantityinput = "";
  String cookinfoinput = "";

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
      await FirebaseFirestore.instance.collection('recipe').doc(titleController.text).update({
        'recipecategory': _categoryDefault,
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

    } catch (e) {
      print(e);
      return "";
    }
  }


  final _peopleList = ['1인분','2인분','3인분 이상'];
  var _peopleDefault = '1인분';
  final _timeList = ['15분 이내','30분 이내','1시간 이내', '1시간 이상'];
  var _timeDefault = '15분 이내';
  final _difficultyList = ['하','중','상'];
  var _difficultyDefault = '하';
  final _categoryList = ['밥','분식','찌개','일식','양식','중식','면','반찬','야식','간식'];
  var _categoryDefault = '밥';

  String setrecipecategory = "";
  String setrecipetitle = "";
  String setrecipeinfo = "";
  String setimagepath = "";
  String setpeoplecount = "";
  String setcookingtime = "";
  String setdifficulty = "";
  List setingredientlist = [];
  List setquantitylist = [];
  List setcookinfolist = [];
  List setcookimglist = [];


  @override
  Widget build(BuildContext context) {

    // void updateDoc(String docID, String title, String info) {
    //   FirebaseFirestore.instance.collection('recipe').doc(docID).update({
    //     recipetitle: title,
    //     recipeinfo: info,
    //   });
    // }
    _categoryDefault = widget.recipemodel.recipecategory;

    FirebaseFirestore.instance
        .collection('recipe')
        .doc(widget.recipemodel.recipetitle)
        .get()
        .then((DocumentSnapshot document) {
      setrecipecategory = widget.recipemodel.recipecategory;
      setrecipetitle = widget.recipemodel.recipetitle;
      setrecipeinfo = widget.recipemodel.recipeinfo;
      setimagepath = widget.recipemodel.imagepath;
      setpeoplecount = widget.recipemodel.peoplecount;
      setcookingtime = widget.recipemodel.cookingtime;
      setdifficulty = widget.recipemodel.difficulty;
      setingredientlist.addAll(document['ingredientlist']);
      setquantitylist.addAll(document['quantitylist']);
      setcookinfolist.addAll(document['cookinfolist']);
      setcookimglist.addAll(document['cookimglist']);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: RecipeEditPage.mainColor, size: 30.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('모앱개 레시피', style: TextStyle(color: Colors.black,),),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: RecipeEditPage.mainColor,),
            onPressed: (){
              print(setrecipetitle);
              print(setrecipeinfo);
              print(setimagepath);
              print(setpeoplecount);
              print(setcookingtime);
              print(setdifficulty);
              print(setingredientlist);
              print(setquantitylist);
              print(setcookinfolist);
              print(setcookimglist);
              // _uploadFile(_image!.path);
              // Navigator.pop(context);
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
                  Text('레시피 제목', style: TextStyle(color: RecipeEditPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeEditPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      title: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: widget.recipemodel.recipetitle,
                          hintStyle: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,),
                        ),
                      ),
                      trailing: DropdownButton(
                        value: _categoryDefault,
                        items: _categoryList.map<DropdownMenuItem<String>>(
                                (String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 10.0,),),
                              );
                            }).toList(),
                        onChanged: (value) => setState(() => _categoryDefault = value as String),
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
                  Text('요리소개', style: TextStyle(color: RecipeEditPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeEditPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: introductionController,
                      decoration: InputDecoration(
                          hintText: widget.recipemodel.recipeinfo,
                          hintStyle: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,)
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
                  Text('대표 사진 등록', style: TextStyle(color: RecipeEditPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0, bottom: 50.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeEditPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Column(
                        children: [
                          widget.recipemodel.imagepath == "" ? IconButton(
                            onPressed: () async => await getImageFromGallery(),
                            icon: Icon(Icons.add_a_photo),
                          ) : Image.network(widget.recipemodel.imagepath, fit: BoxFit.contain,),
                          Text('요리 대표 사진을 등록해 주세요', style: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,),),
                          Center(
                            child: widget.recipemodel.imagepath == ""
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
                      child: Text('요리 정보', style: TextStyle(color: RecipeEditPage.mainColor, fontWeight: FontWeight.bold),)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('인원', style: TextStyle(fontSize: 10.0,),),
                          DropdownButton(
                            value: widget.recipemodel.peoplecount,
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
                            value: widget.recipemodel.cookingtime,
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
                            value: widget.recipemodel.difficulty,
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
                  Text('요리 소개', style: TextStyle(color: RecipeEditPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeEditPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.recipemodel.ingredientlist.length,
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
                                            widget.recipemodel.ingredientlist[index],
                                            style: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            widget.recipemodel.quantitylist[index],
                                            style: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: (){
                                          setState(() {
                                            widget.recipemodel.ingredientlist.removeAt(index);
                                            widget.recipemodel.quantitylist.removeAt(index);
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
                                                      hintStyle: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,)
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
                                                      hintStyle: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,)
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
                  Text('요리 순서', style: TextStyle(color: RecipeEditPage.mainColor, fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0,),
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: RecipeEditPage.backColor,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.recipemodel.cookinfolist.length,
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
                                          child: Text(widget.recipemodel.cookinfolist[index], style: TextStyle(fontSize: 12.0),)
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: widget.recipemodel.cookimglist[index] == ""
                                          ? Text('No image')
                                          : Image.network(widget.recipemodel.cookimglist[index], fit: BoxFit.cover,),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            widget.recipemodel.cookinfolist.removeAt(index);
                                            widget.recipemodel.cookimglist.removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
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
                                              _selectedimage == null ? Text('요리 대표 사진을 등록해 주세요', style: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,),)
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
                                                            hintStyle: TextStyle(color: RecipeEditPage.fontColor, fontSize: 10.0,)
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