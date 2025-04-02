Set-Location $PSScriptRoot

# config 読み込み（存在チェック付き）
if (-Not (Test-Path "./config.ps1")) {
    Write-Host "Not found config.ps1"
    exit 1
}

. "$PSScriptRoot\config.ps1"

# agent.jar がなければダウンロード
$agentJar = "agent.jar"
if (-Not (Test-Path $agentJar)) {
    Write-Host "Downloading agent.jar ..."
    Invoke-WebRequest -Uri "$env:JENKINS_URL/jnlpJars/agent.jar" -OutFile $agentJar
}

# Jenkins エージェント起動
Write-Host "Starting Jenkins agent..."
openjdk/bin/java -jar agent.jar -url $env:JENKINS_URL -secret $env:AGENT_SECRET -name $env:NODE_NAME -webSocket -workDir $env:WORK_DIR
