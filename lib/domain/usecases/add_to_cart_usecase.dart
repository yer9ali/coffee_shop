import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> execute(CartItem item) async {
    await repository.addToCart(item);
  }
}
