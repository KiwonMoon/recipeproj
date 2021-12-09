import 'category_model.dart';

class CategoryRepository {
  static List<CategoryModel> loadCategories() {
    const allCategories = <CategoryModel>[
      CategoryModel(
          name: '밥',
          id: 0,
          img: 'images/category/rice2.png'),
      CategoryModel(
          name: '분식',
          id: 1,
          img: 'images/category/tteokbokki.png'),
      CategoryModel(
          name: '국/탕/찌개',
          id: 2,
          img: 'images/category/soup2.png'),
      CategoryModel(
          name: '일식',
          id: 3,
          img: 'images/category/japanese.png'),
      CategoryModel(
          name: '양식',
          id: 4,
          img: 'images/category/spaguetti.png'),
      CategoryModel(
          name: '중식',
          id: 5,
          img: 'images/category/chinese.png'),
      CategoryModel(
          name: '면',
          id: 6,
          img: 'images/category/noodles.png'),
      CategoryModel(
          name: '반찬',
          id: 7,
          img: 'images/category/fried-egg.png'),
      CategoryModel(
          name: '야식',
          id: 8,
          img: 'images/category/chicken2.png'),
      CategoryModel(
          name: '간식',
          id: 9,
          img: 'images/category/snacks.png'),
    ];

    return allCategories;
  }
}