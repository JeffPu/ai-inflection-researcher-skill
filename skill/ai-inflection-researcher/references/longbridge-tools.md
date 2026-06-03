# Longbridge 市场数据参考

长桥只替代富途市场数据层，用于行情、新闻、公告、财务、估值、分析师预期、市场温度和 K 线。不要用长桥替代 IBKR 的账户、真实持仓、组合风险或绩效数据。

禁止使用以下长桥命令作为用户账户或持仓来源：

```bash
longbridge assets
longbridge portfolio
longbridge positions
```

账户、真实持仓、现金、保证金、组合风险和绩效必须来自配置好的 `ibkr-dashboard` MCP。

## 标的格式

使用 `<CODE>.<MARKET>`：

| 市场 | 后缀 | 示例 |
|---|---|---|
| 美股 | `.US` | `NVDA.US`, `AAPL.US`, `TSLA.US` |
| 港股 | `.HK` | `700.HK`, `9988.HK` |
| A 股上海 | `.SH` | `600519.SH` |
| A 股深圳 | `.SZ` | `300750.SZ` |
| 新加坡 | `.SG` | `D05.SG` |

若市场不明确，先根据上下文判断；仍不明确时再询问用户。

## 第一阶段：市场环境

```bash
longbridge market-temp
longbridge quote SPY.US QQQ.US IWM.US --format json
longbridge kline history QQQ.US --start YYYY-MM-DD --end YYYY-MM-DD --period day
```

用途：

- 判断风险偏好、趋势和科技股环境。
- 为仓位建议提供市场背景，但最终仓位约束仍以 IBKR 账户风险为准。

## 第二阶段：转折点扫描

优先用长桥新闻和公告捕捉公司级催化剂：

```bash
longbridge news search "AI capex"
longbridge news search "HBM"
longbridge news search "800G optical"
longbridge filing NVDA.US
longbridge topic search "AI"
```

用 WebSearch 补充长桥未覆盖的行业报告、供应链媒体、电话会文字稿和第三方数据。

## 第三阶段：Top 机会深挖

对每个候选标的运行需要的子集：

```bash
longbridge quote SYMBOL.US --format json
longbridge static SYMBOL.US --format json
longbridge calc-index SYMBOL.US --index pe,pb,total_market_value,turnover_rate --format json
longbridge kline history SYMBOL.US --start YYYY-MM-DD --end YYYY-MM-DD --period day
longbridge news SYMBOL.US
longbridge filing SYMBOL.US
longbridge financial-report SYMBOL.US --latest
longbridge financial-statement SYMBOL.US --kind ALL
longbridge analyst-estimates SYMBOL.US
longbridge valuation-rank SYMBOL.US
```

用途：

- 行情和 K 线：股价表现、量价趋势、相对强弱、右侧确认。
- 静态资料和估值：市值、行业、PE/PB、换手、市值分层。
- 财务和分析师预期：收入、利润率、EPS 共识、修正方向。
- 新闻和公告：订单、资本开支、客户认证、管理层指引、风险事件。

## 输出要求

凡使用长桥数据，标注“数据来源：长桥证券”。若长桥命令失败或数据缺失，写明“长桥数据不可用/缺失”，并说明是否用 WebSearch 或公司文件替代。
