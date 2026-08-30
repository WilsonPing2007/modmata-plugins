# ModMata 插件商店（社区市场）

ModMata 的官方/社区插件分发仓库。ModMata 应用内「设置 → 第三方插件」从这里浏览、一键安装、检查更新。

## 目录结构

```
modmata-plugins/
├── index.json          # 插件索引（应用拉取这个文件展示市场）
├── plugins/            # 插件本体（每个插件一个 json，与 ModMata 插件格式一致）
│   └── <id>.json
└── scripts/
    └── build-index.cjs # 扫描 plugins/ 重新生成 index.json
```

## 如何发布一个新插件

1. 把你的插件 json 文件放进 `plugins/`（文件名 = 插件 id，如 `my-plugin.json`）
2. 运行 `node scripts/build-index.cjs` 重新生成索引
3. 提交并推送（`git add -A && git commit -m "add: 插件名" && git push`）

> 插件 json 必须包含 `id`、`name`、`version` 字段，否则会被索引跳过。

## 如何更新一个已有插件

1. 修改 `plugins/<id>.json` 里的内容，**版本号必须递增**（应用靠版本号对比提示更新）
2. 重新生成索引并推送

## 插件格式说明

与 ModMata 内置插件完全一致（JSON + Python 代码）：

```json
{
  "id": "linear-regression",
  "name": "线性回归",
  "icon": "chart-line",
  "category": "预测",
  "description": "一句话说明这个插件做什么",
  "version": "1.0.0",
  "params": [...],
  "inputs": [...],
  "outputs": [...],
  "code": "python 代码，参数用 {{key}} 占位"
}
```

## 安全说明

第三方插件会以你的电脑权限运行 Python 代码。安装前 ModMata 会明确提示：
- 只安装你信任的作者的插件
- 插件更新时同样会提示
- 不想要了随时可在 ModMata 里删除（删除=真删）

## 官方插件

初始 14 个插件由 ModMata 官方上架（数据导入导出、EDA 可视化、模型训练与评估、指标面板、泊松分布等）。
