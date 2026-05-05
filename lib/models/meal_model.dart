class MealModel {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strCategory;

  MealModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strCategory,
  });
}