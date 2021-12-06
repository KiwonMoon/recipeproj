class RecipeModel {
  const RecipeModel({
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

  final String recipecategory;
  final String recipetitle;
  final String recipeinfo;
  final String imagepath;
  final String peoplecount;
  final String cookingtime;
  final String difficulty;
  final List<dynamic> ingredientlist;
  final List<dynamic> quantitylist;
  final List<dynamic> cookinfolist;
  final List<dynamic> cookimglist;

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

