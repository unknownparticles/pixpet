---
description: 引导用户完整体验一次 OpenSpec 工作流
argument-hint: 命令参数
---

带用户完成一次完整 OpenSpec 流程：从想法到 proposal、spec、design、tasks、实现和归档。

## 预检

先检查 OpenSpec 是否已初始化：

```bash
openspec status --json 2>&1 || echo "NOT_INITIALIZED"
```

如果未初始化，提示用户先运行 `openspec init`。

## 阶段 1：欢迎

说明本流程会做什么：

1. 选择一个真实的小任务。
2. 简短探索问题。
3. 创建 OpenSpec change。
4. 编写 proposal、spec、design、tasks。
5. 实现任务。
6. 归档完成的变更。

## 阶段 2：选择任务

优先选择小而真实、能在当前仓库验证的任务。避免选择范围过大的平台级功能。

## 阶段 3：创建变更

```bash
openspec new change "<name>"
openspec status --change "<name>"
```

## 阶段 4：创建 artifacts

按 `openspec status` 给出的 ready artifact 顺序推进。每个 artifact 创建后运行严格校验。

## 阶段 5：实现和验证

按 tasks 小步实现。每完成一项就更新 checkbox，并运行对应验证。Flutter 项目不运行 OHOS 检查。

## 阶段 6：归档

实现完成并验证后，合并规格并归档变更。

## 输出要求

- 过程说明使用中文。
- 命令和路径保持原样。
- 不确定的地方先问用户。

