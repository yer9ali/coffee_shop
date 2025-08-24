import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

  @override
  Future<List<Product>> getProducts() async {
    final productModels = await localDataSource.getProducts();
    return productModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> toggleFavorite(String productId) async {
    await localDataSource.toggleFavorite(productId);
  }

  @override
  Future<List<Product>> getFavoriteProducts() async {
    final productModels = await localDataSource.getFavoriteProducts();
    return productModels.map((model) => model.toEntity()).toList();
  }
}
