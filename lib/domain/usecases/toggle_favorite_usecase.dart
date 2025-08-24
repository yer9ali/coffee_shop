import '../repositories/product_repository.dart';

class ToggleFavoriteUseCase {
  final ProductRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<void> execute(String productId) async {
    await repository.toggleFavorite(productId);
  }
}
