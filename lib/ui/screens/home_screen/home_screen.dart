import 'package:bigfoot_dashboard/ui/screens/home_screen/tabs/edit_items_tab.dart';
import 'package:flutter/material.dart';

import 'tabs/orders_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            title = 'Orders';
            break;
          case 1:
            title = 'Chat';
            break;
          case 2:
            title = 'Items';
            break;
          default:
        }
      });
    });
  }

  String title = 'Orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.receipt)),
            Tab(icon: Icon(Icons.chat)),
            Tab(icon: Icon(Icons.edit_note))
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OrdersTab(),
          Center(child: Text('Chat')),
          EditItemTab(),
        ],
      ),
    );
  }
}
