import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<void> toggleFavorite(String productId);
  Future<List<Product>> getFavoriteProducts();
}
