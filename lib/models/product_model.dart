import 'package:ecommerceapp/core/constants/constants.dart';

class ProductModel {
  String name;
  String description;
  String category;
  String image;
  String id;
  String brand;
  double price;
  int quantity;
  bool offer;
  double offerPercetage;

  ProductModel(
      {required this.name,
      required this.description,
      required this.category,
      required this.image,
      required this.price,
      this.quantity = 10,
      required this.id,
      required this.offer,
      required this.brand,
      this.offerPercetage = 5});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? Constants.defaultImage,
      price: double.parse(json['price'].toString()),
      quantity: json['quantity'] ?? 10,
      id: json['id'] ?? '',
      offer: json['offer'] ?? false,
      brand: json['brand'] ?? '',
      offerPercetage: json['offerPercetage'] ?? 5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'image': image,
      'price': price,
      'quantity': quantity,
      'id': id,
      'offer': offer,
      'brand': brand,
      'offerPercetage': offerPercetage,
    };
  }
}
