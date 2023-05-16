import '../enums/order_status.dart';
import 'order_item.dart';

class Order {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final String name;
  final String address;
  final String phone;
  final List<OrderItem> items;

  const Order({
    required this.id,
    required this.date,
    required this.status,
    required this.name,
    required this.address,
    required this.phone,
    required this.items,
  });

  double get totalPrice => items.fold(
        0,
        (total, orderItem) => total + orderItem.totalPrice,
      );

  int get numberOfItems => items.fold(
        0,
        (total, orderItem) => total + orderItem.quantity,
      );
}
