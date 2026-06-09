---
description: 将变更中的 delta spec 同步到主规格
argument-hint: 命令参数
---

把某个变更下的 delta spec 合并到 `openspec/specs/` 主规格中。

**输入**：可选变更名。若省略且上下文不明确，必须让用户选择。

**步骤**

1. **选择变更**

   运行 `openspec list --json`，展示包含 `specs/` delta 的变更。不要猜测。

2. **查找 delta spec**

   路径格式：

   ```text
   openspec/changes/<name>/specs/*/spec.md
   ```

   常见章节：
   - `## ADDED Requirements`
   - `## MODIFIED Requirements`
   - `## REMOVED Requirements`
   - `## RENAMED Requirements`

3. **逐个 capability 合并**

   读取 delta spec，再读取对应主规格：

   ```text
   openspec/specs/<capability>/spec.md
   ```

   如果主规格不存在，则创建。

4. **智能合并**

   新需求追加到主规格；修改需求时只改对应 Requirement 和 Scenario；删除和重命名要保持上下文清晰。

5. **校验**

   ```bash
   openspec validate --strict
   ```

**约束**

- 不要机械复制导致重复 Requirement。
- 不要删除未确认的主规格内容。
- 合并后保持中文说明和 OpenSpec 固定格式。

