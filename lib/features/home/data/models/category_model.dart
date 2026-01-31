class SpecialityModel {
  SpecialityModel({
    required this.id,
    required this.enCategoryName,
    required this.arCategoryName,
    required this.image,
  });

  factory SpecialityModel.fromJson(jsonData) => SpecialityModel(
        id: jsonData['id'],
        enCategoryName: jsonData['enCategoryName'],
        arCategoryName: jsonData['arCategoryName'],
        image: jsonData['image'],
      );
  final int id;
  final String enCategoryName;
  final String arCategoryName;
  final String image;

  Map<String, dynamic> toMap() => {
        'id': id,
        'enCategoryName': enCategoryName,
        'arCategoryName': arCategoryName,
        'image': image,
      };
}

class CategoryModel {
  CategoryModel({required this.categoryName, required this.image});
  final String categoryName;
  final String image;
}
