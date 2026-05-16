import 'package:flutter/material.dart';
import 'package:chefapp/core/database/database_service.dart';
import 'package:chefapp/models/meal_summary_model.dart';

class FavoritesStore {
  final DatabaseService databaseService;

  FavoritesStore({required this.databaseService});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String> error = ValueNotifier('');
  final ValueNotifier<List<MealSummaryModel>> favorites = ValueNotifier([]);
  final ValueNotifier<bool> isFavorite = ValueNotifier(false);

  // busca todos os favoritos
  Future<void> getFavorites() async {
    isLoading.value = true;

    try {
      favorites.value = await databaseService.getFavorites();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // verifica se uma receita é favorita
  Future<void> checkIsFavorite(String id) async {
    try {
      isFavorite.value = await databaseService.isFavorite(id);
    } catch (e) {
      error.value = e.toString();
    }
  }

  // adiciona ou remove dos favoritos
  Future<void> toggleFavorite(MealSummaryModel meal) async {
    try {
      if (isFavorite.value) {
        await databaseService.removeFavorite(meal.id);
        isFavorite.value = false;
        favorites.value = favorites.value
            .where((item) => item.id != meal.id)
            .toList();
      } else {
        await databaseService.saveFavorite(meal);
        isFavorite.value = true;
        favorites.value = [...favorites.value, meal];
      }
    } catch (e) {
      error.value = e.toString();
    }
  }
}