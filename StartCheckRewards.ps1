$OreCliDirectory = "C:\your\path\to\ore-cli" # path to your ore-cli directory (ex. C:\your\path\to\ore-cli-windows)
$KeyPairFile = "./keypairs/keypair1.json"    # 1 keypair to trigger 
$RpcUrl = "your-rpc-url-here"                # your rpc url
$PublicKeys = @(                             # all PUBLIC keys you want to monitor
  'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  # and so on
)

# Logs directly to the console
# Go to folder and "run with powershell" to open a new PowerShell instance that updates
while ($true) {
    Clear-Host
    $date = Get-Date
    Write-Host "`n$date - 10m Monitoring ORE Rewards" -ForegroundColor Cyan
    Write-Host "PK     | Rewards" -ForegroundColor Yellow
    Write-Host "------------------------------------------------" -ForegroundColor DarkGray

    $PublicKeys | ForEach-Object {
        $PublicKey = $_
        $pkShort = $PublicKey.Substring(0,3) + ".." + $PublicKey.Substring($PublicKey.Length - 3,3)
        try {
            cd "$OreCliDirectory"
            $output = & ".\target\release\ore" --keypair "$KeyPairFile" --rpc "$RpcUrl" rewards "$PublicKey"
            Write-Host "$pkShort | " -NoNewline -ForegroundColor Green
            Write-Host $output -ForegroundColor Yellow
        } catch {
            Write-Host "$pkShort | Error occurred" -ForegroundColor Red
        }
    }

    Write-Host "------------------------------------------------" -ForegroundColor DarkGray
    Start-Sleep -Seconds 600
}