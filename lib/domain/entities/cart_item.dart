import 'product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;
  final String size;
  final double sizePrice;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.size,
    required this.sizePrice,
  });

  double get totalPrice => sizePrice * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? size,
    double? sizePrice,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      sizePrice: sizePrice ?? this.sizePrice,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CartItem(id: $id, product: $product, quantity: $quantity, size: $size, totalPrice: $totalPrice)';
  }
}
