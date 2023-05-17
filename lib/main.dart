import 'package:bigfoot_dashboard/ui/screens/home_screen/home_screen.dart';
import 'package:bigfoot_dashboard/ui/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        OrderDetailsScreen.routeName: (_) => const OrderDetailsScreen(),
      },
    );
  }
}
