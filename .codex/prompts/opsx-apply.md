---
description: 实现 OpenSpec 变更中的任务
argument-hint: 命令参数
---

根据 OpenSpec 变更中的任务开始或继续实现。

**输入**：可选变更名，例如 `/opsx:apply add-auth`。如果省略，先从上下文推断；若不明确，必须让用户选择。

**步骤**

1. **选择变更**

   有名称就使用该名称。没有名称时：
   - 如果上下文明确提到某个变更，可以使用它。
   - 如果只有一个 active change，可以自动选择。
   - 如果不明确，运行 `openspec list --json` 并让用户选择。

   说明当前使用的变更：`Using change: <name>`，并提示可用 `/opsx:apply <other>` 覆盖。

2. **检查状态和 schema**

   ```bash
   openspec status --change "<name>" --json
   ```

   读取 `schemaName`，并确认哪个 artifact 包含任务。

3. **获取实现说明**

   ```bash
   openspec instructions apply --change "<name>" --json
   ```

   读取上下文文件、进度、任务列表和当前状态说明。

4. **加载上下文**

   阅读 proposal、design、spec、tasks 等相关文件。不要凭记忆实现。

5. **按任务推进**

   - 一次处理一个小任务。
   - 更新任务 checkbox。
   - 按项目规则运行验证。
   - 不执行 OHOS 检查。
   - 不格式化代码，除非用户明确要求。

6. **完成后校验**

   ```bash
   openspec validate "<name>" --strict
   ```

**约束**

- 不要跳过未完成任务。
- 不要把 proposal 阶段当作实现阶段。
- 若需求不清楚，先确认。

