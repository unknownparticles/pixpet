---
name: openspec-new-change
description: 使用实验性 artifact 工作流创建新的 OpenSpec 变更。适用于用户想以结构化步骤创建新功能、修复或修改时。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

创建新的 OpenSpec 变更。

**输入**：用户请求应包含 kebab-case 变更名，或包含想构建/修复的内容描述。

**步骤**

1. **没有明确输入时先询问用户**

   询问用户要构建或修复什么，并根据回答生成 kebab-case 名称。

2. **确定 schema**

   默认省略 `--schema`。只有用户明确要求 TDD 或其他 schema 时才附加。

3. **创建变更目录**

   ```bash
   openspec new change "<name>"
   ```

4. **查看状态**

   ```bash
   openspec status --change "<name>"
   ```

5. **获取第一个 ready artifact 的说明**

   ```bash
   openspec instructions <first-artifact-id> --change "<name>"
   ```

6. **停止等待用户**

**约束**

- 不要在此步骤直接创建 artifact 内容。
- 不要在需求不清楚时继续。
- 名称无效时要求用户提供有效 kebab-case 名称。

