import 'package:bigfoot_dashboard/data/demo_data.dart';
import 'package:flutter/material.dart';

import '../../../widgets/order_card.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: DemoData.orders.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        final order = DemoData.orders[index];
        return OrderCard(
          id: order.id,
          date: order.date,
          status: order.status,
          numberOfItems: order.numberOfItems,
          totalPrice: order.totalPrice,
        );
      },
    );
  }
}
