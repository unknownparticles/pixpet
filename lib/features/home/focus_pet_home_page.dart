import 'package:flutter/material.dart';

import '../../domain/focus_session.dart';
import '../../domain/focus_stats.dart';
import '../../domain/pet_profile.dart';
import '../../domain/reward_ledger.dart';
import '../../domain/shop.dart';
import '../../domain/starter_pet.dart';
import '../../widgets/pixel_pet.dart';

/// Focus Pet demo 主界面。
///
/// 为了让 demo 一打开就能体验完整闭环，首版把引导、计时、宠物成长、
/// 统计和分享卡放在同一个可滚动页面里。
class FocusPetHomePage extends StatefulWidget {
  const FocusPetHomePage({
    super.key,
    required this.initialPet,
  });

  final StarterPet initialPet;

  @override
  State<FocusPetHomePage> createState() => _FocusPetHomePageState();
}

class _FocusPetHomePageState extends State<FocusPetHomePage> {
  static const List<int> _durations = <int>[15, 25, 45, 60];

  final RewardLedger _rewardLedger = const RewardLedger();
  final ShopService _shopService = const ShopService();

  late PetProfile _pet = _initialProfile(widget.initialPet);
  FocusStats _stats = const FocusStats(
    todayMinutes: 0,
    weekMinutes: 0,
    streakDays: 0,
    completedSessions: 0,
  );
  int _selectedMinutes = 25;
  int _selectedTab = 0;
  bool _isFocusing = false;
  bool _dailyReminderEnabled = true;
  bool _gentlePromptEnabled = true;
  bool _soundEnabled = false;
  String _message = '选择一只宠物，开始第一段 soft-focus 学习。';

  static PetProfile _initialProfile(StarterPet pet) {
    return PetProfile(
      petId: pet.id,
      name: pet.name,
      level: 1,
      energy: 0,
      mood: PetMood.waiting,
      decoration: '软垫小窝',
      ownedPetIds: <String>[pet.id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xFFFFF3D8),
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                sliver: SliverList.list(children: _currentTabChildren(context)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFFFFFAF0),
        indicatorColor: const Color(0xFFFFD8A8),
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: '主页',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront_rounded),
            label: '商店',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: '设置',
          ),
        ],
      ),
    );
  }

  List<Widget> _currentTabChildren(BuildContext context) {
    switch (_selectedTab) {
      case 1:
        return <Widget>[
          _buildPetCard(context),
          const SizedBox(height: 16),
          _buildShopPage(context),
        ];
      case 2:
        return <Widget>[
          _buildSettingsPage(context),
        ];
      default:
        return <Widget>[
          _buildPetCard(context),
          const SizedBox(height: 16),
          _buildFocusPanel(context),
          const SizedBox(height: 16),
          _buildStatsGrid(context),
          const SizedBox(height: 16),
          _buildShareCard(context),
        ];
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Focus Pet',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF3B2F2A),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '专注学习，获得能量，养成你的像素陪伴宠物。',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF52635D),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(BuildContext context) {
    final remaining = _rewardLedger.energyToNextLevel(_pet);

    return _Panel(
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFFFFE8B8),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFFC57A), width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7E8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: PixelPet(
                        petId: _pet.petId,
                        mood: _pet.mood.name,
                        size: 156,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 12,
                    width: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC97B4E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _pet.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF3B2F2A),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text('Lv.${_pet.level} · ${_pet.mood.label}'),
                  ],
                ),
              ),
              Chip(label: Text('${_pet.energy} 能量')),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: (_pet.energy % RewardLedger.energyPerLevel) /
                RewardLedger.energyPerLevel,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
            backgroundColor: const Color(0xFFFFE4C7),
            color: const Color(0xFFFF8A65),
          ),
          const SizedBox(height: 8),
          Text(
            remaining == 0 ? '再完成一次专注刷新奖励。' : '距离下一级还差 $remaining 能量',
          ),
          const SizedBox(height: 16),
          _InfoStrip(
            icon: Icons.school_rounded,
            label: '当前装饰：${_pet.decoration}',
          ),
          const SizedBox(height: 8),
          _InfoStrip(
            icon: Icons.restaurant_rounded,
            label: '饱腹感：${_pet.fullness}/100',
          ),
          const SizedBox(height: 8),
          _InfoStrip(
            icon: Icons.auto_awesome_rounded,
            label: '下个目标：${_rewardLedger.nextUnlockLabel(_pet)}',
          ),
        ],
      ),
    );
  }

  Widget _buildFocusPanel(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(
            icon: Icons.timer_rounded,
            title: 'Soft-Focus 专注',
            subtitle: '把手机放远一点，让宠物在小房间里陪你完成这一段。',
          ),
          const SizedBox(height: 12),
          SegmentedButton<int>(
            segments: _durations
                .map(
                  (minutes) => ButtonSegment<int>(
                    value: minutes,
                    label: Text('$minutes 分'),
                  ),
                )
                .toList(),
            selected: <int>{_selectedMinutes},
            onSelectionChanged: _isFocusing
                ? null
                : (values) {
                    setState(() => _selectedMinutes = values.first);
                  },
          ),
          const SizedBox(height: 16),
          AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isFocusing ? const Color(0xFF4A3A5A) : const Color(0xFFFFF0C7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  _isFocusing ? Icons.hourglass_bottom_rounded : Icons.spa_rounded,
                  color: _isFocusing ? Colors.white : const Color(0xFF7A4F1E),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _isFocusing
                        ? '正在进行 $_selectedMinutes 分钟 soft-focus：把手机放远一点，宠物会陪你学习。'
                        : _message,
                    style: TextStyle(
                      color: _isFocusing ? Colors.white : const Color(0xFF7A4F1E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: FilledButton.icon(
                  onPressed: _isFocusing ? _completeFocus : _startFocus,
                  icon: Icon(_isFocusing ? Icons.check_rounded : Icons.play_arrow_rounded),
                  label: Text(_isFocusing ? '完成专注' : '开始专注'),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: _isFocusing ? _abandonFocus : null,
                icon: const Icon(Icons.close_rounded),
                label: const Text('放弃'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    final items = <_StatItem>[
      _StatItem('今日专注', '${_stats.todayMinutes} 分'),
      _StatItem('本周专注', '${_stats.weekMinutes} 分'),
      _StatItem('连续天数', '${_stats.streakDays} 天'),
      _StatItem('完成次数', '${_stats.completedSessions} 次'),
    ];

    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            icon: Icons.bar_chart_rounded,
            title: '学习统计',
            subtitle: 'demo 先用本地内存记录，验证反馈是否清晰。',
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 86,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFAF0),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE9DDC5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(item.label),
                      const SizedBox(height: 6),
                      Text(
                        item.value,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShareCard(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            icon: Icons.ios_share_rounded,
            title: '分享卡预览',
            subtitle: '默认不展示私密学习任务，只展示努力成果。',
          ),
          const SizedBox(height: 12),
          Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFF5A3B63),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '今天和 ${_pet.name} 一起学习',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      PixelPet(
                        petId: _pet.petId,
                        mood: _pet.mood.name,
                        size: 120,
                      ),
                      Text(
                        '${_stats.todayMinutes} 分钟 · 连续 ${_stats.streakDays} 天',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: const Color(0xFFFFE8A3),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const Text(
                        '把今天的一小步，养成明天的超能力。',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopPage(BuildContext context) {
    return Column(
      children: <Widget>[
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionTitle(
                icon: Icons.lunch_dining_rounded,
                title: '食物商店',
                subtitle: '用专注能量购买食物，再喂给宠物提升饱腹感。',
              ),
              const SizedBox(height: 12),
              ...ShopCatalog.foods.map((food) => _buildFoodTile(context, food)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _SectionTitle(
                icon: Icons.face_retouching_natural_rounded,
                title: '宠物形象',
                subtitle: '购买后永久拥有，可随时切换当前陪伴宠物。',
              ),
              const SizedBox(height: 12),
              ...ShopCatalog.petSkins.map((petSkin) => _buildPetSkinTile(context, petSkin)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoodTile(BuildContext context, ShopItem food) {
    final count = _pet.foodInventory[food.id] ?? 0;

    return _ShopTile(
      title: food.name,
      subtitle: '${food.description} · 库存 $count',
      trailing: '${food.cost} 能量',
      primaryActionLabel: '购买',
      secondaryActionLabel: '喂食',
      onPrimary: () => _applyShopResult(_shopService.buyFood(_pet, food)),
      onSecondary: () => _applyShopResult(_shopService.feedPet(_pet, food)),
    );
  }

  Widget _buildPetSkinTile(BuildContext context, ShopItem petSkin) {
    final owned = _pet.ownedPetIds.contains(petSkin.id);
    final selected = _pet.petId == petSkin.id;

    return _ShopTile(
      title: petSkin.name,
      subtitle: owned ? '已拥有 · ${petSkin.description}' : petSkin.description,
      trailing: owned ? '已解锁' : '${petSkin.cost} 能量',
      primaryActionLabel: owned ? '切换' : '购买',
      secondaryActionLabel: selected ? '使用中' : null,
      onPrimary: () {
        final result = owned
            ? _shopService.selectPetSkin(_pet, petSkin)
            : _shopService.buyPetSkin(_pet, petSkin);
        _applyShopResult(result);
      },
    );
  }

  Widget _buildSettingsPage(BuildContext context) {
    return _Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitle(
            icon: Icons.settings_rounded,
            title: '设置',
            subtitle: '这些开关只影响 demo 本地状态，不申请系统权限。',
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _dailyReminderEnabled,
            onChanged: (value) => setState(() => _dailyReminderEnabled = value),
            title: const Text('每日学习提醒'),
            subtitle: const Text('未来可接入本地通知；demo 先记录开关状态。'),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _gentlePromptEnabled,
            onChanged: (value) => setState(() => _gentlePromptEnabled = value),
            title: const Text('柔和提示文案'),
            subtitle: const Text('开启后放弃会话时使用更温和的反馈。'),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _soundEnabled,
            onChanged: (value) => setState(() => _soundEnabled = value),
            title: const Text('声音反馈'),
            subtitle: const Text('demo 只保留设置入口，暂不播放真实音效。'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _resetDemoData,
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('重置 demo 数据'),
          ),
        ],
      ),
    );
  }

  void _startFocus() {
    setState(() {
      _isFocusing = true;
      _pet = _pet.copyWith(mood: PetMood.waiting);
      _message = 'soft-focus 已开始。';
    });
  }

  void _completeFocus() {
    final session = FocusSession(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      startedAt: DateTime.now(),
      durationMinutes: _selectedMinutes,
      status: FocusSessionStatus.completed,
    );
    setState(() {
      _isFocusing = false;
      _pet = _rewardLedger.applySession(session, _pet);
      _stats = _stats.completeSession(_selectedMinutes);
      _message = '完成 $_selectedMinutes 分钟！${_pet.name} 获得 $_selectedMinutes 能量。';
    });
  }

  void _abandonFocus() {
    final session = FocusSession(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      startedAt: DateTime.now(),
      durationMinutes: _selectedMinutes,
      status: FocusSessionStatus.abandoned,
    );
    setState(() {
      _isFocusing = false;
      _pet = _rewardLedger.applySession(session, _pet);
      _message = _gentlePromptEnabled
          ? '这次先停下也没关系，休息一下再回来。'
          : '本次专注已结束，未获得能量。';
    });
  }

  void _applyShopResult(ShopResult result) {
    setState(() {
      _pet = result.profile;
      _message = result.message;
    });
  }

  void _resetDemoData() {
    setState(() {
      _pet = const PetProfile(
        petId: 'sprout',
        name: '芽芽',
        level: 1,
        energy: 0,
        mood: PetMood.waiting,
        decoration: '空书桌',
      );
      _stats = const FocusStats(
        todayMinutes: 0,
        weekMinutes: 0,
        streakDays: 0,
        completedSessions: 0,
      );
      _selectedMinutes = 25;
      _isFocusing = false;
      _dailyReminderEnabled = true;
      _gentlePromptEnabled = true;
      _soundEnabled = false;
      _message = 'demo 数据已重置，可以重新开始体验。';
    });
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFDFB7)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1A9B5B21),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: const Color(0xFF2E7D6F)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF65736E),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoStrip extends StatelessWidget {
  const _InfoStrip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 18, color: const Color(0xFF7A5C20)),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
      ],
    );
  }
}

class _ShopTile extends StatelessWidget {
  const _ShopTile({
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.primaryActionLabel,
    required this.onPrimary,
    this.secondaryActionLabel,
    this.onSecondary,
  });

  final String title;
  final String subtitle;
  final String trailing;
  final String primaryActionLabel;
  final VoidCallback onPrimary;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF6E5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFFFD2A1)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(subtitle),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    trailing,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  FilledButton(
                    onPressed: onPrimary,
                    child: Text(primaryActionLabel),
                  ),
                  if (secondaryActionLabel != null) ...<Widget>[
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: onSecondary,
                      child: Text(secondaryActionLabel!),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  const _StatItem(this.label, this.value);

  final String label;
  final String value;
}
