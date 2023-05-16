import 'package:flutter/material.dart';

class KeyValueItem extends StatelessWidget {
  final String label;
  final String value;

  const KeyValueItem({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          value,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
