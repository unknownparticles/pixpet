---
description: 继续处理一个 OpenSpec 变更并创建下一个 artifact
argument-hint: 命令参数
---

继续一个已有变更，创建当前可推进的下一个 artifact。

**输入**：`/opsx:continue` 后可选变更名。若省略，先尝试从上下文推断；若不明确，必须让用户从可用变更中选择。

**步骤**

1. **没有明确变更名时让用户选择**

   运行：

   ```bash
   openspec list --json
   ```

   展示最近修改的 3-4 个变更，包含名称、schema、状态和最近修改时间。不要猜测或自动选择。

2. **检查当前状态**

   ```bash
   openspec status --change "<name>" --json
   ```

   读取 `schemaName`、`artifacts` 和 `isComplete`。

3. **按状态行动**

   - 如果所有 artifact 已完成：告诉用户变更已准备进入实现或归档。
   - 如果存在 `ready` artifact：获取该 artifact 的说明并起草内容。
   - 如果只有 `blocked` artifact：说明阻塞原因和依赖 artifact。

4. **获取 artifact 说明**

   ```bash
   openspec instructions <artifact-id> --change "<name>"
   ```

5. **创建或更新 artifact**

   根据说明写入对应文件。保持内容清晰、中文、可验证。

6. **校验状态**

   ```bash
   openspec validate "<name>" --strict
   openspec status --change "<name>"
   ```

**约束**

- 不要猜测用户想继续哪个变更。
- 不要跳过依赖顺序。
- 每次只推进当前可用的 artifact。

