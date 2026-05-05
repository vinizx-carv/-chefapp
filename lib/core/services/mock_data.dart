import '../../models/meal_model.dart';

class MockData {
  static List<MealModel> meals = [
    MealModel(
      idMeal: "1",
      strMeal: "Spaghetti Bolognese",
      strMealThumb: "",
      strCategory: "Massas",
    ),
    MealModel(
      idMeal: "2",
      strMeal: "Chicken Curry",
      strMealThumb: "",
      strCategory: "Frango",
    ),
    MealModel(
      idMeal: "3",
      strMeal: "Burger",
      strMealThumb: "",
      strCategory: "Fast Food",
    ),
  ];
}