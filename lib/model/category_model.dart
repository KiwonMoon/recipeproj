class CategoryModel {
  const CategoryModel({
    required this.name,
    required this.id,
    required this.img,
  });

  final String name;
  final int id;
  final String img;

  @override
  String toString() => "$name (id=$id)";
}