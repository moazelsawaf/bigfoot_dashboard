import 'package:bigfoot_dashboard/data/demo_data.dart';
import 'package:bigfoot_dashboard/ui/widgets/key_value_item.dart';
import 'package:bigfoot_dashboard/utils/extensions/datetime_extension.dart';
import 'package:bigfoot_dashboard/utils/extensions/double_extension.dart';
import 'package:bigfoot_dashboard/utils/extensions/string_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  static const routeName = '/order-details';

  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)!.settings.arguments as int;
    final order = DemoData.orders.firstWhere((order) => order.id == orderId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order # ${order.id}'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          KeyValueItem(
                            label: 'Order ID',
                            value: '#${order.id}',
                          ),
                          const SizedBox(height: 8),
                          KeyValueItem(
                            label: 'Date',
                            value: order.date.formattedDate,
                          ),
                          const SizedBox(height: 8),
                          KeyValueItem(
                            label: 'Status',
                            value: order.status.name.capitalized,
                          ),
                          const SizedBox(height: 8),
                          KeyValueItem(
                            label: 'Number of Items',
                            value: order.numberOfItems.toString(),
                          ),
                          const SizedBox(height: 8),
                          KeyValueItem(
                            label: 'Total Price',
                            value: order.totalPrice.formattedPrice,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Customer Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          KeyValueItem(
                            label: 'Name',
                            value: order.name,
                          ),
                          const SizedBox(height: 8),
                          KeyValueItem(
                            label: 'Phone',
                            value: order.phone,
                          ),
                          const SizedBox(height: 8),
                          KeyValueItem(
                            label: 'Address',
                            value: order.address,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Order Items',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // separatorBuilder: (context, index) => const SizedBox(height: 12),

                  final item = order.items[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: item.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                KeyValueItem(
                                  label: 'Item ID',
                                  value: '#${item.id}',
                                ),
                                const SizedBox(height: 8),
                                KeyValueItem(
                                  label: 'Name',
                                  value: item.name,
                                ),
                                const SizedBox(height: 8),
                                KeyValueItem(
                                  label: 'Size',
                                  value: item.size,
                                ),
                                const SizedBox(height: 8),
                                KeyValueItem(
                                  label: 'Price',
                                  value: item.price.formattedPrice,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: order.items.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
