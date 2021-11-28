import 'package:flutter/material.dart';
import 'recipeaddpage.dart';
import 'recipedetailpage.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({Key? key}) : super(key: key);

  static const mainColor = Color(0x80E33B1E);
  static const mainBackgroundColor = Color(0xffE598BB);
  // static const mainfont = "Himelody";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
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
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border_outlined, color: Colors.black, size: 33.0,),
            onPressed: (){},
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index){
            return InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecipeDetailPage()));
              },
              child: Card(
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Card(
                        child: Image.asset('images/grain/corn.png'),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: ListTile(
                        title: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: Center(
                            child: Text('해물 파전', style: TextStyle(fontSize: 20.0),),
                          ),
                        ),
                        isThreeLine: true,
                        subtitle: Text('“파전의 재발견 - 달짝지근한 파와 고소한 불고기로 즐거운 식탁을 만들어 보세요”', ),
                        dense: true,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecipeAddPage()));
        },
      ),
    );
  }
}
