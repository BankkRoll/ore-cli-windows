$OreCliDirectory = "C:\your\path\to\ore-cli" # path to your ore-cli directory (ex. C:\your\path\to\ore-cli-windows)
$PriorityFee = 1000000                       # priority fee in <MICROLAMPORTS>
$NumInstances = 10                           # number of instances to run (SHOULD = AMOUNT OF KEYPAIRS)
$KeyPairFiles = @(                           # all keypair files to claim
    "./keypairs/keypair1.json", 
    "./keypairs/keypair2.json"
    )
$RpcUrls = @(                                # all rpc urls to cycle through
    "your-rpc-urls-here",
    "your-rpc-urls-here"
)

# Opens a new PowerShell instance for each keypair file
for ($i = 0; $i -lt $NumInstances; $i++) {
    $RpcUrl = $RpcUrls[$i % $RpcUrls.Length]
    $KeyPairFile = $KeyPairFiles[$i % $KeyPairFiles.Length]

    $scriptBlockContent = @"
    while (`$true) {
        try {
            cd "$OreCliDirectory"
            .\target\release\ore --keypair "$KeyPairFile" --priority-fee $PriorityFee --rpc "$RpcUrl" mine
            Start-Sleep -Seconds 2  # pause to prevent immediate restart loop on fast failure
        } catch {
            Write-Error "An error occurred, restarting..."
            Start-Sleep -Seconds 2  # Pause before restarting
        }
    }
"@
    $encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptBlockContent))
    Start-Process "powershell.exe" -ArgumentList "-NoExit", "-EncodedCommand", $encodedCommand
    Start-Sleep -Seconds 30
}
