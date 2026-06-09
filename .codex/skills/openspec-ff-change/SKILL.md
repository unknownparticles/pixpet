---
name: openspec-ff-change
description: 快速创建实现所需的 OpenSpec artifacts。适用于用户想跳过逐步引导、直接生成完整实现前材料时。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

快速生成 OpenSpec artifacts。

**输入**：用户应提供 kebab-case 变更名，或描述想构建的内容。

**步骤**

1. 如果输入不清楚，先问用户要构建什么。
2. 创建变更：

   ```bash
   openspec new change "<name>"
   ```

3. 获取 artifact 顺序：

   ```bash
   openspec status --change "<name>" --json
   ```

4. 按依赖顺序读取说明并创建 artifacts：

   ```bash
   openspec instructions <artifact-id> --change "<name>"
   ```

5. 严格校验：

   ```bash
   openspec validate "<name>" --strict
   ```

**约束**

- 需求模糊时不要强行生成。
- 生成内容必须具体、中文、可验证。

