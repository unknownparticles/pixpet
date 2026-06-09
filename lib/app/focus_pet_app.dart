import 'package:flutter/material.dart';

import '../features/home/focus_pet_home_page.dart';

/// Focus Pet demo 的根组件。
class FocusPetApp extends StatelessWidget {
  const FocusPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Pet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D6F),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F3EA),
        useMaterial3: true,
      ),
      home: const FocusPetHomePage(),
    );
  }
}

