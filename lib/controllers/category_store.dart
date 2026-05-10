import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:chefapp/models/category_model.dart';

class CategoryStore {
  final MealRepository repository;

  CategoryStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<List<CategoryModel>> categories = ValueNotifier([]);

  Future<void> getCategories() async {
    isLoading.value = true;

    try {
      categories.value = await repository.getCategories();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}