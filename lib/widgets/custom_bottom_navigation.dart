import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation>
    with TickerProviderStateMixin {
  late List<AnimationController> _scaleControllers;
  late List<Animation<double>> _scaleAnimations;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Инициализация контроллеров масштабирования для каждого элемента
    _scaleControllers = List.generate(5, (index) => 
      AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
      )
    );
    
    _scaleAnimations = _scaleControllers.map((controller) =>
      Tween<double>(begin: 1.0, end: 0.9).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut)
      )
    ).toList();
    
    // Анимация появления
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut)
    );
    
    _fadeController.forward();
  }

  @override
  void dispose() {
    for (var controller in _scaleControllers) {
      controller.dispose();
    }
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: 85,
        // color: const Color(0xFF1A1A1A),
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(50),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.home_outlined, 'Home'),
                _buildNavItem(1, Icons.favorite_outline, 'Favorite'),
                _buildNavItem(2, Icons.qr_code_scanner, 'Scan'),
                _buildNavItem(3, Icons.shopping_cart_outlined, 'Cart'),
                _buildNavItem(4, Icons.person_outline, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = widget.selectedIndex == index;
    
    return Expanded(
      child: AnimatedBuilder(
        animation: _scaleAnimations[index],
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimations[index].value,
            child: InkWell(
              onTap: () {
                // Анимация нажатия
                _scaleControllers[index].forward().then((_) {
                  _scaleControllers[index].reverse();
                });
                widget.onItemSelected(index);
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        icon,
                        key: ValueKey(isSelected),
                        color: isSelected ? const Color(0xFF8B0000) : Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Flexible(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF8B0000) : Colors.white,
                          fontSize: 9,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // Анимированное подчеркивание
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(top: 4),
                      height: 2,
                      width: isSelected ? 20 : 0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B0000),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}