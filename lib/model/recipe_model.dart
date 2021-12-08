class RecipeModel {
  RecipeModel({
    required this.recipecategory,
    required this.recipetitle,
    required this.recipeinfo,
    required this.imagepath,
    required this.peoplecount,
    required this.cookingtime,
    required this.difficulty,
    required this.ingredientlist,
    required this.quantitylist,
    required this.cookinfolist,
    required this.cookimglist,
  });

  String recipecategory;
  String recipetitle;
  String recipeinfo;
  String imagepath;
  String peoplecount;
  String cookingtime;
  String difficulty;
  List<dynamic> ingredientlist;
  List<dynamic> quantitylist;
  List<dynamic> cookinfolist;
  List<dynamic> cookimglist;

  RecipeModel.fromJson(Map<String, dynamic> json)
      : recipecategory = json['recipecategory'],
        recipetitle = json['recipetitle'],
        recipeinfo = json['recipeinfo'],
        imagepath = json['imagepath'],
        peoplecount = json["peoplecount"],
        cookingtime = json["cookingtime"],
        difficulty = json['difficulty'],
        ingredientlist = json["ingredientlist"],
        quantitylist = json["quantitylist"],
        cookinfolist = json['cookinfolist'],
        cookimglist = json['cookimglist'];
}

