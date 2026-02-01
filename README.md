# GitHub Copilot CLI - Agent & Skill サンプル

GitHub Copilot CLI のカスタム Agent と Skill を定義するサンプルリポジトリです。  
天気予報APIから情報を取得し、要約を生成する `weather-briefing` エージェントを例として実装しています。

## 📁 ファイル構成

```text
.copilot/
├── config.json                          # Copilot CLI 設定ファイル
├── agents/
│   └── weather-briefing.agent.md        # Agent 定義
└── skills/
    └── weather-briefing/
        └── SKILL.md                     # Skill 定義

run-weather-briefing.ps1                 # 実行用スクリプト
env.example                              # 環境変数サンプル
```

## 🔧 各ファイルの説明

### `.copilot/config.json`

Copilot CLI の設定ファイル。使用するスキルディレクトリを指定します。

```json
{
  "banner": "never",
  "skill_directories": [
    ".copilot/skills/weather-briefing"
  ]
}
```

### `.copilot/agents/weather-briefing.agent.md`

Agent の定義ファイル。YAML フロントマターで名前・説明・使用ツールを指定し、Markdown 本文で振る舞いを記述します。

```yaml
---
name: weather-briefing
description: |
  与えられたURLから本日と週間の天気概要を作成する。
tools:
  - read
  - web_fetch
  - grep
  - glob
---
```

### `.copilot/skills/weather-briefing/SKILL.md`

Skill の定義ファイル。Agent が参照する具体的な手順やフォーマットを記述します。

- データ取得方法（`web_fetch` ツールの使い方）
- 抽出する情報の項目
- 出力フォーマット（JSON + 人間向け要約）

## 🚀 実行方法

### 前提条件

- [GitHub Copilot CLI](https://githubnext.com/projects/copilot-cli) がインストールされていること
- GitHub で認証済みであること

### 実行

```powershell
# 東京の天気（デフォルト）
.\run-weather-briefing.ps1

# 都市コードを指定
.\run-weather-briefing.ps1 -City 270000  # 大阪

# URLを直接指定
.\run-weather-briefing.ps1 -Url "https://weather.tsukumijima.net/api/forecast/city/016010"
```

## 📝 出力例

```json
{
  "location": "東京都 東京",
  "source_url": "https://weather.tsukumijima.net/api/forecast/city/130010",
  "today": {
    "date": "2026-02-01",
    "summary": "晴れ",
    "precip_prob": "0%",
    "temp": "最高11℃"
  },
  "weekly": {
    "trend": "明日・明後日は晴時々曇",
    "highlights": ["冬型の気圧配置が続く"]
  }
}
```

## 🛠️ カスタマイズ

独自の Agent/Skill を作成する場合：

1. `.copilot/agents/` に `your-agent.agent.md` を作成
2. `.copilot/skills/your-skill/SKILL.md` を作成
3. `config.json` の `skill_directories` にパスを追加

## 📚 参考リンク

- [天気予報 API（livedoor 互換）](https://weather.tsukumijima.net/)
- [GitHub Copilot CLI](https://githubnext.com/projects/copilot-cli)

## ライセンス

MIT
