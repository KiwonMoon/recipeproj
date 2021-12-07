import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'model/login.dart';
import 'model/recipe_model.dart';
import 'recipelistpage.dart';



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
  bool editPhoto = false;
  bool selectededitPhoto = false;
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
      editPhoto = true;
      _image = image!;
    });
  }

  Future getcookingImageFromGallery() async {
    PickedFile? image = await _getPicker.getImage(source: ImageSource.gallery);
    setState(() {
      selectededitPhoto = true;
      _selectedimage = image!;
    });
  }

  Future<void> _uploadFile(String fileName, bool flag) async {
    File file = File(fileName);
    try {
      if(flag){
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

        // 문서 작성
        await FirebaseFirestore.instance.collection('recipe').doc(widget.recipemodel.recipetitle).delete();
        await FirebaseFirestore.instance.collection('recipe').doc(newrecipetitle).set({
          'recipecategory': newrecipecategory,
          "recipetitle": newrecipetitle,
          "recipeinfo": newrecipeinfo,
          'imagepath': downloadUrl,
          'peoplecount': newpeoplecount,
          'cookingtime': newcookingtime,
          'difficulty': newdifficulty,
          'ingredientlist': FieldValue.arrayUnion(newingredientlist),
          'quantitylist': FieldValue.arrayUnion(newquantitylist),
          'cookinfolist': FieldValue.arrayUnion(newcookinfolist),
          'cookimglist': FieldValue.arrayUnion(newcookimglist),
        });
      }else{
        // 문서 작성
        await FirebaseFirestore.instance.collection('recipe').doc(widget.recipemodel.recipetitle).delete();
        await FirebaseFirestore.instance.collection('recipe').doc(newrecipetitle).set({
          'recipecategory': newrecipecategory,
          "recipetitle": newrecipetitle,
          "recipeinfo": newrecipeinfo,
          'imagepath': fileName,
          'peoplecount': newpeoplecount,
          'cookingtime': newcookingtime,
          'difficulty': newdifficulty,
          'ingredientlist': FieldValue.arrayUnion(newingredientlist),
          'quantitylist': FieldValue.arrayUnion(newquantitylist),
          'cookinfolist': FieldValue.arrayUnion(newcookinfolist),
          'cookimglist': FieldValue.arrayUnion(newcookimglist),
        });
      }
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
  final _timeList = ['15분 이내','30분 이내','1시간 이내', '1시간 이상'];
  final _difficultyList = ['하','중','상'];
  final _categoryList = ['밥','분식','찌개','일식','양식','중식','면','반찬','야식','간식'];

  String newrecipecategory = "밥";
  String newrecipetitle = "";
  String newrecipeinfo = "";
  String newimagepath = "";
  String newpeoplecount = "1인분";
  String newcookingtime = "15분 이내";
  String newdifficulty = "하";
  List newingredientlist = [];
  List newquantitylist = [];
  List newcookinfolist = [];
  List newcookimglist = [];

  List nameList = [];

  @override
  Widget build(BuildContext context) {

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

              FirebaseFirestore.instance
                  .collection('selectedIngredients')
                  .doc('${currentUserID!.uid}')
                  .get()
                  .then((DocumentSnapshot document) {
                nameList.addAll(document['name']);
              });

              newingredientlist = widget.recipemodel.ingredientlist;
              newquantitylist = widget.recipemodel.quantitylist;
              newcookinfolist = widget.recipemodel.cookinfolist;
              newcookimglist = widget.recipemodel.cookimglist;

              editPhoto == false ? _uploadFile(widget.recipemodel.imagepath, editPhoto) : _uploadFile(_image!.path, editPhoto);
              print('edit finish');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RecipeListPage(nameList: nameList)));
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
                      title: TextFormField(
                        initialValue: widget.recipemodel.recipetitle,
                        onChanged: (String value){
                          setState(() {
                            newrecipetitle = value;
                          });
                        },
                      ),
                      trailing: DropdownButton(
                        value: newrecipecategory,
                        items: _categoryList.map<DropdownMenuItem<String>>(
                                (String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 10.0,),),
                              );
                            }).toList(),
                        onChanged: (value) => setState(() => newrecipecategory = value as String),
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
                    child: TextFormField(
                      initialValue: widget.recipemodel.recipeinfo,
                      onChanged: (String value){
                        setState(() {
                          newrecipeinfo = value;
                        });
                      },
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
                          editPhoto == false ? Image.network(widget.recipemodel.imagepath, fit: BoxFit.contain,) : Image.file(File(_image!.path)),
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
                            value: newpeoplecount,
                            items: _peopleList.map<DropdownMenuItem<String>>(
                                    (String value){
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 10.0,),),
                                  );
                                }).toList(),
                            onChanged: (value) => setState(() => newpeoplecount = value as String),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('시간', style: TextStyle(fontSize: 10.0,),),
                          DropdownButton(
                            value: newcookingtime,
                            items: _timeList.map<DropdownMenuItem<String>>(
                                    (String value){
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 10.0,),),
                                  );
                                }).toList(),
                            onChanged: (value) => setState(() => newcookingtime = value as String),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text('난이도', style: TextStyle(fontSize: 10.0,),),
                          DropdownButton(
                            value: newdifficulty,
                            items: _difficultyList.map<DropdownMenuItem<String>>(
                                    (String value){
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(fontSize: 10.0,),),
                                  );
                                }).toList(),
                            onChanged: (value) => setState(() => newdifficulty = value as String),
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
                                        flex: 4,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            widget.recipemodel.ingredientlist[index],
                                            style: TextStyle(fontSize: 10.0,),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 4,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            widget.recipemodel.quantitylist[index],
                                            style: TextStyle(fontSize: 10.0,),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: (){
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
                                                              child: TextFormField(
                                                                initialValue: widget.recipemodel.ingredientlist[index],
                                                                onChanged: (String value){
                                                                  setState(() {
                                                                    widget.recipemodel.ingredientlist[index] = value;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              child: TextFormField(
                                                                initialValue: widget.recipemodel.quantitylist[index],
                                                                onChanged: (String value){
                                                                  setState(() {
                                                                    widget.recipemodel.quantitylist[index] = value;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: <Widget>[
                                                        FlatButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        },
                                                            child: Text("Add"))
                                                      ]
                                                  );
                                                });
                                          },
                                          icon: Icon(Icons.edit, size: 20.0, color: Colors.red,),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: IconButton(
                                          onPressed: (){
                                            setState(() {
                                              widget.recipemodel.ingredientlist.removeAt(index);
                                              widget.recipemodel.quantitylist.removeAt(index);
                                            });
                                          },
                                          icon: Icon(Icons.delete, size: 20.0, color: Colors.red,),
                                        ),
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
                                                child: TextFormField(
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
                                              widget.recipemodel.ingredientlist.add(ingredientinput);
                                              widget.recipemodel.quantitylist.add(quantityinput);
                                              print(widget.recipemodel.ingredientlist);
                                              print(widget.recipemodel.quantitylist);
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
                                      flex: 7,
                                      child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(widget.recipemodel.cookinfolist[index], style: TextStyle(fontSize: 12.0),)
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: widget.recipemodel.cookimglist[index] == ""
                                          ? Text('No image')
                                          : Image.network(widget.recipemodel.cookimglist[index], fit: BoxFit.cover,),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: IconButton(
                                        onPressed: (){
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Text("Add Todolist"),
                                                    content: SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          selectededitPhoto == false ? Image.network(widget.recipemodel.cookimglist[index], fit: BoxFit.contain,)
                                                              : Image.file(File(_selectedimage!.path), fit: BoxFit.contain,),
                                                          Row(
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
                                                                  child: TextFormField(
                                                                    initialValue: widget.recipemodel.cookinfolist[index],
                                                                    onChanged: (String value){
                                                                      setState(() {
                                                                        cookinfoinput = value;
                                                                      });
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
                                                          widget.recipemodel.cookinfolist[index] = cookinfoinput;
                                                          widget.recipemodel.cookimglist[index] = pathpath;
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
                                        icon: Icon(Icons.edit),
                                      ),
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
                                                        child: Center(child: Text((widget.recipemodel.cookinfolist.length + 1).toString(), style: TextStyle(fontSize: 12.0),))
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
                                              widget.recipemodel.cookinfolist.add(cookinfoinput);
                                              widget.recipemodel.cookimglist.add(pathpath);
                                              print(widget.recipemodel.cookinfolist);
                                              print(widget.recipemodel.cookimglist);
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