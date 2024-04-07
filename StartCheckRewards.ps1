$KeyPairFile = "keypair1.json"
$PriorityFee = 1000000
$RpcUrl = "https://your-rpc-url.com"
$PublicKeys = @(
    "123456789987654321123456789987654321654987",
    # Add more public keys here
)

$scriptBlockContent = $PublicKeys | ForEach-Object {
    $PublicKey = $_
    @"
    try {
        .\target\release\ore --keypair "$KeyPairFile" --priority-fee $PriorityFee --rpc "$RpcUrl" rewards "$PublicKey"
    } catch {
        Write-Error "An error occurred while processing public key $PublicKey."
    }
"@
}

$encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptBlockContent -join "`n"))
Start-Process "powershell.exe" -ArgumentList "-NoExit", "-EncodedCommand $encodedCommand"