# スクリプト実行ディレクトリに移動
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ScriptDir

# 定数設定
$JdkUrl = "https://aka.ms/download-jdk/microsoft-jdk-21-windows-x64.zip"
$ZipLocal = "openjdk.zip"
$JdkDir = "openjdk"
$TmpDir = "$JdkDir-tmp"

Write-Host "Downloading OpenJDK ..."
Invoke-WebRequest -Uri $JdkUrl -OutFile $ZipLocal

Write-Host "Extracting to: $JdkDir"
Expand-Archive -Path $ZipLocal -DestinationPath $TmpDir -Force

# 一時ディレクトリ内の最初のサブディレクトリ名を取得
$InnerDir = Get-ChildItem -Path $TmpDir -Directory | Select-Object -First 1

# 移動＆整理
Move-Item -Path (Join-Path $TmpDir $InnerDir.Name) -Destination $JdkDir
Remove-Item -Recurse -Force $TmpDir
Remove-Item -Force $ZipLocal

# Java バージョン確認
Write-Host "Java version:"
& "$JdkDir\bin\java.exe" -version
