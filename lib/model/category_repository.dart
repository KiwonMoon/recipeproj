import 'category_model.dart';

class CategoryRepository {
  static List<CategoryModel> loadCategories() {
    const allCategories = <CategoryModel>[
      CategoryModel(
          name: '밥',
          id: 0,
          img: 'images/category/rice.png'),
      CategoryModel(
          name: '분식',
          id: 1,
          img: 'images/category/ricecake.png'),
      CategoryModel(
          name: '국/탕/찌개',
          id: 2,
          img: 'images/category/soup.png'),
      CategoryModel(
          name: '일식',
          id: 3,
          img: 'images/category/japanfood.png'),
      CategoryModel(
          name: '양식',
          id: 4,
          img: 'images/category/spaguetti.png'),
      CategoryModel(
          name: '중식',
          id: 5,
          img: 'images/category/chinesefood.png'),
      CategoryModel(
          name: '면',
          id: 6,
          img: 'images/category/ramen.png'),
      CategoryModel(
          name: '반찬',
          id: 7,
          img: 'images/category/sidemenu.png'),
      CategoryModel(
          name: '야식',
          id: 8,
          img: 'images/category/chicken.png'),
      CategoryModel(
          name: '간식',
          id: 9,
          img: 'images/category/snack.png'),
    ];

    return allCategories;
  }
}