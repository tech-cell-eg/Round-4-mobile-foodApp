class ShoppingCartModel {
  ShoppingCartModel({
    required this.items,
  });

  final List<Item> items;

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json){
    return ShoppingCartModel(
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

}

class Item {
  Item({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.product,
  });

  final int? id;
  final int? cartId;
  final int? productId;
  final double? price;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final Product? product;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json["id"],
      cartId: json["cart_id"],
      productId: json["product_id"],
      price: json["price"],
      quantity: json["quantity"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      name: json["name"],
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }

}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.categoryId,
    required this.ingredients,
  });

  final int? id;
  final String? name;
  final double? price;
  final String? description;
  final String? image;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? categoryId;
  final String? ingredients;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      description: json["description"],
      image: json["image"],
      quantity: json["quantity"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      categoryId: json["category_id"],
      ingredients: json["ingredients"],
    );
  }

}
