import 'focus_session.dart';
import 'pet_profile.dart';

/// 把专注会话转化为确定性奖励。
///
/// Demo 不做随机抽奖，用户能清楚看到能量、等级和装饰为什么变化。
class RewardLedger {
  const RewardLedger();

  static const int energyPerFocusMinute = 1;
  static const int energyPerLevel = 25;

  PetProfile applySession(FocusSession session, PetProfile pet) {
    if (!session.canGrantEnergy) {
      return pet.copyWith(mood: PetMood.encouraging);
    }

    final nextEnergy = pet.energy + session.durationMinutes * energyPerFocusMinute;
    final nextLevel = 1 + nextEnergy ~/ energyPerLevel;

    return pet.copyWith(
      energy: nextEnergy,
      level: nextLevel,
      mood: PetMood.happy,
      decoration: decorationForLevel(nextLevel),
    );
  }

  String nextUnlockLabel(PetProfile pet) {
    final nextLevel = pet.level + 1;
    return 'Lv.$nextLevel 解锁 ${decorationForLevel(nextLevel)}';
  }

  int energyToNextLevel(PetProfile pet) {
    final nextThreshold = pet.level * energyPerLevel;
    final remaining = nextThreshold - pet.energy;
    return remaining <= 0 ? 0 : remaining;
  }

  String decorationForLevel(int level) {
    if (level >= 5) {
      return '星星书桌';
    }
    if (level >= 4) {
      return '月亮台灯';
    }
    if (level >= 3) {
      return '云朵坐垫';
    }
    if (level >= 2) {
      return '小书包';
    }
    return '空书桌';
  }
}

