import 'package:bigfoot_dashboard/ui/widgets/key_value_item.dart';
import 'package:bigfoot_dashboard/utils/extensions/double_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final int id;
  final String name;
  final double price;
  final String image;
  final List<String> sizes;
  final VoidCallback? onTap;

  const ItemCard({
    super.key,
    required this.id,
    this.onTap,
    required this.price,
    required this.sizes,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageUrl: image,
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
                      value: '#$id',
                    ),
                    const SizedBox(height: 8),
                    KeyValueItem(
                      label: 'Name',
                      value: name,
                    ),
                    const SizedBox(height: 8),
                    KeyValueItem(
                      label: 'Sizes',
                      value: sizes.toString(),
                    ),
                    const SizedBox(height: 8),
                    KeyValueItem(
                      label: 'Price',
                      value: price.formattedPrice,
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
