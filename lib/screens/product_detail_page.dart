import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  int _selectedSizeIndex = 2; // L по умолчанию
  int _quantity = 1;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<double> prices = [12.00, 13.50, 15.00, 16.50];

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  double get totalPrice => prices[_selectedSizeIndex] * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(),

            // Main Content
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Product Name
                        Text(
                          widget.product['name'],
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Size Selection and Product Image
                        Row(
                          children: [
                            // Size Selection
                            Column(
                              children:
                                  sizes.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final size = entry.value;
                                    final isSelected =
                                        index == _selectedSizeIndex;

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedSizeIndex = index;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color:
                                                isSelected
                                                    ? const Color(0xFF1A1A1A)
                                                    : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFF1A1A1A),
                                              width: 2,
                                            ),
                                            boxShadow:
                                                isSelected
                                                    ? [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        blurRadius: 8,
                                                        offset: const Offset(
                                                          0,
                                                          4,
                                                        ),
                                                      ),
                                                    ]
                                                    : null,
                                          ),
                                          child: Center(
                                            child: Text(
                                              size,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    isSelected
                                                        ? Colors.white
                                                        : const Color(
                                                          0xFF1A1A1A,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),

                            const SizedBox(width: 30),

                            // Product Image
                            Expanded(
                              child: Center(
                                child: Container(
                                  width: 250,
                                  height: 350,
                                  decoration: BoxDecoration(
                                    color: widget.product['backgroundColor'],
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // Product Image
                                      Center(
                                        child: Transform.rotate(
                                          angle: 0.0,
                                          child: Container(
                                            width: 200,
                                            height: 400,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  widget.product['image'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Info Card
                                      Positioned(
                                        bottom: 20,
                                        left: 20,
                                        right: 20,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
                                                blurRadius: 5,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Steamed Milk',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    // fontWeight: FontWeight.w600,
                                                    color: Color(0xFF1A1A1A),
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              Text(
                                                '${_getSizeVolume()}ml',
                                                style: const TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Quantity Selection
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildQuantityButton(
                              icon: Icons.remove,
                              onTap: () {
                                if (_quantity > 1) {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              },
                            ),

                            Container(
                              width: 80,
                              height: 50,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  _quantity.toString().padLeft(2, '0'),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                              ),
                            ),

                            _buildQuantityButton(
                              icon: Icons.add,
                              onTap: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Total Price
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              '\$${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Action Bar
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF1A1A1A),
                size: 20,
              ),
            ),
          ),

          const Expanded(
            child: Center(
              child: Text(
                'Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
          ),

          const SizedBox(width: 40), // Для баланса
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        children: [
          // Cart Button
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 20),

          // Add to Cart Button
          Expanded(
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: GestureDetector(
                    onTap: () {
                      _scaleController.forward().then((_) {
                        _scaleController.reverse();
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${widget.product['name']} added to cart',
                          ),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add To Cart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '>>>',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getSizeVolume() {
    switch (sizes[_selectedSizeIndex]) {
      case 'S':
        return '355';
      case 'M':
        return '414';
      case 'L':
        return '473';
      case 'XL':
        return '532';
      default:
        return '473';
    }
  }
}
