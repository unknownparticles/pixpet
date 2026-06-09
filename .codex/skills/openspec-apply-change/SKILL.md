---
name: openspec-apply-change
description: 实现 OpenSpec 变更中的任务。适用于用户想开始实现、继续实现或按任务推进时。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

实现 OpenSpec 变更。

**输入**：可选变更名。若省略且无法从上下文判断，必须让用户选择。

**步骤**

1. **选择变更**

   有明确名称就使用；否则运行 `openspec list --json` 并让用户选择。

2. **检查状态**

   ```bash
   openspec status --change "<name>" --json
   ```

3. **获取实现说明**

   ```bash
   openspec instructions apply --change "<name>" --json
   ```

4. **读取上下文文件**

   阅读 proposal、design、spec 和 tasks，再开始实现。

5. **按任务小步实现**

   每完成一项就更新 tasks checkbox。Flutter 项目不执行 OHOS 检查，不主动格式化代码。

6. **验证**

   ```bash
   openspec validate "<name>" --strict
   ```

**约束**

- 不要跳过未完成任务。
- 不要把未验证结果说成已完成。
- 遇到不明确需求时先问用户。

