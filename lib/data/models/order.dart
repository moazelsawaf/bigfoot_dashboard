import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/order_status.dart';
import 'order_item.dart';

class Order {
  String? id;
  final Timestamp date;
  final OrderStatus status;
  final String name;
  final String address;
  final String phone;
  final List<OrderItem> items;

  Order({
    this.id,
    required this.date,
    required this.status,
    required this.name,
    required this.address,
    required this.phone,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      date: json['date'],
      status: OrderStatus.values.byName(json['status']),
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toDate().toIso8601String(),
      'status': status.index,
      'name': name,
      'address': address,
      'phone': phone,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  double get totalPrice => items.fold(
        0,
        (total, orderItem) => total + orderItem.price,
      );

  int get numberOfItems => items.fold(
        0,
        (total, orderItem) => total + 1,
      );
}
