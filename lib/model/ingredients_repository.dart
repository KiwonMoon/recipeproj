import 'ingredients_model.dart';

class IngredientsRepository {
  static List<IngredientModel> loadIngredients(Category category) {
    const allIngredients = <IngredientModel>[
      IngredientModel(
          category: Category.grain,
          name: '쌀',
          img: 'images/grain/rice_bowl.png'),
      IngredientModel(
          category: Category.grain,
          name: '밀가루',
          img: 'images/grain/flour.png'),
      IngredientModel(
          category: Category.grain,
          name: '고구마',
          img: 'images/grain/sweet_potato.png'),
      IngredientModel(
          category: Category.grain,
          name: '감자',
          img: 'images/grain/potato.png'),
      IngredientModel(
          category: Category.grain,
          name: '옥수수',
          img: 'images/grain/corn.png'),
      IngredientModel(
          category: Category.meat,
          name: '돼지고기',
          img: 'images/meat/chop.png'),
      IngredientModel(
          category: Category.meat,
          name: '소고기',
          img: 'images/meat/chop2.png'),
      IngredientModel(
          category: Category.meat,
          name: '닭고기',
          img: 'images/meat/chicken.png'),
      IngredientModel(
          category: Category.meat,
          name: '오리',
          img: 'images/meat/chicken2.png'),
      IngredientModel(
          category: Category.meat,
          name: '양고기',
          img: 'images/meat/lamb.png'),
      IngredientModel(
          category: Category.meat,
          name: '소시지',
          img: 'images/meat/ham.png'),
      IngredientModel(
          category: Category.meat,
          name: '베이컨',
          img: 'images/meat/bacon.png'),
      IngredientModel(
          category: Category.meat,
          name: '미트볼',
          img: 'images/meat/meatballs.png'),
      IngredientModel(
          category: Category.meat,
          name: '스팸',
          img: 'images/meat/spam.png'),
      IngredientModel(
          category: Category.processed,
          name: '계란',
          img: 'images/processed/eggs.png'),
      IngredientModel(
          category: Category.processed,
          name: '우유',
          img: 'images/processed/milk.png'),
      IngredientModel(
          category: Category.processed,
          name: '요거트',
          img: 'images/processed/yogurt.png'),
      IngredientModel(
          category: Category.processed,
          name: '체다치즈',
          img: 'images/processed/cheese.png'),
      IngredientModel(
          category: Category.processed,
          name: '모짜렐라 치즈',
          img: 'images/processed/cheese2.png'),
      IngredientModel(
          category: Category.processed,
          name: '참치캔',
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
