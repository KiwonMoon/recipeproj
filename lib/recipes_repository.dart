import 'Recipe.dart';

class RecipesRepository {
  static List<Recipe> loadRecipes() {
    const allRecipes = <Recipe>[
      Recipe(
          "해물파전",
          "https://source.unsplash.com/random/800x600?food",
          "description1"),
      Recipe(
          "홈메이드 피자",
          "https://source.unsplash.com/random/800x600?food",
          "description2"),
      Recipe(
          "10분만에 끓이는 순두부찌개",
          "https://source.unsplash.com/random/800x600?food",
          "description3"),
      Recipe(
          "아이가 좋아하는 찹스테이크",
          "https://source.unsplash.com/random/800x600?food",
          "description4"),
    ];
    return allRecipes;
  }
}