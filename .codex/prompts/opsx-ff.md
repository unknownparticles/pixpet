---
description: 一次性创建实现所需的 OpenSpec artifacts
argument-hint: 命令参数
---

快速生成进入实现前所需的 OpenSpec artifacts。

**输入**：`/opsx:ff` 后面的参数可以是 kebab-case 变更名，也可以是用户想构建的内容描述。

**步骤**

1. **没有输入时先询问**

   问用户想构建或修复什么，并根据回答生成 kebab-case 名称。

2. **创建变更目录**

   ```bash
   openspec new change "<name>"
   ```

3. **获取 artifact 顺序**

   ```bash
   openspec status --change "<name>" --json
   ```

   读取 `applyRequires` 和 `artifacts`。

4. **按依赖顺序创建 artifacts**

   逐个读取说明：

   ```bash
   openspec instructions <artifact-id> --change "<name>"
   ```

   然后创建 proposal、spec、design、tasks 等文件。

5. **校验**

   ```bash
   openspec validate "<name>" --strict
   ```

**约束**

- 适合用户明确想快速进入实现时使用。
- 不要跳过模糊需求确认。
- 生成内容要中文、具体、可验证。

