## ADDED Requirements

### Requirement: 原创产品定位

产品策略 SHALL 将 Focus Pet 定义为面向学生的原创专注陪伴产品，只借鉴公开市场模式，不复制 PixPet 品牌、私有实现、视觉素材或专有文案。

#### Scenario: 向干系人说明产品

- **WHEN** 干系人阅读 PRD 或 OpenSpec proposal
- **THEN** 文档将产品定位为面向学生的专注陪伴产品
- **AND** 文档说明该产品借鉴公开市场模式，而不是 PixPet 克隆。

### Requirement: 证据边界清晰

产品策略 SHALL 区分公开可验证证据和待验证假设，避免把 PixPet 的未验证爆款表现写成事实。

#### Scenario: 调研提到 PixPet 增长表现

- **WHEN** 调研文档讨论 PixPet 市场表现
- **THEN** 文档说明美国区 App Store 页面当前没有足够评分展示总览
- **AND** 文档将 PixPet 视为早期有潜力的独立产品，而不是已被证明的美国大众爆款。

### Requirement: MVP 成功指标

产品策略 SHALL 定义可度量的 MVP 成功指标，覆盖激活、首次专注、专注完成、留存和分享。

#### Scenario: 团队评估 MVP 是否值得继续投入

- **WHEN** 团队查看 PRD 指标
- **THEN** 可以看到引导完成率、首次开始专注率、首次专注完成率、领奖率、D2 留存、D7 留存、专注分钟数、分享卡导出率和提醒开启率。

### Requirement: 已确认实现方向

产品策略 SHALL 将 Flutter、iOS-first、soft-focus 和生成式像素资产记录为已确认实现方向。

#### Scenario: 团队准备创建实现变更

- **WHEN** 团队从产品 proposal 进入实现 proposal
- **THEN** 实现 proposal 以 Flutter 为客户端技术栈
- **AND** 以 iOS-first 为首发策略
- **AND** MVP 只实现 soft-focus，不实现硬拦截
- **AND** 首版像素资产使用生成式资产。

