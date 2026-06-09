/// 首次进入和主页共用的初始宠物信息。
class StarterPet {
  const StarterPet({
    required this.id,
    required this.name,
    required this.trait,
    required this.scene,
    required this.tag,
  });

  final String id;
  final String name;
  final String trait;
  final String scene;
  final String tag;
}

/// Demo 固定三选一宠物。
class StarterPets {
  const StarterPets._();

  static const List<StarterPet> all = <StarterPet>[
    StarterPet(
      id: 'sprout',
      name: '芽芽',
      trait: '软萌晨读搭子',
      scene: '适合背单词、晨读和轻学习',
      tag: '温柔',
    ),
    StarterPet(
      id: 'bean',
      name: '豆豆',
      trait: '元气刷题伙伴',
      scene: '适合刷题、冲刺和限时训练',
      tag: '元气',
    ),
    StarterPet(
      id: 'mochi',
      name: '糯糯',
      trait: '安静复盘小友',
      scene: '适合晚间复盘、整理笔记',
      tag: '治愈',
    ),
  ];
}
