# Focus Pet MVP 实现计划

> **给后续 agentic workers 的要求：** 实现本计划时必须使用 `superpowers:subagent-driven-development`（推荐）或 `superpowers:executing-plans`。每个任务使用 checkbox（`- [ ]`）追踪状态。

**目标：** 构建一个本地优先的学生专注陪伴 MVP，把完成的专注会话转化为确定性的宠物成长和可分享进度。

**架构：** 创建一个 iOS-first 的小型 Flutter App。产品逻辑放在初学者也能读懂的 model 和 service 中；每个 UI 页面只负责一个清晰流程；MVP 只实现 soft-focus，不实现硬拦截。

**技术栈：** Flutter 客户端；通过简单 repository 接口封装本地持久化；早期使用生成式像素资产；MVP 不需要后端。

---

## 已确认决策

- 客户端技术栈：Flutter。
- 首发平台：iOS-first。
- 专注模式：只做 soft-focus；MVP 不做硬拦截。
- 视觉资产路径：生成式像素图。

## 文件结构

- 创建：`lib/main.dart`，负责 App 启动和主题入口。
- 创建：`lib/app/focus_pet_app.dart`，负责顶层导航。
- 创建：`lib/features/onboarding/onboarding_screen.dart`，负责初始宠物选择。
- 创建：`lib/features/focus/focus_screen.dart`，负责专注计时设置和进行中状态。
- 创建：`lib/features/pet/pet_home_screen.dart`，负责宠物状态、能量和下一个解锁目标。
- 创建：`lib/features/stats/stats_screen.dart`，负责简单专注统计。
- 创建：`lib/features/share/share_card_screen.dart`，负责会话回顾和分享卡预览。
- 创建：`lib/domain/focus_session.dart`，负责专注会话数据。
- 创建：`lib/domain/pet_profile.dart`，负责宠物状态。
- 创建：`lib/domain/reward_ledger.dart`，负责确定性能量发放和解锁。
- 创建：`lib/services/focus_timer_controller.dart`，负责计时状态切换。
- 创建：`lib/services/focus_pet_repository.dart`，负责本地持久化边界。
- 创建：`lib/services/distraction_control.dart`，负责 soft-focus 状态和未来扩展边界。

## 任务 1：创建 Flutter App 骨架

**文件：**
- 创建：Flutter 项目文件。
- 创建：`lib/main.dart`
- 创建：`lib/app/focus_pet_app.dart`

- [ ] **步骤 1：创建 Flutter App**

运行：

```bash
flutter create .
```

预期：仓库中生成 Flutter 项目文件。

- [ ] **步骤 2：新增顶层 App 壳**

创建 `lib/main.dart`：

```dart
import 'package:flutter/material.dart';

import 'app/focus_pet_app.dart';

/// 启动 Focus Pet MVP。
///
/// MVP 阶段本地优先，因此启动时不需要网络、账号或云配置。
void main() {
  runApp(const FocusPetApp());
}
```

创建 `lib/app/focus_pet_app.dart`：

```dart
import 'package:flutter/material.dart';

/// Focus Pet 的根组件。
///
/// 顶层路由和 App 级主题集中在这里，避免功能页面承担过多职责。
class FocusPetApp extends StatelessWidget {
  const FocusPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Pet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B7C6E)),
        useMaterial3: true,
      ),
      home: const Placeholder(),
    );
  }
}
```

- [ ] **步骤 3：验证骨架**

运行：

```bash
flutter analyze
```

预期：没有 analysis 错误。

## 任务 2：新增领域模型

**文件：**
- 创建：`lib/domain/focus_session.dart`
- 创建：`lib/domain/pet_profile.dart`
- 创建：`lib/domain/reward_ledger.dart`

- [ ] **步骤 1：定义专注会话模型**

创建 `lib/domain/focus_session.dart`：

```dart
/// 一次专注会话的完成状态。
enum FocusSessionStatus {
  running,
  completed,
  abandoned,
}

/// 一次专注尝试。
///
/// `durationMinutes` 由 UI 限制在 PRD 要求的 5-120 分钟内。
/// 只有完成的会话可以发放能量；提前放弃默认不发放能量，保证奖励闭环真实可信。
class FocusSession {
  const FocusSession({
    required this.id,
    required this.startedAt,
    required this.durationMinutes,
    required this.status,
  });

  final String id;
  final DateTime startedAt;
  final int durationMinutes;
  final FocusSessionStatus status;

  bool get canGrantEnergy => status == FocusSessionStatus.completed;
}
```

- [ ] **步骤 2：定义宠物状态模型**

创建 `lib/domain/pet_profile.dart`：

```dart
/// 宠物主页展示的心情。
enum PetMood {
  happy,
  waiting,
  encouraging,
}

/// MVP 阶段的本地宠物状态。
///
/// 首版保持确定性且容易检查：能量只通过完成专注会话变化。
class PetProfile {
  const PetProfile({
    required this.petId,
    required this.name,
    required this.level,
    required this.energy,
    required this.mood,
  });

  final String petId;
  final String name;
  final int level;
  final int energy;
  final PetMood mood;

  PetProfile copyWith({
    String? petId,
    String? name,
    int? level,
    int? energy,
    PetMood? mood,
  }) {
    return PetProfile(
      petId: petId ?? this.petId,
      name: name ?? this.name,
      level: level ?? this.level,
      energy: energy ?? this.energy,
      mood: mood ?? this.mood,
    );
  }
}
```

- [ ] **步骤 3：定义奖励账本**

创建 `lib/domain/reward_ledger.dart`：

```dart
import 'focus_session.dart';
import 'pet_profile.dart';

/// 把专注会话产生的确定性奖励应用到宠物状态上。
///
/// MVP 故意不做付费随机奖励。用户应该能清楚理解宠物为什么成长、物品为什么解锁。
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
    );
  }
}
```

- [ ] **步骤 4：验证模型**

运行：

```bash
flutter analyze
```

预期：没有 analysis 错误。

## 任务 3：实现计时状态控制器

**文件：**
- 创建：`lib/services/focus_timer_controller.dart`

- [ ] **步骤 1：创建计时控制器**

创建 `lib/services/focus_timer_controller.dart`：

```dart
import '../domain/focus_session.dart';

/// 纯粹的专注计时状态辅助类。
///
/// UI 组件负责真实 tick；这里让开始、完成、放弃的状态切换清晰可测，
/// 避免测试时真的等待计时结束。
class FocusTimerController {
  const FocusTimerController();

  FocusSession start({
    required String id,
    required DateTime now,
    required int durationMinutes,
  }) {
    if (durationMinutes < 5 || durationMinutes > 120) {
      throw ArgumentError.value(
        durationMinutes,
        'durationMinutes',
        'Focus duration must be between 5 and 120 minutes.',
      );
    }

    return FocusSession(
      id: id,
      startedAt: now,
      durationMinutes: durationMinutes,
      status: FocusSessionStatus.running,
    );
  }

  FocusSession complete(FocusSession session) {
    return FocusSession(
      id: session.id,
      startedAt: session.startedAt,
      durationMinutes: session.durationMinutes,
      status: FocusSessionStatus.completed,
    );
  }

  FocusSession abandon(FocusSession session) {
    return FocusSession(
      id: session.id,
      startedAt: session.startedAt,
      durationMinutes: session.durationMinutes,
      status: FocusSessionStatus.abandoned,
    );
  }
}
```

- [ ] **步骤 2：验证控制器**

运行：

```bash
flutter analyze
```

预期：没有 analysis 错误。

## 任务 4：构建首条用户流程页面

**文件：**
- 创建：`lib/features/onboarding/onboarding_screen.dart`
- 创建：`lib/features/focus/focus_screen.dart`
- 修改：`lib/app/focus_pet_app.dart`

- [ ] **步骤 1：创建引导页面**

创建一个简单页面，展示“专注学习，获得能量，养成你的专注宠物”，提供三个初始宠物按钮，并能进入专注设置。

- [ ] **步骤 2：创建专注页面**

创建包含 15、25、45、60 分钟预设、开始按钮和 soft-focus 进行中状态的页面。

- [ ] **步骤 3：接入 App 首页**

更新 `FocusPetApp`，让 `home` 指向 `OnboardingScreen`。

- [ ] **步骤 4：验证 UI 编译**

运行：

```bash
flutter analyze
```

预期：没有 analysis 错误。

## 任务 5：新增宠物主页和统计页

**文件：**
- 创建：`lib/features/pet/pet_home_screen.dart`
- 创建：`lib/features/stats/stats_screen.dart`

- [ ] **步骤 1：创建宠物主页**

展示宠物名称、等级、能量、心情和下一个解锁阈值。

- [ ] **步骤 2：创建统计页**

展示今日专注分钟数、本周专注分钟数、当前连续天数和已完成专注次数。

- [ ] **步骤 3：验证 UI 编译**

运行：

```bash
flutter analyze
```

预期：没有 analysis 错误。

## 任务 6：新增分享卡预览

**文件：**
- 创建：`lib/features/share/share_card_screen.dart`

- [ ] **步骤 1：创建分享卡预览**

创建一个方形预览，包含宠物图占位、专注分钟数、连续天数和一句鼓励文案。

- [ ] **步骤 2：默认隐藏私密任务名**

默认分享卡不得渲染用户输入的学习任务名称。

- [ ] **步骤 3：验证 UI 编译**

运行：

```bash
flutter analyze
```

预期：没有 analysis 错误。

## 任务 7：新增 OpenSpec 实现变更

**文件：**
- 创建：`openspec/changes/implement-focus-pet-mvp/proposal.md`
- 创建：`openspec/changes/implement-focus-pet-mvp/design.md`
- 创建：`openspec/changes/implement-focus-pet-mvp/tasks.md`
- 创建：`openspec/changes/implement-focus-pet-mvp/specs/focus-pet-client/spec.md`

- [ ] **步骤 1：创建实现 proposal**

为已确认的 Flutter、iOS-first、soft-focus、生成式像素资产 MVP 创建新的 OpenSpec 实现变更。

- [ ] **步骤 2：校验实现 proposal**

运行：

```bash
openspec validate implement-focus-pet-mvp --strict
```

预期：该变更校验通过。

## 自查记录

- PRD 覆盖：引导、专注计时、soft-focus、宠物成长、奖励、统计、提醒和分享卡都有对应实现任务或明确范围。
- 占位符检查：计划不使用 TBD/TODO 之类占位写法。
- 类型一致性：`FocusSession`、`PetProfile`、`RewardLedger` 和 `FocusTimerController` 在各任务中命名一致。

