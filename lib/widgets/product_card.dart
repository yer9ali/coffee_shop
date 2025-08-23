import 'package:flutter/material.dart';
import '../screens/product_detail_page.dart';

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;
  final int index;

  const ProductCard({
    super.key,
    required this.product,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.index,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _favoriteController;
  late AnimationController _cartController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _favoriteAnimation;
  late Animation<double> _cartAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut)
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut)
    );
    
    _favoriteController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _favoriteAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _favoriteController, curve: Curves.elasticOut)
    );
    
    _cartController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _cartAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _cartController, curve: Curves.easeInOut)
    );
    
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _fadeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _favoriteController.dispose();
    _cartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: widget.product),
                  ),
                );
              },
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: widget.product['backgroundColor'],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _favoriteAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _favoriteAnimation.value,
                                child: GestureDetector(
                                  onTap: () {
                                    _favoriteController.forward().then((_) {
                                      _favoriteController.reverse();
                                    });
                                    widget.onFavoriteToggle();
                                  },
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    transitionBuilder: (Widget child, Animation<double> animation) {
                                      return ScaleTransition(scale: animation, child: child);
                                    },
                                    child: Container(
                                      key: ValueKey(widget.product['isFavorite']),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        widget.product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                                        color: widget.product['isFavorite'] ? Colors.red : const Color(0xFF1A1A1A),
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFF1A1A1A),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.product['rating'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF1A1A1A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Expanded(
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: Transform.rotate(
                              angle: 0.3,
                              child: Container(
                                width: 300,
                                height: 900,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(widget.product['image']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${widget.product['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _cartAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _cartAnimation.value,
                                child: GestureDetector(
                                  onTap: () {
                                    _cartController.forward().then((_) {
                                      _cartController.reverse();
                                    });
                                    widget.onAddToCart();
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1A1A1A),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
