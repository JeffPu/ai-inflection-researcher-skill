# AI Inflection Researcher Skill

`ai-inflection-researcher` 是一个面向 AI 产业链投研的 Agent Skill，用来把“AI 产业链发生了什么变化”拆成可验证、可跟踪、可交易的研究框架。

它不只是生成 AI 概念股清单，而是引导 AI 助手按买方研究员的方式分析：

- AI 当前阶段真正缺什么？
- 新模型、新产品或新硬件能力带来了什么新瓶颈？
- 谁是真实付费方，钱从哪里来？
- 哪些环节有稀缺产能、定价权和利润池？
- 哪些资产可能受益，哪些资产可能受损？
- 哪些机会还没有被市场充分定价？
- 什么事实出现后，应该承认判断错误？

本仓库同时支持 **Codex** 和 **Claude Code**。Skill 本体是通用 Markdown 结构，安装脚本会把它复制到对应 Agent 的 skills 目录。

## 适合什么场景

适合用于：

- AI 产业链投资机会扫描。
- AI 资本开支、算力、HBM、光模块、电力、液冷等方向研究。
- AI 软件、agent、端侧设备、机器人、自动驾驶、AI 医药等主题拆解。
- 寻找预期差、做多/做空候选、配对交易和观察名单。
- 校验当前持仓中的 AI 相关风险和机会。

如果 AI 客户端中接入了 IBKR MCP 插件，Skill 还会尝试结合账户持仓、风险敞口和市场环境，给出更贴近真实交易约束的建议。没有 IBKR 插件时，也可以只基于公开信息完成研究。

## 仓库结构

```text
.
├── README.md
├── scripts/
│   ├── install-claude.sh
│   ├── install.sh
│   └── package.sh
└── skill/
    └── ai-inflection-researcher/
        ├── SKILL.md
        ├── agents/
        │   └── openai.yaml
        └── references/
            ├── ibkr-tools.md
            └── longbridge-tools.md
```

可安装的 Skill 位于：

```text
skill/ai-inflection-researcher/
```

仓库根目录的 README、安装脚本和打包脚本用于 GitHub 分发，不需要放进已安装的 skill 目录。

## Codex 安装方法

克隆仓库：

```bash
git clone https://github.com/JeffPu/ai-inflection-researcher-skill.git
cd ai-inflection-researcher-skill
```

安装到 Codex 默认 skills 目录：

```bash
./scripts/install.sh
```

默认目标路径是：

```text
${CODEX_HOME:-$HOME/.codex}/skills/ai-inflection-researcher
```

如果你想安装到其他目录：

```bash
./scripts/install.sh /path/to/skills
```

安装后，如果 Codex 没有立即识别这个 skill，重启 Codex。

## Claude Code 安装方法

Claude Code 的 skills 通常放在用户目录下：

```text
~/.claude/skills/
```

安装到 Claude Code 默认 skills 目录：

```bash
./scripts/install-claude.sh
```

默认目标路径是：

```text
${CLAUDE_HOME:-$HOME/.claude}/skills/ai-inflection-researcher
```

如果你想安装到其他目录：

```bash
./scripts/install-claude.sh /path/to/claude/skills
```

也可以手动安装：

```bash
mkdir -p ~/.claude/skills
cp -R skill/ai-inflection-researcher ~/.claude/skills/
```

安装后重启 Claude Code，或重新打开当前项目会话，让 Claude 重新加载 skills。

## 打包为 .skill

如果你想生成可分发的 `.skill` 压缩包：

```bash
./scripts/package.sh
```

输出位置：

```text
dist/ai-inflection-researcher.skill
```

## 可选工具依赖

这个 Skill 可以只依赖联网搜索使用，但如果接入 IBKR（目前 Claude 已提供官方 MCP 插件，Codex 和 Grok 官方正在开发中），输出会更适合真实账户约束。

可选 IBKR 工具包括：

- `get_market_regime`
- `get_account_overview`
- `get_portfolio_risk`
- `list_positions`
- `get_position_detail`
- `get_stock_analysis`
- `get_performance_summary`
- `list_cash_flows`
- `get_wheel_snapshot`

如果这些工具不可用，Skill 会要求 Agent 在报告开头说明“IBKR 数据不可用，持仓对齐环节跳过”，并继续完成公开资料研究。

## 使用示例

可以这样问：

```text
用 ai-inflection-researcher 帮我扫描一下现在 AI 产业链最值得关注的转折点。
```

```text
深挖 HBM 产业链，看有哪些还没有被充分定价的交易机会。
```

```text
检查我当前持仓里 AI 相关标的的机会和风险。
```

```text
找 AI 产业链里可能被新技术路线冲击的做空候选。
```

## 风险声明

本 Skill 是研究工作流，不构成投资建议。任何输出都应结合一手资料、当前市场价格、流动性、税务约束、个人风险承受能力和独立判断后再使用。
