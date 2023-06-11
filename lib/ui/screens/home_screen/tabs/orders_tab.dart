import 'package:bigfoot_dashboard/data/models/order.dart';
import 'package:bigfoot_dashboard/ui/screens/order_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import '../../../widgets/order_card.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Order>(
      query: FirebaseFirestore.instance
          .collection('orders')
          .orderBy('date', descending: true)
          .withConverter<Order>(
            fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()!),
            toFirestore: (order, _) => order.toJson(),
          ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (_, snapshot) {
        final order = snapshot.data();
        order.id = snapshot.id;
        return OrderCard(
          id: order.id ?? '',
          date: order.date.toDate(),
          status: order.status,
          numberOfItems: order.numberOfItems,
          totalPrice: order.totalPrice,
          onTap: () {
            Navigator.of(context).pushNamed(
              OrderDetailsScreen.routeName,
              arguments: order,
            );
          },
        );
      },
    );
  }
}
