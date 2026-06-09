---
name: openspec-continue-change
description: 继续推进 OpenSpec 变更并创建下一个 artifact。适用于用户想继续当前变更或创建下一份 artifact 时。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

继续一个 OpenSpec 变更。

**输入**：可选变更名。若省略且上下文不明确，必须让用户选择。

**步骤**

1. 运行 `openspec list --json` 查找可用变更。
2. 若有歧义，让用户选择变更，不要猜。
3. 运行：

   ```bash
   openspec status --change "<name>" --json
   ```

4. 找到当前 `ready` 的 artifact。
5. 运行：

   ```bash
   openspec instructions <artifact-id> --change "<name>"
   ```

6. 按说明创建或更新 artifact。
7. 运行：

   ```bash
   openspec validate "<name>" --strict
   ```

**约束**

- 每次只推进当前可用 artifact。
- 需求不清楚时先确认。
- 文档内容默认使用中文。

