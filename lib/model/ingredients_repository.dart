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
      IngredientModel(
          category: Category.vegetable,
          name: '브로콜리',
          img: 'images/vegetable/broccoli.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '배추',
          img: 'images/vegetable/cabbage.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '당근',
          img: 'images/vegetable/carrot.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '고추',
          img: 'images/vegetable/chili.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '오이',
          img: 'images/vegetable/cucumber.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '마늘',
          img: 'images/vegetable/garlic.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '대파',
          img: 'images/vegetable/green-onion.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '김치',
          img: 'images/vegetable/kimchi.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '버섯',
          img: 'images/vegetable/mushrooms.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '양파',
          img: 'images/vegetable/onion.png'),
      IngredientModel(
          category: Category.vegetable,
          name: '파프리카',
          img: 'images/vegetable/paprika.png'),
      IngredientModel(
          category: Category.seafood,
          name: '고등어',
          img: 'images/seafood/fish.png'),
      IngredientModel(
          category: Category.seafood,
          name: '문어',
          img: 'images/seafood/octopus.png'),
      IngredientModel(
          category: Category.seafood,
          name: '미역',
          img: 'images/seafood/seaweed.png'),
      IngredientModel(
          category: Category.seafood,
          name: '조개',
          img: 'images/seafood/shell.png'),
      IngredientModel(
          category: Category.seafood,
          name: '새우',
          img: 'images/seafood/shrimp.png'),
      IngredientModel(
          category: Category.seafood,
          name: '오징어',
          img: 'images/seafood/squid.png'),
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
