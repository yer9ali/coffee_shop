class AppConstants {
  static const String appName = 'Coffee Shop';
  
  // Colors
  static const int primaryColor = 0xFF1A1A1A;
  static const int secondaryColor = 0xFF8B0000;
  static const int backgroundColor = 0xFFF5F5F5;
  
  // Sizes
  static const double defaultPadding = 20.0;
  static const double defaultRadius = 20.0;
  
  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 600);
  
  // Product sizes
  static const List<String> productSizes = ['S', 'M', 'L', 'XL'];
  static const List<double> sizePrices = [12.00, 13.50, 15.00, 16.50];
  static const List<String> sizeVolumes = ['355', '414', '473', '532'];
}
