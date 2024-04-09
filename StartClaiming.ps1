$OreCliDirectory = "C:\your\path\to\ore-cli" # path to your ore-cli directory (ex. C:\your\path\to\ore-cli-windows)
$PriorityFee = 1000000                       # priority fee in <MICROLAMPORTS>
$KeyPairFiles = @(                           # all keypair files to claim
    "./keypairs/keypair1.json", 
    "./keypairs/keypair2.json"
    )
$RpcUrls = @(                                # all rpc urls to cycle through
    "your-rpc-urls-here",
    "your-rpc-urls-here"
)

# Opens a new PowerShell instance for each keypair file
foreach ($KeyPairFile in $KeyPairFiles) {
    $RpcUrl = $RpcUrls | Get-Random

    $scriptBlockContent = @"
    try {
        cd "$OreCliDirectory"
        .\target\release\ore --keypair "$KeyPairFile" --priority-fee $PriorityFee --rpc "$RpcUrl" claim
    } catch {
        Write-Error "An error occurred during the claim operation."
    }
"@
    $encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($scriptBlockContent))
    Start-Process "powershell.exe" -ArgumentList "-NoExit", "-EncodedCommand", $encodedCommand
    Start-Sleep -Seconds 2
}