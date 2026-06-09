---
description: 使用 OPSX 实验性 artifact 工作流创建新变更
argument-hint: 命令参数
---

使用 OpenSpec 的实验性 artifact 工作流创建一个新变更。

**输入**：`/opsx:new` 后面的参数可以是 kebab-case 的变更名，也可以是用户想构建或修复的内容描述。

**步骤**

1. **如果没有输入，先询问用户要做什么**

   使用开放式提问询问：
   > “你想创建什么变更？请描述要构建或修复的内容。”

   根据描述生成 kebab-case 名称，例如“添加用户认证”生成 `add-user-auth`。

   **重要**：没有理解用户要构建什么之前，不要继续。

2. **确定工作流 schema**

   默认省略 `--schema`，使用默认工作流。

   只有在以下情况使用其他 schema：
   - 用户提到 “tdd” 或 “test-driven”：使用 `--schema tdd`
   - 用户明确给出 schema 名称：使用 `--schema <name>`
   - 用户询问可用工作流：运行 `openspec schemas --json` 并让用户选择

3. **创建变更目录**

   ```bash
   openspec new change "<name>"
   ```

   只有用户明确要求非默认工作流时才附加 `--schema <name>`。

4. **展示 artifact 状态**

   ```bash
   openspec status --change "<name>"
   ```

5. **获取第一个 artifact 的说明**

   根据状态输出找到第一个 `ready` 的 artifact：

   ```bash
   openspec instructions <first-artifact-id> --change "<name>"
   ```

6. **停止并等待用户指示**

**输出**

完成后说明：
- 变更名称和位置
- 使用的 schema / 工作流及 artifact 顺序
- 当前状态
- 第一个 artifact 的模板
- 提示用户运行 `/opsx:continue`，或直接描述变更内容让我起草

**约束**

- 只展示说明，不创建 artifact 内容。
- 不要越过第一个 artifact 模板。
- 名称不是 kebab-case 时要求用户提供有效名称。
- 如果变更已存在，建议继续该变更。

