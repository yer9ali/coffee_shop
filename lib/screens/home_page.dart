import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/category_filters.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  int _selectedCategoryIndex = 0;
  int _selectedBottomNavIndex = 0;

  late AnimationController _pageController;
  late Animation<double> _pageAnimation;

  final List<String> categories = ['All', 'Latte', 'Cappuccino', 'Mocha', 'Espresso', 'Americano'];

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Steamy Bean',
      'rating': 4.5,
      'price': 5.00,
      'image': 'assets/coffee_cup_1.png',
      'backgroundColor': const Color(0xFFF8E8E8),
      'isFavorite': false,
    },
    {
      'name': 'Creamy Latte',
      'rating': 4.8,
      'price': 6.50,
      'image': 'assets/coffee_cup_1.png',
      'backgroundColor': const Color(0xFFF0E8FF),
      'isFavorite': true,
    },
    {
      'name': 'Dark Roast',
      'rating': 4.3,
      'price': 4.50,
      'image': 'assets/coffee_cup_1.png',
      'backgroundColor': const Color(0xFFE8F4FF),
      'isFavorite': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _pageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pageController, curve: Curves.easeOut)
    );
    
    // Запускаем анимацию страницы
    _pageController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _pageAnimation,
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              const CustomAppBar(),
              
              // Search Bar
              const CustomSearchBar(),
              
              // Category Filters
              CategoryFilters(
                categories: categories,
                selectedIndex: _selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
              ),
              
              // Products Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index < products.length - 1 ? 20 : 0,
                              ),
                              child: ProductCard(
                                product: products[index],
                                index: index,
                                onFavoriteToggle: () {
                                  setState(() {
                                    products[index]['isFavorite'] = 
                                        !products[index]['isFavorite'];
                                  });
                                },
                                onAddToCart: () {
                                  // Handle add to cart
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${products[index]['name']} added to cart'),
                                      duration: const Duration(seconds: 1),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedBottomNavIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
    );
  }
}

