import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../core/services/mock_data.dart';

class HomeController extends ChangeNotifier {
  List<MealModel> meals = [];
  bool isLoading = false;

  Future<void> search(String query) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    meals = MockData.meals
        .where((meal) =>
            meal.strMeal.toLowerCase().contains(query.toLowerCase()))
        .toList();

    isLoading = false;
    notifyListeners();
  }

  void loadInitial() {
    meals = MockData.meals;
    notifyListeners();
  }
}