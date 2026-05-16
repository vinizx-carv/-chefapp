import 'package:flutter/material.dart';
import 'package:chefapp/models/meal_model.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';

class RandomMealStore {
  final MealRepository repository;

  RandomMealStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<MealModel?> meal = ValueNotifier(null);

  Future<void> getRandomMeal() async {
    isLoading.value = true;

    try {
      meal.value = await repository.getRandomMeal();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}