class SpecialityModel {
  final int id;
  final String enCategoryName;
  final String arCategoryName;
  final String image;

  SpecialityModel({
    required this.id,
    required this.enCategoryName,
    required this.arCategoryName,
    required this.image,
  });

  factory SpecialityModel.fromJson(jsonData) {

    return SpecialityModel(
      id: jsonData['id'],
      enCategoryName: jsonData['enCategoryName'],
      arCategoryName: jsonData['arCategoryName'],
      image: jsonData['image'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enCategoryName': enCategoryName,
      'arCategoryName': arCategoryName,
      'image': image,

    };
  }
}
