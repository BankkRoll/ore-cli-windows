# Windows cli to easily run multiple instances

This guide assumes you have the ore-cli and this directory in the same folder.

```bash
ore-cli/
├── src/ # ore 
├── target/ # ore build
├── windows-cli/ # this custom cli tool
├── Cargo.toml
├── keypair1.json
├── README.md
├── rust-toolchain.toml
├── StartCheckRewards.ps1
├── StartClaiming.ps1
├── Startmining.ps1
```

# Table of Contents
  - [Setup and Installation](#setup-and-installation)
  - [Scripting with PowerShell](#scripting-with-powershell)
  - [Usage](#usage)
    - [solana-cli](#solana-cli)
    - [ore-cli](#ore-cli)
    - [Using The Custom Windows Cli](#using-the-custom-windows-cli)
  - [Conclusion](#conclusion)
  - [Terms and Conditions](#terms-and-conditions)

## Setup and Installation

Install the required npm dependencies:

```bash
npm install
```

## Scripting with PowerShell

Make sure to edit the top configs of the script you want to run:
- [StartMining.ps1](../StartCheckRewards.ps1) - Instances will auto rotate between as many/little keypairs and rpcs are put.
- [StartCheckRewards.ps1](../StartCheckRewards.ps1) - Check all claimable rewards
- [StartClaiming.ps1](../StartCheckRewards.ps1) - Claim all claimable rewards


## Usage

To you use the custom `ore-cli` or `solana-cli` open your terminal and navigate to the `windows-cli` directory.

```bash
cd windows-cli
```

### `solana-cli`

To use the `solana-cli` for managing Solana keypairs and wallets, run:
```bash
npm run solana-cli
```

### `ore-cli`

For running the PowerShell scripts make sure you have configured your info, then just execute:

```bash
npm run ore-cli
```

An interactive menu will trigger, select the desired operation from the interactive menu. Ensure you have the necessary PowerShell scripts (`StartCheckRewards.ps1`, `StartMining.ps1`, `StartClaiming.ps1`)  and configured them with your info:


- [StartMining.ps1](../StartCheckRewards.ps1) - Instances will auto rotate between as many/little keypairs and rpcs are put.
- [StartCheckRewards.ps1](../StartCheckRewards.ps1) - Check all claimable rewards
- [StartClaiming.ps1](../StartCheckRewards.ps1) - Claim all claimable rewards


#### Organize Your Layout

Get PowerToys and use FancyZones to setup a super clean evenly organized layout quickly and easily:

- [Installing with Windows Package Manager](https://learn.microsoft.com/en-us/windows/powertoys/install#installing-with-windows-package-manager)
- [Installing with Windows executable file via GitHub](https://learn.microsoft.com/en-us/windows/powertoys/install#installing-with-windows-executable-file-via-github)
- [Installing with Microsoft Store](https://learn.microsoft.com/en-us/windows/powertoys/install#installing-with-microsoft-store)


## Conclusion

Clone or download the ore-cli here -> [HardhatChad/ore-cli](https://github.com/HardhatChad/ore-cli)

If you've found this guide helpful, please consider starring it to show your support!

Feeling generous? Feel free to buy me a Redbull by sending some SOL/ORE to `EEXrrWy7JwwjF74FZ9rJGL7sYbsm6QdiyhH4ipwhxpYa` all donations all greatly appreciated

### Terms and Conditions:

Use of this guide with the Ore CLI is entirely at your own risk. The author of this guide are not liable for any damage to your computer system or loss of data that results from the download of any materials, data, text, images, video, or audio from this guide. Additionally, no responsibility is assumed for any computer issues or financial losses that may result from using the Ore CLI, including but not limited to running multiple instances or downloading dependencies from unverified sources. Always ensure that your downloads are from legitimate and official sources.
