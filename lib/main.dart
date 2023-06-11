import 'package:bigfoot_dashboard/firebase_options.dart';
import 'package:bigfoot_dashboard/ui/screens/chat_screen.dart';
import 'package:bigfoot_dashboard/ui/screens/home_screen/home_screen.dart';
import 'package:bigfoot_dashboard/ui/screens/order_details_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
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
      themeMode: ThemeMode.light,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? '/sign-in'
          : HomeScreen.routeName,
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            showAuthActionSwitch: false,
            providers: [EmailAuthProvider()],
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) async {
                if (state.user == null) return;
                if (state.user!.uid != 'BW58WOGn1kPa5DkhEQzuyjgUQvT2') {
                  // sign out
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You are not authorized to use this app.'),
                    ),
                  );

                  await FirebaseAuth.instance.signOut();
                }
                if (context.mounted) {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                }
              }),
            ],
          );
        },
        HomeScreen.routeName: (_) => const HomeScreen(),
        OrderDetailsScreen.routeName: (_) => const OrderDetailsScreen(),
        ChatScreen.routeName: (_) => const ChatScreen(),
      },
    );
  }
}
