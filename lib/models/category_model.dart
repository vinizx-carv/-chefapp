class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String description;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map){
    return CategoryModel(
    id: map['idCategory'], 
    name: map['strCategory'], 
    image: map['strCategoryThumb'], 
    description: map['strCategoryDescription']
    );
  }
}