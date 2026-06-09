/// 宠物在主页上展示的心情。
enum PetMood {
  happy,
  waiting,
  encouraging,
}

/// Demo 阶段的宠物状态。
///
/// 先保持本地内存模型，后续接本地存储时可以直接复用字段含义。
class PetProfile {
  const PetProfile({
    required this.petId,
    required this.name,
    required this.level,
    required this.energy,
    required this.mood,
    this.decoration = '空书桌',
    this.fullness = 40,
    this.foodInventory = const <String, int>{},
    this.ownedPetIds = const <String>['sprout'],
  });

  final String petId;
  final String name;
  final int level;
  final int energy;
  final PetMood mood;
  final String decoration;
  final int fullness;
  final Map<String, int> foodInventory;
  final List<String> ownedPetIds;

  PetProfile copyWith({
    String? petId,
    String? name,
    int? level,
    int? energy,
    PetMood? mood,
    String? decoration,
    int? fullness,
    Map<String, int>? foodInventory,
    List<String>? ownedPetIds,
  }) {
    return PetProfile(
      petId: petId ?? this.petId,
      name: name ?? this.name,
      level: level ?? this.level,
      energy: energy ?? this.energy,
      mood: mood ?? this.mood,
      decoration: decoration ?? this.decoration,
      fullness: fullness ?? this.fullness,
      foodInventory: foodInventory ?? this.foodInventory,
      ownedPetIds: ownedPetIds ?? this.ownedPetIds,
    );
  }
}

extension PetMoodLabel on PetMood {
  String get label {
    switch (this) {
      case PetMood.happy:
        return '开心陪学中';
      case PetMood.waiting:
        return '等你开始学习';
      case PetMood.encouraging:
        return '没关系，再来一次';
    }
  }
}
