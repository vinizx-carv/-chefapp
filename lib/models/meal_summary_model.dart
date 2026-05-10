class MealSummaryModel {
  final String id;
  final String name;
  final String image;

  MealSummaryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory MealSummaryModel.fromMap(Map<String, dynamic> map){

    return MealSummaryModel(
      id: map['idMeal'], 
      name: map['strMeal'], 
      image: map['strMealThumb']
    );
  }
}