import 'package:chefapp/core/repositories/meal_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/models/meal_summary_model.dart';

class SearchStore {
  final MealRepository repository;

  SearchStore({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<List<MealSummaryModel>> meals = ValueNotifier([]);

  Future<void> search(SearchType type, String value) async {
    isLoading.value = true;

    try {
      meals.value = await repository.search(type, value);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}