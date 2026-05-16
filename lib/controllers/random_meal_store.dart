import 'package:flutter/material.dart';
import 'package:chefapp/models/meal_model.dart';
import 'package:chefapp/core/repositories/meal_repository.dart';

class RandomMealStore {
  final MealRepository repository;

  RandomMealStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<List<MealModel>> meals = ValueNotifier([]);

  Future<void> getRandomMeals(int count) async {
    isLoading.value = true;

    try {
      meals.value = await repository.getRandomMeals(count);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}