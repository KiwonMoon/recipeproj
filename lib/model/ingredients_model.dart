enum Category { all, grain, meat, processed }

class IngredientModel {
  const IngredientModel({
    required this.category,
    required this.name,
    required this.img,
  });

  final Category category;
  final String name;
  final String img;

  @override
  String toString() => "$name";
}
