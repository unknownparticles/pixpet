## ADDED Requirements

### Requirement: 首次三选一

Demo SHALL 在首次进入时展示三只宠物供用户自由选择，并在选择后进入主页。

#### Scenario: 用户首次打开 demo

- **WHEN** 用户首次打开应用
- **THEN** 用户看到三只宠物选择卡片
- **AND** 用户尚未进入主页主流程。

#### Scenario: 用户选择宠物

- **WHEN** 用户点击某只宠物的选择按钮
- **THEN** demo 使用该宠物作为当前宠物
- **AND** 进入主页、商店和设置主流程。

### Requirement: 像素玩具风视觉

Demo SHALL 使用更可爱的像素玩具风视觉表达宠物和主页。

#### Scenario: 用户查看宠物选择和主页

- **WHEN** 用户查看宠物选择页或主页宠物区域
- **THEN** 宠物形象更圆润、更可爱
- **AND** 页面视觉更接近养成玩具，而不是普通效率工具。

