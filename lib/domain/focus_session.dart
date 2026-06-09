/// 一次专注会话的完成状态。
enum FocusSessionStatus {
  running,
  completed,
  abandoned,
}

/// 记录一次专注尝试。
///
/// `durationMinutes` 由 UI 限制在 5-120 分钟内；只有完成状态才会发放能量。
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

