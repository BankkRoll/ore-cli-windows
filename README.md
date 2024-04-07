# Ore CLI Guide for Windows Users

If you've found this guide helpful, please consider ⭐starring⭐ it to show your support!

Feeling generous? Feel free to buy me a Redbull by sending some SOL to `EEXrrWy7JwwjF74FZ9rJGL7sYbsm6QdiyhH4ipwhxpYa` all donations all greatly appreciated

## Setup and Installation

### Clone or download the ore-cli here -> [HardhatChad/ore-cli](https://github.com/HardhatChad/ore-cli)

### 1. Install Rust:

- For native Windows development, install Rust via `rustup` by visiting the official [Rust installation page](https://www.rust-lang.org/tools/install).
- For a Linux-like development environment on Windows, use Windows Subsystem for Linux (WSL) and then install Rust within it.

### 2. Build the Ore CLI:

In Command Prompt or PowerShell, navigate to your project directory and execute:

```sh
cargo build --release
```

## Using the Ore CLI

Run the following command in Command Prompt, VS Terminal or PowerShell to start mining:

```
./target/release/ore --keypair <KEYPAIR-FILEPATH> mine
```

Suggested to pass custom rpc and priority-fee to get better success rate:

```
./target/release/ore --keypair <KEYPAIR-FILEPATH> --priority-fee <MICROLAMPORTS> --rpc <NETWORK-URL> mine
```

Live <MICROLAMPORTS> tracker i use to adjust priority-fee -> [QuikNode Solana Priority Fee Tracker](https://www.quicknode.com/gas-tracker/solana)

**Commands:**

- `balance`: Fetch the Ore balance of an account. This command requires the account's public key to view its current balance.
- `busses`: Fetch the distributable rewards of the busses. This shows the rewards that are ready to be distributed among participants.
- `mine`: Mine Ore using local compute resources. Initiates the mining process using the computational power of your local machine.
- `claim`: Claim available mining rewards. If you have mined Ore and accumulated rewards, use this command to claim them.
- `rewards`: Fetch your balance of unclaimed mining rewards. This shows how much you've earned from mining that hasn't been claimed yet.
- `treasury`: Fetch the treasury account and balance. Displays the balance and details of the treasury account, which is central to the Ore network.
- `help`: Print this message or the help of the given subcommand(s). Provides detailed information on specific commands or general help for using the CLI.

**Options:**

- `--rpc <NETWORK-URL>`: Specifies the network address of your RPC provider, allowing you to connect to a specific Solana cluster. Default is `https://api.mainnet-beta.solana.com`.
- `--keypair <KEYPAIR-FILEPATH>`: The filepath to your keypair file, used for signing transactions and authenticating with the network.
- `--priority-fee <MICROLAMPORTS>`: The number of microlamports to pay as a priority fee per transaction, allowing you to expedite processing. Default is `0`.
- `-h, --help`: Print help information for the CLI or specific commands.
- `-V, --version`: Print version information for the Ore CLI.

## Scripting with PowerShell

To enable monitoring and running multiple instances of the Ore CLIs just open powershell and paste the script you want to run!
- Suggested to open notepad, copy and paste the script you want and save it. To run it just right click and `Run With Powershell`.

#### Open multiple instances in the background, only open 1 window:
```
$OreCliDirectory = "C:\\Path\\To\\OreCli"     # Change this to your ore-cli directory
$KeyPairFile = "keypair.json"                 # Your keypair file in the ore-cli directory
$PriorityFee = 500000                         # Set your priority fee - <MICROLAMPORTS>
$RpcUrl = "https://your-rpc-url.com"          # Your custom RPC URL
$NumInstances = 10                            # Number of instances you want to run

$ScriptBlock = {
    param($OreCliDirectory, $KeyPairFile, $PriorityFee, $RpcUrl)
    cd $OreCliDirectory
    .\target\release\ore --keypair $KeyPairFile --priority-fee $PriorityFee --rpc $RpcUrl mine
}

function Start-OreCliProcesses {
    param($numInstances)
    for ($i = 0; $i -lt $numInstances; $i++) {
        Start-Job -ScriptBlock $ScriptBlock -ArgumentList $OreCliDirectory, $KeyPairFile, $PriorityFee, $RpcUrl
    }
}

while ($true) {
    $runningJobs = Get-Job | Where-Object { $_.State -eq 'Running' }
    $instancesToStart = $NumInstances - $runningJobs.Count
    if ($instancesToStart -gt 0) {
        Start-OreCliProcesses -numInstances $instancesToStart
    }
    Get-Job | Where-Object { $_.State -ne 'Running' } | Remove-Job
    Start-Sleep -Seconds 10
}
```

#### Open multiple instances in multiple tabs, auto restarts, and see logging for all instances:
```
$OreCliDirectory = "C:\\Path\\To\\OreCli"     # Change this to your ore-cli directory
$KeyPairFile = "keypair.json"                 # Your keypair file in the ore-cli directory
$PriorityFee = 500000                         # Set your priority fee - <MICROLAMPORTS>
$RpcUrl1 = "https://your-rpc-url.com"         # Your custom RPC URL #1 - multiple rpc for balancing load, use same for both if not
$RpcUrl2 = "https://your-rpc-url.com"         # Your custom RPC URL #2 - multiple rpc for balancing load, use same for both if not
$NumInstances = 10                            # Number of instances you want to run

for ($i = 0; $i -lt $NumInstances; $i++) {
    $RpcUrl = if ($i % 2 -eq 0) { $RpcUrl1 } else { $RpcUrl2 }
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
    Start-Sleep -Seconds 5
}
```
Get PowerToys and use FancyZones to setup a super clean evenly organized layout quickly and easily:

- [Installing with Windows Package Manager](https://learn.microsoft.com/en-us/windows/powertoys/install#installing-with-windows-package-manager)
- [Installing with Windows executable file via GitHub](https://learn.microsoft.com/en-us/windows/powertoys/install#installing-with-windows-executable-file-via-github)
- [Installing with Microsoft Store](https://learn.microsoft.com/en-us/windows/powertoys/install#installing-with-microsoft-store)



## Conclusion

If you've found this guide helpful, please consider starring it to show your support!

Feeling generous? Feel free to buy me a Redbull by sending some SOL to `EEXrrWy7JwwjF74FZ9rJGL7sYbsm6QdiyhH4ipwhxpYa` all donations all greatly appreciated

### Terms and Conditions:

Use of this guide with the Ore CLI is entirely at your own risk. The author of this guide are not liable for any damage to your computer system or loss of data that results from the download of any materials, data, text, images, video, or audio from this guide. Additionally, no responsibility is assumed for any computer issues or financial losses that may result from using the Ore CLI, including but not limited to running multiple instances or downloading dependencies from unverified sources. Always ensure that your downloads are from legitimate and official sources.
