class MealModel {
  final String id;
  final String name;
  final String? nameAlt;
  final String category;
  final String instructions;
  final String image;
  final String? tag;
  final String? urlVideo;
  final List<String> ingredients;
  final List<String> measures;
  final String? source;

  MealModel({
    required this.id,
    required this.name,
    this.nameAlt,
    required this.category,
    required this.instructions,
    required this.image,
    this.tag,
    this.urlVideo,
    required this.ingredients,
    required this.measures,
    this.source,
  });

  factory MealModel.fromMap(Map<String, dynamic> map) {

    // filtra os nulos/vazios
    final ingredients = List.generate(20, (i) => map['strIngredient${i + 1}'])
        .where((i) => i != null && i.toString().trim().isNotEmpty)
        .map((i) => i.toString())
        .toList();

    final measures = List.generate(20, (i) => map['strMeasure${i + 1}'])
        .where((m) => m != null && m.toString().trim().isNotEmpty)
        .map((m) => m.toString())
        .toList();

    return MealModel(
      id:           map['idMeal'],
      name:         map['strMeal'],
      nameAlt:      map['strMealAlternate'],
      category:     map['strCategory'],
      instructions: map['strInstructions'],
      image:        map['strMealThumb'],
      tag:          map['strTags'],
      urlVideo:     map['strYoutube'],
      ingredients:  ingredients,
      measures:     measures,
      source:       map['strSource'],
    );
  }
}