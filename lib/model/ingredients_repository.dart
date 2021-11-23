import 'ingredients_model.dart';

class IngredientsRepository {
  static List<IngredientModel> loadIngredients(Category category) {
    const allIngredients = <IngredientModel>[
      IngredientModel(
          category: Category.grain,
          name: '쌀',
          id: 0,
          img: 'images/grain/rice_bowl.png'),
      IngredientModel(
          category: Category.grain,
          name: '밀가루',
          id: 1,
          img: 'images/grain/flour.png'),
      IngredientModel(
          category: Category.grain,
          name: '고구마',
          id: 2,
          img: 'images/grain/sweet_potato.png'),
      IngredientModel(
          category: Category.grain,
          name: '감자',
          id: 3,
          img: 'images/grain/potato.png'),
      IngredientModel(
          category: Category.grain,
          name: '옥수수',
          id: 4,
          img: 'images/grain/corn.png'),
      IngredientModel(
          category: Category.meat,
          name: '돼지고기',
          id: 5,
          img: 'images/meat/chop.png'),
      IngredientModel(
          category: Category.meat,
          name: '소고기',
          id: 6,
          img: 'images/meat/chop.png'),
      IngredientModel(
          category: Category.meat,
          name: '닭고기',
          id: 7,
          img: 'images/meat/chicken.png'),
      IngredientModel(
          category: Category.meat,
          name: '오리',
          id: 8,
          img: 'images/meat/chicken.png'),
      IngredientModel(
          category: Category.meat,
          name: '양고기',
          id: 9,
          img: 'images/meat/lamb.png'),
      IngredientModel(
          category: Category.processed,
          name: '계란',
          id: 9,
          img: 'images/processed/eggs.png'),
      IngredientModel(
          category: Category.processed,
          name: '우유',
          id: 10,
          img: 'images/processed/milk.png'),
      IngredientModel(
          category: Category.processed,
          name: '체다치즈',
          id: 11,
          img: 'images/processed/cheese.png'),
      IngredientModel(
          category: Category.processed,
          name: '모짜렐라 치즈',
          id: 12,
          img: 'images/processed/cheese.png'),
      IngredientModel(
          category: Category.processed,
          name: '참치캔',
          id: 13,
          img: 'images/processed/canned.png'),
    ];
    if (category == Category.all) {
      return allIngredients;
    } else {
      return allIngredients.where((IngredientModel I) {
        return I.category == category;
      }).toList();
    }
  }
}
