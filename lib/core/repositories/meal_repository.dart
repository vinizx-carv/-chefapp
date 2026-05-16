import 'dart:convert';
import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/core/http/http_client.dart';
import 'package:chefapp/models/category_model.dart';
import 'package:chefapp/models/meal_model.dart';
import 'package:chefapp/models/meal_summary_model.dart';

const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

abstract class MealRepository {
  Future<List<CategoryModel>> getCategories();
  Future<MealModel> getMealById(String id);
  Future<List<MealSummaryModel>> search(SearchType type, String value);
  Future<List<MealModel>> getRandomMeals(int count);
}

class MealRepositoryImpl implements MealRepository {
  final HttpClient client;

  MealRepositoryImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await client.get(url: '$_baseUrl/categories.php');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['categories'];
      return list.map((item) => CategoryModel.fromMap(item)).toList();
    } else {
      throw Exception('Erro ao buscar categorias');
    }
  }

  @override
  Future<MealModel> getMealById(String id) async {
    final response = await client.get(url: '$_baseUrl/lookup.php?i=$id');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MealModel.fromMap(data['meals'][0]);
    } else {
      throw Exception('Erro ao buscar detalhes da receita');
    }
  }

  @override
  Future<List<MealSummaryModel>> search(SearchType type, String value) async {
    final String endpoint = switch (type) {
      SearchType.name       => '$_baseUrl/search.php?s=$value',
      SearchType.ingredient => '$_baseUrl/filter.php?i=$value',
      SearchType.category   => '$_baseUrl/filter.php?c=$value',
    };

    final response = await client.get(url: endpoint);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['meals'] ?? [];
      return list.map((item) => MealSummaryModel.fromMap(item)).toList();
    } else {
      throw Exception('Erro ao buscar receitas');
    }
  }

  @override
  Future<List<MealModel>> getRandomMeals(int count) async {
    final meals = await Future.wait(
      List.generate(count, (_) => _fetchRandomMeal()),
    );
    return meals;
  }

  // método privado que busca uma receita aleatória
  Future<MealModel> _fetchRandomMeal() async {
    final response = await client.get(url: '$_baseUrl/random.php');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MealModel.fromMap(data['meals'][0]);
    } else {
      throw Exception('Erro ao buscar receita aleatória');
    }
  }
}