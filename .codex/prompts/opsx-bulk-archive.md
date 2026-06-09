---
description: 一次性归档多个已完成变更
argument-hint: 命令参数
---

批量归档多个已完成的 OpenSpec 变更。该流程会检查 artifact、任务和规格冲突。

**输入**：不需要参数；必须让用户选择要归档的变更。

**步骤**

1. **获取 active changes**

   ```bash
   openspec list --json
   ```

   如果没有 active changes，告知用户并停止。

2. **让用户选择变更**

   使用多选问题展示每个变更及其 schema，并提供“全部变更”选项。不要自动选择。

3. **批量检查**

   对每个选中变更：
   - 运行 `openspec status --change "<name>" --json`
   - 检查 artifacts 是否完成
   - 读取 `tasks.md`，统计完成和未完成任务
   - 检查 delta spec

4. **处理冲突**

   如果多个变更修改同一 capability，先检查实际代码和主规格，判断应如何合并。不能盲目覆盖。

5. **归档**

   对确认可归档的变更执行：

   ```bash
   openspec archive "<name>"
   ```

6. **最终验证**

   ```bash
   openspec list
   openspec list --specs
   openspec validate --strict
   ```

**约束**

- 不要自动选择变更。
- 不要忽略未完成任务。
- 不要覆盖冲突规格。

