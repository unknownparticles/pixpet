---
description: 在归档前验证实现是否匹配 OpenSpec 变更
argument-hint: 命令参数
---

验证实现是否与变更 artifact（spec、tasks、design）一致。

**输入**：可选变更名。若省略且上下文不明确，必须让用户选择。

**步骤**

1. **选择变更**

   运行 `openspec list --json` 获取可用变更。展示包含实现任务的变更，并标出未完成任务。

2. **检查状态**

   ```bash
   openspec status --change "<name>" --json
   ```

3. **加载变更上下文**

   ```bash
   openspec instructions apply --change "<name>" --json
   ```

   阅读返回的所有上下文文件。

4. **建立验证报告**

   按三类检查：
   - spec 要求是否被实现覆盖
   - tasks 是否全部完成且有证据
   - design 决策是否被遵守

5. **运行必要验证**

   根据项目类型运行对应测试或静态检查。Flutter 项目不执行 OHOS 检查。

6. **输出结果**

   先列问题和风险，再给结论。不要把未验证内容说成通过。

**约束**

- 不要只看任务 checkbox；必须检查实际文件和验证结果。
- 证据不足时结论应为未完成或需补充验证。

