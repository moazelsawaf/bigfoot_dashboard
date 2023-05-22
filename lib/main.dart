import 'package:bigfoot_dashboard/firebase_options.dart';
import 'package:bigfoot_dashboard/ui/screens/home_screen/home_screen.dart';
import 'package:bigfoot_dashboard/ui/screens/order_details_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'color_scheme.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        OrderDetailsScreen.routeName: (_) => const OrderDetailsScreen(),
      },
    );
  }
}
