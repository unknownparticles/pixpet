## ADDED Requirements

### Requirement: 可运行 Flutter Demo

Focus Pet demo SHALL 以 Flutter 应用形式运行，并展示完整的本地 soft-focus 闭环。

#### Scenario: 用户运行 demo

- **WHEN** 用户启动 Flutter 应用
- **THEN** 用户可以看到 Focus Pet 主界面
- **AND** 主界面包含宠物、专注设置、统计和分享卡预览。

### Requirement: Soft-Focus 会话

Demo SHALL 支持用户选择专注时长、开始 soft-focus、完成会话和放弃会话。

#### Scenario: 用户完成会话

- **WHEN** 用户完成一次专注会话
- **THEN** demo 发放能量
- **AND** 更新宠物等级、心情和统计。

#### Scenario: 用户放弃会话

- **WHEN** 用户提前放弃会话
- **THEN** demo 不发放能量
- **AND** 展示鼓励性反馈。

### Requirement: 像素宠物视觉

Demo SHALL 展示可见的像素宠物视觉，并优先使用生成式像素资产。

#### Scenario: 用户查看宠物区域

- **WHEN** 用户查看宠物区域
- **THEN** 用户可以看到像素风宠物
- **AND** 宠物区域展示名称、等级、能量、心情和下一个解锁目标。

### Requirement: 临时测试清理

Demo 验证 SHALL 遵守仓库规则，临时测试文件在验证完成后删除。

#### Scenario: 验证完成

- **WHEN** 奖励逻辑测试通过
- **THEN** 临时测试文件被删除
- **AND** 仓库中不保留测试类文件。

