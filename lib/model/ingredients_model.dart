enum Category { all, grain, meat, processed }

class IngredientModel {
  const IngredientModel({
    required this.category,
    required this.name,
    required this.id,
    required this.img,
  });

  final Category category;
  final String name;
  final int id;
  final String img;

  @override
  String toString() => "$name (id=$id)";
}
