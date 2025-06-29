abstract class EndPoints {
  static const String baseUrl =
      'https://fruithub.digital-vision-solutions.com/api';
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';
  static const String recommendedCombo = '$baseUrl/categories/4/products/';
  static const String cart = '$baseUrl/cart';
  static const String productDetails = '$baseUrl/products/';
  static const String favorites = '$baseUrl/favourites';
  static String categoryProducts(int categoryId) =>
      '$baseUrl/categories/$categoryId/products/';
  static String searchProducts(String query) =>
      '$baseUrl/products?search=$query';
  static const String payment = '$baseUrl/payment';
}
