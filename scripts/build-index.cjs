// 生成 index.json 索引（扫描 plugins/ 目录，提取每个插件元数据）
// 用法：node scripts/build-index.cjs
const fs = require('fs')
const path = require('path')

const PLUGINS_DIR = path.join(__dirname, '..', 'plugins')
const OUT = path.join(__dirname, '..', 'index.json')

const AUTHORS = { default: 'ModMata 官方' }

function main() {
  const files = fs.readdirSync(PLUGINS_DIR).filter((f) => f.endsWith('.json'))
  const plugins = []
  for (const f of files) {
    try {
      const t = JSON.parse(fs.readFileSync(path.join(PLUGINS_DIR, f), 'utf-8'))
      if (!t || !t.id) continue
      plugins.push({
        id: t.id,
        name: t.name || t.id,
        icon: t.icon || 'puzzle',
        category: t.category || '其他',
        description: (t.description || '').slice(0, 200),
        version: t.version || '0.0.0',
        author: AUTHORS.default,
        updated: new Date().toISOString().slice(0, 10),
      })
    } catch (e) {
      console.error('跳过损坏文件:', f, e.message)
    }
  }
  plugins.sort((a, b) => a.id.localeCompare(b.id))
  const index = { schema: 1, updated: new Date().toISOString(), count: plugins.length, plugins }
  fs.writeFileSync(OUT, JSON.stringify(index, null, 2), 'utf-8')
  console.log(`===== 索引生成完成：${plugins.length} 个插件 → index.json =====`)
}

main()
