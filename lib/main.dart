import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:swift_feed_app/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fwjnyqbacjxsnqyfillv.supabase.co',
    anonKey: 'sb_publishable_eU6eWBk83S9eOuVRWDpA3A_7iD-9UGr',
  );
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      home: HomeScreen(),
    );
  }
}
