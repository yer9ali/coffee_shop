import 'package:flutter/material.dart';

class CategoryFilters extends StatefulWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategoryFilters({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  State<CategoryFilters> createState() => _CategoryFiltersState();
}

class _CategoryFiltersState extends State<CategoryFilters>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
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
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            final isSelected = index == widget.selectedIndex;
            return Padding(
              padding: EdgeInsets.only(
                right: index < widget.categories.length - 1 ? 12 : 0,
              ),
              child: _buildCategoryItem(index, isSelected),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(int index, bool isSelected) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: isSelected ? 1.0 : 0.0),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () => widget.onCategorySelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(25),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: const Color(0xFF1A1A1A).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ] : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  child: Text(widget.categories[index]),
                ),
                // Анимированное подчеркивание
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(top: 4),
                  height: 2,
                  width: value * 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

