class CategoryModel {
  final String name;

  CategoryModel({required this.name});

  // Optional: Factory from string if you want to be clear
  factory CategoryModel.fromString(String name) {
    return CategoryModel(name: name);
  }
}
