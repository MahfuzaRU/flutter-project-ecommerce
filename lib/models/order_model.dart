import 'package:ecommerceapp/models/product_model.dart';

class OrderModel {
  final String id;
  final String phone;
  final String name;
  final String address;
  final String paymentMethod;
  final String userId;
  final String status;
  final Map<ProductModel, int> products;
  final double total;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.phone,
    required this.name,
    required this.address,
    required this.paymentMethod,
    required this.userId,
    required this.status,
    required this.products,
    required this.total,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'name': name,
      'address': address,
      'paymentMethod': paymentMethod,
      'userId': userId,
      'status': status,
      'products': products.entries.map(
          (entry) => {'product': entry.key.toJson(), 'quantity': entry.value}),
      'total': total,
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      phone: map['phone'],
      name: map['name'],
      address: map['address'],
      paymentMethod: map['paymentMethod'],
      userId: map['userId'],
      status: map['status'],
      products: {
        for (var e in map['products'])
          ProductModel.fromJson(e['product']): e['quantity']
      },
      total: map['total'],
      createdAt: map['createdAt'].toDate(),
    );
  }

  OrderModel copyWith({
    String? id,
    String? phone,
    String? name,
    String? address,
    String? paymentMethod,
    String? userId,
    String? status,
    Map<ProductModel, int>? products,
    double? total,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      address: address ?? this.address,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      products: products ?? this.products,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
