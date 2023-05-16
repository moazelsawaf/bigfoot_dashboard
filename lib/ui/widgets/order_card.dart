import 'package:bigfoot_dashboard/utils/extensions/datetime_extension.dart';
import 'package:bigfoot_dashboard/utils/extensions/double_extension.dart';
import 'package:bigfoot_dashboard/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../../data/enums/order_status.dart';

class OrderCard extends StatelessWidget {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final int numberOfItems;
  final double totalPrice;
  final VoidCallback? onTap;

  const OrderCard({
    super.key,
    required this.id,
    required this.date,
    required this.status,
    required this.numberOfItems,
    required this.totalPrice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      isThreeLine: true,
      leading: CircleAvatar(
        radius: 22,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FittedBox(
            child: Text('#$id'),
          ),
        ),
      ),
      title: Text(date.formattedDate),
      subtitle: Column(
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.shopping_cart_outlined),
              const SizedBox(width: 8),
              Text('$numberOfItems items'),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.online_prediction_rounded),
              const SizedBox(width: 8),
              Text(status.name.capitalized),
            ],
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            totalPrice.formattedPrice,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
