class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final String brand;
  final List<String> images;

  ProductModel({
    required this.images,
    required this.image,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.brand,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      price: (json['price'] ?? 0).toDouble(),
      image: json['thumbnail'] ?? '',
      category: json['category'] ?? 'Uncategorized',
      brand: json['brand'] ?? 'Unknown brand',
      images:
          (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? 'No title',
      description: map['description'] ?? 'No description',
      price: (map['price'] ?? 0).toDouble(),
      image: map['thumbnail'] ?? '',
      category: map['category'] ?? 'Uncategorized',
      brand: map['brand'] ?? 'Unknown brand',
      images: (map['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'thumbnail': image,
      'category': category,
      'brand': brand,
      'images': images,
    };
  }
}
