# Focus Pet

Focus Pet 是一个 Flutter iOS-first 可用 demo，目标是验证“专注学习 -> 获得能量 -> 养成像素宠物 -> 购买食物/形象 -> 分享成果”的核心闭环。

项目灵感来自 PixPet、Focus Friend、Finch 等公开产品模式，但本项目是原创 demo，不复制它们的品牌、素材、文案或私有实现。

## 当前能力

- 主页
  - 展示当前像素宠物、等级、能量、饱腹感、装饰和下一个解锁目标。
  - 支持选择初始宠物。
  - 支持 15、25、45、60 分钟 soft-focus 专注。
  - 完成专注后发放能量，更新等级、装饰和统计。
  - 放弃专注时不发放能量，并展示温和提示。
  - 展示今日专注、本周专注、连续天数和完成次数。
  - 展示隐私友好的分享卡预览。

- 商店
  - 使用专注获得的能量购买食物。
  - 使用已购买食物喂食宠物，提升饱腹感和心情。
  - 使用能量购买宠物形象。
  - 已购买形象可随时切换，不重复扣费。

- 设置
  - 每日学习提醒开关。
  - 柔和提示文案开关。
  - 声音反馈开关。
  - 一键重置 demo 数据。

## 已确认产品方向

- 客户端：Flutter。
- 首发策略：iOS-first。
- 专注策略：MVP 只做 soft-focus，不做硬拦截。
- 视觉资产：当前使用程序化生成的原创像素宠物，后续可替换为正式生成式 PNG 资产。
- 商业化：demo 内“购买”只使用专注能量，不接真实支付。

## 运行方式

安装 Flutter 后，在仓库根目录运行：

```bash
flutter pub get
flutter run
```

如需使用 web-server 方式预览：

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 55111
```

启动后访问：

```text
http://127.0.0.1:55111
```

## 验证方式

静态检查：

```bash
flutter analyze
```

OpenSpec 校验：

```bash
openspec validate create-focus-pet-mvp --strict
openspec validate implement-focus-pet-demo --strict
openspec validate add-shop-settings-demo --strict
```

## 仓库约束

- 修改 Flutter 项目时不执行 OHOS 相关检查。
- 不主动格式化代码。
- 临时测试文件只用于验证逻辑；验证完成后删除。
- 新增代码保持必要但不过量的注释，优先让初学者也能读懂。

## OpenSpec 变更

- `create-focus-pet-mvp`：产品调研、PRD 和 MVP 规格基础。
- `implement-focus-pet-demo`：实现可运行 Flutter demo。
- `add-shop-settings-demo`：补充主页、商店、设置、购买和喂食能力。

## 后续方向

- 接入本地持久化，保存宠物、库存、设置和统计。
- 替换为正式生成式像素 PNG 资产。
- 增加周报和更多分享卡样式。
- 在确认平台可行性后，再评估 iOS Screen Time 相关硬拦截能力。

