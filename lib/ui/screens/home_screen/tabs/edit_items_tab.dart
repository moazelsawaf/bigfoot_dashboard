import 'package:bigfoot_dashboard/data/demo_data.dart';
import 'package:bigfoot_dashboard/data/models/item.dart';
import 'package:bigfoot_dashboard/ui/widgets/item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

class EditItemTab extends StatefulWidget {
  const EditItemTab({super.key});

  @override
  State<EditItemTab> createState() => _EditItemTabState();
}

class _EditItemTabState extends State<EditItemTab> {
  final query = FirebaseFirestore.instance
      .collection('items')
      .orderBy('name')
      .withConverter<ItemModel>(
        fromFirestore: (snapshot, _) => ItemModel.fromMap(snapshot.data()!),
        toFirestore: (item, _) => item.toMap(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nameController = TextEditingController();
          final priceController = TextEditingController();
          final sizeList = <String>['S', 'M', 'L', 'XL', 'XXL'];
          final selectedSizes = <String>[];

          late ItemModel newItem;

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Add Item"),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    newItem = ItemModel(
                      id: DemoData.items.length + 1,
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      sizes: selectedSizes.toList(),
                      image: "https://picsum.photos/200",
                    );

                    await FirebaseFirestore.instance
                        .collection('items')
                        .doc(newItem.id.toString())
                        .set(newItem.toMap());
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: const Text("Save"),
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: priceController,
                          decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Sizes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: sizeList
                                  .map(
                                    (e) => ChoiceChip(
                                      selected: selectedSizes.contains(e),
                                      label: Text(e),
                                      onSelected: (selected) {
                                        if (selected) {
                                          selectedSizes.add(e);
                                        } else {
                                          selectedSizes.remove(e);
                                        }
                                        // sort to be 'S', 'M', 'L', 'XL', 'XXL'

                                        selectedSizes.sort((a, b) {
                                          List<String> order = [
                                            'S',
                                            'M',
                                            'L',
                                            'XL',
                                            'XXL'
                                          ];
                                          int indexA = order.indexOf(a);
                                          int indexB = order.indexOf(b);
                                          return indexA.compareTo(indexB);
                                        });

                                        setState(() {});
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FirestoreListView<ItemModel>(
        padding: const EdgeInsets.symmetric(vertical: 16),
        query: query,
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        itemBuilder: (_, snapshot) {
          final item = snapshot.data();
          return ItemCard(
            id: item.id,
            image: item.image,
            name: item.name,
            price: item.price,
            sizes: item.sizes,
            onTap: () async {
              final nameController = TextEditingController();
              final priceController = TextEditingController();
              nameController.text = item.name;
              priceController.text = item.price.toString();
              final sizes = item.sizes;
              final sizeList = <String>['S', 'M', 'L', 'XL', 'XXL'];
              final selectedSizes = <String>[];
              selectedSizes.addAll(sizes);

              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Edit ${item.name}"),
                  actions: [
                    TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        final newItem = item.copyWith(
                          name: nameController.text,
                          price: double.parse(priceController.text),
                          sizes: selectedSizes.toList(),
                        );
                        await FirebaseFirestore.instance
                            .collection('items')
                            .doc(item.id.toString())
                            .set(newItem.toMap());
                        if (context.mounted) Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: const Text("Save"),
                    ),
                  ],
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Price",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: priceController,
                              decoration: const InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Sizes",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: sizeList
                                      .map(
                                        (e) => ChoiceChip(
                                          selected: selectedSizes.contains(e),
                                          label: Text(e),
                                          onSelected: (selected) {
                                            if (selected) {
                                              selectedSizes.add(e);
                                            } else {
                                              selectedSizes.remove(e);
                                            }
                                            // sort to be 'S', 'M', 'L', 'XL', 'XXL'

                                            selectedSizes.sort((a, b) {
                                              List<String> order = [
                                                'S',
                                                'M',
                                                'L',
                                                'XL',
                                                'XXL'
                                              ];
                                              int indexA = order.indexOf(a);
                                              int indexB = order.indexOf(b);
                                              return indexA.compareTo(indexB);
                                            });

                                            setState(() {});
                                          },
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
