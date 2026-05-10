import 'package:chefapp/core/constants/enums.dart';
import 'package:chefapp/models/category_model.dart';
import 'package:chefapp/models/meal_model.dart';
import 'package:chefapp/models/meal_summary_model.dart';


abstract class MealRepository {
  Future<List<CategoryModel>> getCategories();
  Future<MealModel> getMealById(String id);
  Future<List<MealSummaryModel>> search(SearchType type, String value);
}