/// Demo 内存统计。
///
/// 这些字段对应 PRD 里的基础统计，后续可迁移到本地数据库。
class FocusStats {
  const FocusStats({
    required this.todayMinutes,
    required this.weekMinutes,
    required this.streakDays,
    required this.completedSessions,
  });

  final int todayMinutes;
  final int weekMinutes;
  final int streakDays;
  final int completedSessions;

  FocusStats completeSession(int durationMinutes) {
    return FocusStats(
      todayMinutes: todayMinutes + durationMinutes,
      weekMinutes: weekMinutes + durationMinutes,
      streakDays: streakDays == 0 ? 1 : streakDays,
      completedSessions: completedSessions + 1,
    );
  }
}

