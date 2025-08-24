import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.rating,
    required super.price,
    required super.image,
    required super.backgroundColor,
    super.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      backgroundColor: json['backgroundColor'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'price': price,
      'image': image,
      'backgroundColor': backgroundColor,
      'isFavorite': isFavorite,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      rating: product.rating,
      price: product.price,
      image: product.image,
      backgroundColor: product.backgroundColor,
      isFavorite: product.isFavorite,
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      rating: rating,
      price: price,
      image: image,
      backgroundColor: backgroundColor,
      isFavorite: isFavorite,
    );
  }
}
