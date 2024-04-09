$KeyPairFiles = @(
    "keypair1.json", 
    # Add more keypair files here
    )
$PriorityFee = 1000000
$RpcUrls = @(
    "https://your-rpc-url.com",
    # Add more RPC URLs here
)

foreach ($KeyPairFile in $KeyPairFiles) {
    $RpcUrl = $RpcUrls | Get-Random

    $scriptBlockContent = @"
    try {
        .\target\release\ore --keypair "$KeyPairFile" --priority-fee $PriorityFee --rpc "$RpcUrl" claim
    } catch {
        Write-Error "An error occurred during the claim operation."
    }
"@
    $encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptBlockContent))
    Start-Process "powershell.exe" -ArgumentList "-NoExit", "-EncodedCommand", $encodedCommand
    Start-Sleep -Seconds 2
}
