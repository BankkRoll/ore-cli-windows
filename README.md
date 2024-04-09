# Ore CLI Guide for Windows Users

A command line interface for the Ore program, guided for windows.

This guide had been made to get from from start to mining in a user friendly way all directly in vscode!

Looking for the old guide? Check it out the old guide here -> [OLDREADME.md](./OLDREADME.md)

# Table of Contents
  - [Prerequisites](#prerequisites)
  - [Setup and Installation](#setup-and-installation)
  - [Using the Ore CLI](#using-the-ore-cli)
  - [Scripting with PowerShell](#scripting-with-powershell)
  - [Terms and Conditions](#terms-and-conditions)

## Prerequisites

To run this project, you must have the following installed:

- **Visual Studio Code**: Download and install from [https://code.visualstudio.com/](https://code.visualstudio.com/)

- **Rust**: Install the Rust toolchain using `rustup` by following the instructions at [https://www.rust-lang.org/tools/install](https://www.rust-lang.org/tools/install)

- **Ore-CLI**: The required [HardhatChad/ore-cli](https://github.com/HardhatChad/ore-cli) is included with the project. Follow the setup instructions provided in the project to get started. **MAKE SURE TO STAY UP TO DATE!**

## Setup and Installation

### 1. Install Rust:

- For native Windows development, install Rust via `rustup` by visiting the official [Rust installation page](https://www.rust-lang.org/tools/install).
- For a Linux-like development environment on Windows, use Windows Subsystem for Linux (WSL) and then install Rust within it.

### 2. Build the Ore CLI:

Open VS Code, navigate to the project directory, ex.`ore-cli-windows` and execute:

```sh
cargo build --release
```
This will build the project into a target folder we will work with.

### 3. Create keypair file(s):
> [!CAUTION]
> DO NOT SHOW OR COMMIT THESE ANYWHERE!!!! KEEP THEM LOCAL

You will need atleast 1 keypair or multiple if [scripting with powershell](#scripting-with-powershell).

Check out the [windows-cli](./windows-cli/README.md) attached for help generating or converting!

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

### Congrats! you should be all set up mining now!

## Scripting with PowerShell

Looking to get setup scripting and running multiple instances? Its all been moved to -> [windows-cli](./windows-cli)

## Conclusion

This is all possible thanks to the ore-cli -> [HardhatChad/ore-cli](https://github.com/HardhatChad/ore-cli)

If you've found this guide helpful, please consider starring it to show your support!

Feeling generous? Feel free to buy me a Redbull by sending some SOL/ORE to `EEXrrWy7JwwjF74FZ9rJGL7sYbsm6QdiyhH4ipwhxpYa` all donations all greatly appreciated

### Terms and Conditions:

Use of this guide with the Ore CLI is entirely at your own risk. The author of this guide are not liable for any damage to your computer system or loss of data that results from the download of any materials, data, text, images, video, or audio from this guide. Additionally, no responsibility is assumed for any computer issues or financial losses that may result from using the Ore CLI, including but not limited to running multiple instances or downloading dependencies from unverified sources. Always ensure that your downloads are from legitimate and official sources.
