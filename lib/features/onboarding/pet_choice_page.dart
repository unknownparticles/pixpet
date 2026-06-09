import 'package:flutter/material.dart';

import '../../domain/starter_pet.dart';
import '../../widgets/pixel_pet.dart';

/// 首次进入的三选一宠物选择页。
class PetChoicePage extends StatelessWidget {
  const PetChoicePage({
    super.key,
    required this.onPetSelected,
  });

  final ValueChanged<StarterPet> onPetSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFFFFF3D8),
          ),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            children: <Widget>[
              Text(
                '选择你的第一只专注宠物',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: const Color(0xFF3B2F2A),
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '三只像素小伙伴会用不同方式陪你学习。先选一个最顺眼的，之后还能在商店解锁更多形象。',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF6B5B4D),
                    ),
              ),
              const SizedBox(height: 20),
              ...StarterPets.all.map(
                (pet) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _PetChoiceCard(
                    pet: pet,
                    onSelected: () => onPetSelected(pet),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PetChoiceCard extends StatelessWidget {
  const _PetChoiceCard({
    required this.pet,
    required this.onSelected,
  });

  final StarterPet pet;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFD89C), width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1F7A4D1B),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7E8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: PixelPet(
                  petId: pet.id,
                  mood: 'happy',
                  size: 118,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        pet.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(pet.tag),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    pet.trait,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(pet.scene),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: onSelected,
                    icon: const Icon(Icons.favorite_rounded),
                    label: Text('选择${pet.name}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
