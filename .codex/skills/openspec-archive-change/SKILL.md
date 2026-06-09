---
name: openspec-archive-change
description: 归档已完成的 OpenSpec 变更。适用于实现完成后收尾归档。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

归档已完成的 OpenSpec 变更。

**输入**：可选变更名。若省略，必须让用户选择。

**步骤**

1. 运行 `openspec list --json` 展示 active changes。
2. 让用户选择要归档的变更，不要猜。
3. 检查 artifact 状态：

   ```bash
   openspec status --change "<name>" --json
   ```

4. 检查 `tasks.md` 是否仍有 `- [ ]`。
5. 如有未完成内容，先让用户确认是否继续。
6. 同步 delta spec 到主规格。
7. 执行归档：

   ```bash
   openspec archive "<name>"
   ```

8. 验证归档结果。

**约束**

- 不要归档不明确或未验证的变更。
- 不要忽略未完成任务。

