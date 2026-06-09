import 'package:flutter/material.dart';

import '../domain/starter_pet.dart';
import '../features/home/focus_pet_home_page.dart';
import '../features/onboarding/pet_choice_page.dart';

/// Focus Pet demo 的根组件。
class FocusPetApp extends StatefulWidget {
  const FocusPetApp({super.key});

  @override
  State<FocusPetApp> createState() => _FocusPetAppState();
}

class _FocusPetAppState extends State<FocusPetApp> {
  StarterPet? _selectedPet;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Pet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF9F7A),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF3D8),
        chipTheme: const ChipThemeData(
          selectedColor: Color(0xFFFFD8A8),
          backgroundColor: Color(0xFFFFF7E8),
        ),
        useMaterial3: true,
      ),
      home: _selectedPet == null
          ? PetChoicePage(
              onPetSelected: (pet) => setState(() => _selectedPet = pet),
            )
          : FocusPetHomePage(initialPet: _selectedPet!),
    );
  }
}
