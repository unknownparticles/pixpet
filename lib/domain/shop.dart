import 'pet_profile.dart';

/// 商店商品的类型。
enum ShopItemType {
  food,
  petSkin,
}

/// Demo 商店商品。
///
/// 食物和宠物形象共用这个模型，避免 demo 阶段引入过多类。
class ShopItem {
  const ShopItem({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.type,
    this.fullnessValue = 0,
  });

  final String id;
  final String name;
  final String description;
  final int cost;
  final ShopItemType type;
  final int fullnessValue;
}

/// 固定商店目录。
///
/// 这些数据是 demo 内置内容，后续可以迁移到配置或后端。
class ShopCatalog {
  const ShopCatalog._();

  static const List<ShopItem> foods = <ShopItem>[
    ShopItem(
      id: 'berry',
      name: '莓果便当',
      description: '适合短专注后的轻量补给。',
      cost: 12,
      type: ShopItemType.food,
      fullnessValue: 25,
    ),
    ShopItem(
      id: 'toast',
      name: '星星吐司',
      description: '让宠物更有精神继续陪学。',
      cost: 20,
      type: ShopItemType.food,
      fullnessValue: 40,
    ),
  ];

  static const List<ShopItem> petSkins = <ShopItem>[
    ShopItem(
      id: 'bean',
      name: '豆豆',
      description: '刷题冲刺型像素伙伴。',
      cost: 35,
      type: ShopItemType.petSkin,
    ),
    ShopItem(
      id: 'mochi',
      name: '糯糯',
      description: '晚间复盘型像素伙伴。',
      cost: 45,
      type: ShopItemType.petSkin,
    ),
  ];
}

/// 商店操作结果。
class ShopResult {
  const ShopResult({
    required this.success,
    required this.profile,
    required this.message,
  });

  final bool success;
  final PetProfile profile;
  final String message;
}

/// 处理购买、喂食和形象切换。
///
/// 所有操作都返回新的 `PetProfile`，让 UI 可以用 setState 明确更新。
class ShopService {
  const ShopService();

  ShopResult buyFood(PetProfile profile, ShopItem food) {
    if (profile.energy < food.cost) {
      return ShopResult(
        success: false,
        profile: profile,
        message: '能量不足，先完成一段专注吧。',
      );
    }

    final inventory = Map<String, int>.from(profile.foodInventory);
    inventory[food.id] = (inventory[food.id] ?? 0) + 1;

    return ShopResult(
      success: true,
      profile: profile.copyWith(
        energy: profile.energy - food.cost,
        foodInventory: inventory,
      ),
      message: '已购买 ${food.name}。',
    );
  }

  ShopResult feedPet(PetProfile profile, ShopItem food) {
    final count = profile.foodInventory[food.id] ?? 0;
    if (count <= 0) {
      return ShopResult(
        success: false,
        profile: profile,
        message: '还没有 ${food.name}，先去商店购买吧。',
      );
    }

    final inventory = Map<String, int>.from(profile.foodInventory);
    inventory[food.id] = count - 1;
    final nextFullness = (profile.fullness + food.fullnessValue).clamp(0, 100);

    return ShopResult(
      success: true,
      profile: profile.copyWith(
        fullness: nextFullness,
        foodInventory: inventory,
        mood: PetMood.happy,
      ),
      message: '${profile.name} 吃掉了 ${food.name}，饱腹感提升到 $nextFullness。',
    );
  }

  ShopResult buyPetSkin(PetProfile profile, ShopItem petSkin) {
    if (profile.ownedPetIds.contains(petSkin.id)) {
      return ShopResult(
        success: true,
        profile: profile,
        message: '已经拥有 ${petSkin.name}，可以直接切换。',
      );
    }
    if (profile.energy < petSkin.cost) {
      return ShopResult(
        success: false,
        profile: profile,
        message: '能量不足，先完成一段专注吧。',
      );
    }

    return ShopResult(
      success: true,
      profile: profile.copyWith(
        energy: profile.energy - petSkin.cost,
        ownedPetIds: <String>[...profile.ownedPetIds, petSkin.id],
      ),
      message: '已解锁宠物形象 ${petSkin.name}。',
    );
  }

  ShopResult selectPetSkin(PetProfile profile, ShopItem petSkin) {
    if (!profile.ownedPetIds.contains(petSkin.id)) {
      return ShopResult(
        success: false,
        profile: profile,
        message: '还未拥有 ${petSkin.name}，请先购买。',
      );
    }

    return ShopResult(
      success: true,
      profile: profile.copyWith(
        petId: petSkin.id,
        name: petSkin.name,
        mood: PetMood.happy,
      ),
      message: '已切换为 ${petSkin.name}。',
    );
  }
}
