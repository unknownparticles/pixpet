---
name: openspec-onboard
description: OpenSpec 引导流程，带用户完整走过一次带讲解的工作流。
license: MIT
compatibility: Requires openspec CLI.
metadata:
  author: openspec
  version: "1.0"
  generatedBy: "1.0.0"
---

带用户完成一次完整 OpenSpec 工作流。

## 预检

```bash
openspec status --json 2>&1 || echo "NOT_INITIALIZED"
```

如果未初始化，提示用户先运行 `openspec init`。

## 流程

1. 选择一个小而真实的任务。
2. 简短探索问题和代码。
3. 创建 OpenSpec change。
4. 编写 proposal、spec、design、tasks。
5. 按 tasks 实现。
6. 验证实现。
7. 同步规格并归档。

## 输出要求

- 讲解使用中文。
- 命令和路径保持原样。
- 不清楚时先问用户。
- Flutter 项目不执行 OHOS 检查。

