<#
.SYNOPSIS
    weather-briefing エージェントを GitHub Copilot CLI で実行するスクリプト

.DESCRIPTION
    指定した天気APIのURLから天気情報を取得し、要約を生成します。
    エージェント定義: .copilot/agents/weather-briefing.agent.md (ワークスペースローカル)

.PARAMETER Url
    天気情報を取得するURL（デフォルト: 東京の天気予報API）

.PARAMETER City
    都市コード（Urlパラメータより優先されます）
    例: 130010 (東京), 270000 (大阪), 230010 (名古屋), 400010 (福岡), 016010 (札幌)

.EXAMPLE
    .\run-weather-briefing.ps1
    .\run-weather-briefing.ps1 -City 270000
    .\run-weather-briefing.ps1 -Url "https://weather.tsukumijima.net/api/forecast/city/130010"
#>

param(
    [string]$Url,
    [string]$City = "130010"
)

# スクリプトのディレクトリを取得
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# ワークスペースローカルの設定ディレクトリ
$ConfigDir = Join-Path $ScriptDir ".copilot"

# URLが指定されていない場合は都市コードから生成
if (-not $Url) {
    $Url = "https://weather.tsukumijima.net/api/forecast/city/$City"
}

# エージェント名
$AgentName = "weather-briefing"

# プロンプト作成
$Prompt = "$Url から天気情報を取得して要約してください"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Weather Briefing Agent" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Config: $ConfigDir" -ForegroundColor Gray
Write-Host "URL:    $Url" -ForegroundColor Yellow
Write-Host ""

# GitHub Copilot CLI でエージェントを実行（ワークスペースローカルの設定を使用）
# モデル: gpt-4.1 を明示的に指定
try {
    copilot --config-dir $ConfigDir --agent $AgentName --model gpt-4.1 -p $Prompt --allow-all --silent
}
catch {
    Write-Error "エラーが発生しました: $_"
    exit 1
}
