class ProductModel {
  final int id;
  final String name;
  final double price;
  final String category;
  final String description;
  final int? quantity;
  final String image;
  final List<String> ingredients;
  final bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.quantity,
    required this.image,
    required this.ingredients,
    this.isFavorite = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      category: json['category'],
      description: json['description'],
      quantity: json['quantity'] ?? 0,
      image: json['image'],
      ingredients: List<String>.from(json['ingredients']),
      isFavorite:
          json['is_favorite'] ?? false, // Add this if your API provides it
    );
  }

  ProductModel copyWith({
    int? id,
    String? name,
    double? price,
    String? category,
    String? description,
    int? quantity,
    String? image,
    List<String>? ingredients,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
      ingredients: ingredients ?? this.ingredients,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class ProductsResponse {
  final List<ProductModel> products;
  final Pagination pagination;

  ProductsResponse({required this.products, required this.pagination});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      products:
          (json['products'] as List)
              .map((product) => ProductModel.fromJson(product))
              .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Pagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}
