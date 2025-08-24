class Product {
  final String id;
  final String name;
  final double rating;
  final double price;
  final String image;
  final String backgroundColor;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.rating,
    required this.price,
    required this.image,
    required this.backgroundColor,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? name,
    double? rating,
    double? price,
    String? image,
    String? backgroundColor,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      image: image ?? this.image,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, rating: $rating, price: $price, isFavorite: $isFavorite)';
  }
}
