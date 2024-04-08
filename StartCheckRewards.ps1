$KeyPairFile = "keypair1.json"
$RpcUrl = "https://your-rpc-url.com"
$PublicKeys = @(
    "123456789987654321123456789987654321654987",
    # Add more public keys here
)

while ($true) {
    Clear-Host
    $date = Get-Date
    Write-Host "`n$date - Monitoring ORE Rewards" -ForegroundColor Cyan
    Write-Host "PK     | Rewards" -ForegroundColor Yellow
    Write-Host "------------------------------------------------" -ForegroundColor DarkGray

    $PublicKeys | ForEach-Object {
        $PublicKey = $_
        $pkShort = $PublicKey.Substring(0,3) + ".." + $PublicKey.Substring($PublicKey.Length - 3,3)
        try {
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