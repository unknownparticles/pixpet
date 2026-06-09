---
name: openspec-sync-specs
description: 将变更中的 delta spec 同步到主规格。适用于用户想更新主规格但暂不归档变更时。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

同步 delta spec 到主规格。

**输入**：可选变更名。若省略且上下文不明确，必须让用户选择。

**步骤**

1. 运行 `openspec list --json`，选择包含 delta spec 的变更。
2. 查找：

   ```text
   openspec/changes/<name>/specs/*/spec.md
   ```

3. 对每个 capability，读取 delta spec 和主规格：

   ```text
   openspec/specs/<capability>/spec.md
   ```

4. 合并 `ADDED`、`MODIFIED`、`REMOVED`、`RENAMED` Requirements。
5. 运行：

   ```bash
   openspec validate --strict
   ```

**约束**

- 不要重复复制 Requirement。
- 不要覆盖无关主规格内容。
- 保持中文正文和 OpenSpec 固定格式。

