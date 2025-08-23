import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

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
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut)
    );
    
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    
    // Запускаем анимации
    _fadeController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 50,
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white : const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(25),
            border: _isFocused ? Border.all(
              color: const Color(0xFF1A1A1A).withOpacity(0.3),
              width: 2,
            ) : null,
            boxShadow: _isFocused ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ] : null,
          ),
          child: Row(
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.search,
                        color: _isFocused ? const Color(0xFF1A1A1A) : const Color(0xFF999999),
                        size: 20,
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: _isFocused ? const Color(0xFF666666) : const Color(0xFF999999),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              if (_isFocused)
                AnimatedOpacity(
                  opacity: _isFocused ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: GestureDetector(
                      onTap: () {
                        _focusNode.unfocus();
                      },
                      child: Icon(
                        Icons.close,
                        color: const Color(0xFF999999),
                        size: 20,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

