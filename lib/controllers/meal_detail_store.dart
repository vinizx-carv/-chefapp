import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:chefapp/models/meal_model.dart';

class MealDetailStore {
  final MealRepository repository;

  MealDetailStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<MealModel?> meal = ValueNotifier(null);

  Future<void> getMealById(String id) async {
    isLoading.value = true;

    try {
      meal.value = await repository.getMealById(id);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}