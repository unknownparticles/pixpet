---
name: openspec-bulk-archive-change
description: 一次性归档多个已完成 OpenSpec 变更。适用于多个并行变更都已完成时。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

批量归档多个 OpenSpec 变更。

**输入**：不需要参数；必须让用户选择变更。

**步骤**

1. 获取 active changes：

   ```bash
   openspec list --json
   ```

2. 使用多选让用户选择要归档的变更，不要自动选择。
3. 对每个变更检查：
   - artifact 状态
   - tasks 完成情况
   - delta spec
   - 可能的主规格冲突

4. 如存在冲突，检查真实实现和主规格后再决定合并方式。
5. 逐个归档：

   ```bash
   openspec archive "<name>"
   ```

6. 最终校验：

   ```bash
   openspec list
   openspec list --specs
   openspec validate --strict
   ```

**约束**

- 不要自动选择变更。
- 不要忽略未完成任务。
- 不要覆盖冲突规格。

