import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> toggleFavorite(String productId);
  Future<List<ProductModel>> getFavoriteProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final List<ProductModel> _products = [
    const ProductModel(
      id: '1',
      name: 'Steamy Bean',
      rating: 4.5,
      price: 5.00,
      image: 'assets/coffee_cup_1.png',
      backgroundColor: '0xFFF8E8E8',
      isFavorite: false,
    ),
    const ProductModel(
      id: '2',
      name: 'Creamy Latte',
      rating: 4.8,
      price: 6.50,
      image: 'assets/coffee_cup_1.png',
      backgroundColor: '0xFFF0E8FF',
      isFavorite: true,
    ),
    const ProductModel(
      id: '3',
      name: 'Dark Roast',
      rating: 4.3,
      price: 4.50,
      image: 'assets/coffee_cup_1.png',
      backgroundColor: '0xFFE8F4FF',
      isFavorite: false,
    ),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    // Имитация задержки сети
    await Future.delayed(const Duration(milliseconds: 500));
    return _products;
  }

  @override
  Future<void> toggleFavorite(String productId) async {
    final index = _products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      final product = _products[index];
      _products[index] = ProductModel(
        id: product.id,
        name: product.name,
        rating: product.rating,
        price: product.price,
        image: product.image,
        backgroundColor: product.backgroundColor,
        isFavorite: !product.isFavorite,
      );
    }
  }

  @override
  Future<List<ProductModel>> getFavoriteProducts() async {
    return _products.where((product) => product.isFavorite).toList();
  }
}
