import 'package:bigfoot_dashboard/data/models/item.dart';
import 'package:bigfoot_dashboard/ui/widgets/key_value_item.dart';
import 'package:bigfoot_dashboard/utils/extensions/double_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback? onTap;
  final VoidCallback? onHold;
  const ItemCard({
    super.key,
    this.onTap,
    required this.item,
    this.onHold,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onHold,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      value: item.id ?? '',
                    ),
                    const SizedBox(height: 8),
                    KeyValueItem(
                      label: 'Name',
                      value: item.name,
                    ),
                    const SizedBox(height: 8),
                    KeyValueItem(
                      label: 'Description',
                      value: item.description,
                    ),
                    const SizedBox(height: 8),
                    KeyValueItem(
                      label: 'Sizes',
                      value: item.sizes.toString(),
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
      ),
    );
  }
}
