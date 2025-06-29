// features/favorites/data/models/favorite_model.dart
class FavoriteResponse {
  final bool status;
  final String message;
  final List<FavoriteItem> data;

  FavoriteResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => FavoriteItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class FavoriteItem {
  final int id;
  final String name;
  final double price;
  final String image;

  FavoriteItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      image: json['image'] ?? '',
    );
  }
}
