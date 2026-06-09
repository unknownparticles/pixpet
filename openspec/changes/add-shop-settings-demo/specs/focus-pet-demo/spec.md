## ADDED Requirements

### Requirement: 主页商店设置导航

Demo SHALL 提供主页、商店和设置三个主要入口。

#### Scenario: 用户打开 demo

- **WHEN** 用户启动应用
- **THEN** 用户可以在底部导航中看到主页、商店和设置
- **AND** 用户可以在三个页面间切换。

### Requirement: 食物购买与喂食

Demo SHALL 允许用户使用专注能量购买食物，并用食物喂食宠物。

#### Scenario: 用户能量足够时购买食物

- **WHEN** 用户在商店购买食物且能量足够
- **THEN** demo 扣除对应能量
- **AND** 增加该食物库存。

#### Scenario: 用户喂食宠物

- **WHEN** 用户拥有食物并点击喂食
- **THEN** demo 消耗一个食物
- **AND** 提升宠物饱腹感和心情。

### Requirement: 宠物形象购买与切换

Demo SHALL 允许用户使用专注能量购买宠物形象，并切换当前展示形象。

#### Scenario: 用户购买宠物形象

- **WHEN** 用户购买未拥有的宠物形象且能量足够
- **THEN** demo 扣除能量
- **AND** 将该形象加入已拥有列表。

#### Scenario: 用户切换已拥有形象

- **WHEN** 用户选择已拥有的宠物形象
- **THEN** demo 切换当前宠物形象
- **AND** 不重复扣除能量。

### Requirement: 设置页

Demo SHALL 提供本地设置页，支持开关和数据重置。

#### Scenario: 用户修改设置

- **WHEN** 用户切换提醒、柔和提示或声音反馈设置
- **THEN** demo 立即更新本地设置状态。

#### Scenario: 用户重置数据

- **WHEN** 用户点击重置 demo 数据
- **THEN** demo 恢复初始宠物、能量、统计、库存和设置状态。

