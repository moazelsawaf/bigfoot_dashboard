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
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        title = _tabController.index == 0 ? 'Orders' : 'Chat';
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
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OrdersTab(),
          Center(child: Text('Chat')),
        ],
      ),
    );
  }
}
