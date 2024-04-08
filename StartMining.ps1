$KeyPairFiles = @(
    "keypair1.json", 
    # Add more keypair files here
    )
$PriorityFee = 1000000
$RpcUrls = @(
    "https://your-rpc-url.com",
    # Add more RPC URLs here
)
$NumInstances = 10 # 1 instance per keypair for best results

for ($i = 0; $i -lt $NumInstances; $i++) {
    $RpcUrl = $RpcUrls[$i % $RpcUrls.Length]
    $KeyPairFile = $KeyPairFiles[$i % $KeyPairFiles.Length]

    $scriptBlockContent = @"
    while (`$true) {
        try {
            .\target\release\ore --keypair "$KeyPairFile" --priority-fee $PriorityFee --rpc "$RpcUrl" mine
            Start-Sleep -Seconds 2
        } catch {
            Write-Error "An error occurred, restarting..."
            Start-Sleep -Seconds 2
        }
    }
"@
    $encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptBlockContent))
    Start-Process "powershell.exe" -ArgumentList "-NoExit", "-EncodedCommand", $encodedCommand
    Start-Sleep -Seconds 10
}