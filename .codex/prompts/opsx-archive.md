---
description: 归档已完成的 OpenSpec 变更
argument-hint: 命令参数
---

归档一个已完成的 OpenSpec 变更。

**输入**：可选变更名。若省略，必须让用户从 active changes 中选择。

**步骤**

1. **选择变更**

   运行：

   ```bash
   openspec list --json
   ```

   只展示未归档的 active changes。不要猜测或自动选择。

2. **检查 artifact 完成状态**

   ```bash
   openspec status --change "<name>" --json
   ```

   如果存在未完成 artifact，列出并请用户确认是否继续。

3. **检查任务完成状态**

   读取 `tasks.md`，统计 `- [ ]` 和 `- [x]`。

   如果有未完成任务，列出并请用户确认是否继续。

4. **同步 spec**

   根据需要先执行 `/opsx:sync` 或手动把 delta spec 合并到主规格。

5. **归档变更**

   ```bash
   openspec archive "<name>"
   ```

6. **验证归档后状态**

   ```bash
   openspec list
   openspec list --specs
   ```

**约束**

- 不要归档不明确的变更。
- 不要忽略未完成任务。
- 归档前必须保证实现和规格一致。

