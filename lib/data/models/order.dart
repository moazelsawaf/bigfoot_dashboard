import '../enums/order_status.dart';
import 'order_item.dart';

class Order {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final String name;
  final String address;
  final String phone;
  final List<OrderItem> orderItems;

  const Order({
    required this.id,
    required this.date,
    required this.status,
    required this.name,
    required this.address,
    required this.phone,
    required this.orderItems,
  });

  double get totalPrice => orderItems.fold(
        0,
        (total, orderItem) => total + orderItem.totalPrice,
      );

  int get numberOfItems => orderItems.fold(
        0,
        (total, orderItem) => total + orderItem.quantity,
      );
}
