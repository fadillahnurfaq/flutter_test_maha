import 'package:flutter/material.dart';
import 'package:flutter_test_maha/utils/app_color.dart';
import 'package:flutter_test_maha/views/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test Maha',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundcolor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundcolor,
        ),
      ),
      home: const HomeView(),
    );
  }
}
