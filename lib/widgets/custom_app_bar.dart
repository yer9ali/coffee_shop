import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _notificationController;
  
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _notificationAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut)
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    
    _notificationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _notificationAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _notificationController, curve: Curves.elasticOut)
    );
    
    // Запускаем анимации с задержкой
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _notificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // Greeting Text
          Expanded(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello,',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      'Aidyn Kyzaibek',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Notification Icon
          AnimatedBuilder(
            animation: _notificationAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _notificationAnimation.value,
                child: GestureDetector(
                  onTap: () {
                    _notificationController.forward().then((_) {
                      _notificationController.reverse();
                    });
                    // Показать уведомления
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Уведомления'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Color(0xFF1A1A1A),
                      size: 20,
                    ),
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(width: 12),
          
          // Profile Picture
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/logo_.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

