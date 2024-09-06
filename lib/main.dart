import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_advanced/app_colors.dart';
import 'package:todo_advanced/presentation/todos/all_todos_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.primaryColor,
      )),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.primaryColor,
      )),
      home: const Scaffold(body: AllTodosScreen()),
    );
  }
}
