import 'package:flutter/material.dart';
import 'Recipe.dart';
import 'fav_recipe.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  List<Recipe> favList = FavoriteRepository.loadFavList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("북마크 리스트"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final item = favList[index];
            return Dismissible(
              key: Key(item.name),
              onDismissed: (direction) {
                setState(() {
                  favList.removeAt(index);
                });
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('$item deleted')));
              },
              background: Container(
                color: Colors.red,
              ),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 10),
                visualDensity: VisualDensity(vertical: 4,horizontal: -3),
                leading: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    width: 140,
                  ),
                ),
                title: Text(
                  item.name,
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  item.description,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          },
          // separatorBuilder: (context, index) {
          //   return Divider(
          //     height: 0,
          //   );
          // },
          itemCount: favList.length,
        ),
      ),
      // body: ListView.builder(
      //     itemCount: favList.length,
      //     itemBuilder: (context, index) {
      //       final item = favList[index];
      //       return Dismissible(
      //         key: Key(item.name),
      //         onDismissed: (direction){
      //           setState(() {
      //             favList.removeAt(index);
      //           });
      //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item deleted')));
      //         },
      //         background: Container(color: Colors.red,),
      //         child:  ListTile(
      //           contentPadding: EdgeInsets.all(16),
      //           title: Text(item.name,
      //             style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //       );
      //     }
      // ),
    );
  }
}
