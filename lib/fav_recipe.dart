import 'Recipe.dart';
import 'recipes_repository.dart';

class FavoriteRepository{
  static List<Recipe> favList = RecipesRepository.loadRecipes();

  static List<Recipe> loadFavList(){
    return favList;
  }

  static void addFavRecipe(Recipe recipe){

    favList.add(recipe);
  }

  static void deleteFavRecipe(Recipe recipe){
    favList.remove(recipe);
  }
}
