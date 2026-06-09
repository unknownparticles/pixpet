---
name: openspec-verify-change
description: 验证实现是否匹配 OpenSpec 变更 artifact。适用于归档前确认实现完整、正确、一致。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

验证实现是否满足 OpenSpec 变更。

**输入**：可选变更名。若省略且上下文不明确，必须让用户选择。

**步骤**

1. 选择变更，必要时运行 `openspec list --json`。
2. 检查状态：

   ```bash
   openspec status --change "<name>" --json
   ```

3. 获取上下文：

   ```bash
   openspec instructions apply --change "<name>" --json
   ```

4. 逐项核对：
   - spec 要求是否被实现覆盖
   - tasks 是否完成并有证据
   - design 决策是否被遵守

5. 运行必要验证。Flutter 项目不执行 OHOS 检查。

6. 输出验证报告：先列问题，再给结论。

**约束**

- 不要只看 checkbox。
- 证据不足时不要声明通过。

