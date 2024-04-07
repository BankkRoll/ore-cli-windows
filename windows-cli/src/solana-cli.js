#!/usr/bin/env node
const yargs = require("yargs/yargs");
const { hideBin } = require("yargs/helpers");
const inquirer = require("inquirer");
const { Keypair } = require("@solana/web3.js");
const bs58 = require("bs58");
const fs = require("fs");
const path = require("path");

async function main() {
  const argv = yargs(hideBin(process.argv)).option("interactive", {
    alias: "i",
    type: "boolean",
    description: "Run in interactive mode",
    default: true,
  }).argv;

  if (argv.interactive) {
    await runInteractive();
  } else {
    console.log("Non-interactive mode is not supported yet.");
  }
}

async function runInteractive() {
  try {
    const response = await inquirer.prompt([
      {
        type: "list",
        name: "action",
        message: "What do you want to do?",
        choices: [
          { name: "Generate a new Keypair", value: "generate" },
          { name: "Convert a Private Key to Keypair", value: "convert" },
        ],
      },
    ]);

    const proceed = await inquirer.prompt([
      {
        type: "list",
        name: "confirmProceed",
        message:
          "Sensitive information (keys) will be displayed. Ensure no unauthorized persons are watching your screen. Proceed?",
        choices: [
          { name: "Yes, proceed", value: true },
          { name: "No, cancel", value: false },
        ],
      },
    ]);

    if (!proceed.confirmProceed) {
      console.log("Operation cancelled by user.");
      return;
    }

    switch (response.action) {
      case "generate":
        await generateKeypair();
        break;
      case "convert":
        await convertPrivateKeyToKeypair();
        break;
      default:
        console.log("Invalid option, exiting.");
        break;
    }
  } catch (error) {
    console.error("An error occurred:", error.message);
  }
}

async function generateKeypair() {
  try {
    const keypair = Keypair.generate();
    const secretKey = keypair.secretKey;
    const publicKeyBase58 = keypair.publicKey.toBase58();
    const privateKeyBase58 = bs58.encode(secretKey);

    console.log("New Keypair generated:");
    console.log(`{
        "publicKey": "\x1b[96m${publicKeyBase58}\x1b[0m",
        "privateKey": "\x1b[96m${privateKeyBase58}\x1b[0m",
        "Keypair": \x1b[96m[${Array.from(secretKey).toString()}]\x1b[0m
      }`);

    const { confirmSave } = await inquirer.prompt([
      {
        type: "list",
        name: "confirmSave",
        message: "Do you want to save the keypair to a file?",
        choices: [
          { name: "Yes, save the keypair", value: true },
          { name: "No, do not save", value: false },
        ],
      },
    ]);

    if (confirmSave) {
      const { filename } = await inquirer.prompt([
        {
          type: "input",
          name: "filename",
          message: "Enter filename for the keypair:",
          default: "keypair.json",
        },
      ]);

      const filePath = path.join(process.cwd(), filename);
      fs.writeFileSync(
        filePath,
        JSON.stringify(Array.from(keypair.secretKey), null, 2),
      );

      console.log(`Keypair saved to ${filePath}`);
    }
  } catch (error) {
    console.error("Failed to generate a new Keypair:", error.message);
  }
}

async function convertPrivateKeyToKeypair() {
  try {
    const answers = await inquirer.prompt([
      {
        type: "input",
        name: "privateKey",
        message: "Enter the private key in Base58 encoding:",
      },
    ]);

    const privateKey = bs58.decode(answers.privateKey);
    const keypair = Keypair.fromSecretKey(privateKey);
    const publicKeyBase58 = keypair.publicKey.toBase58();
    const privateKeyBase58 = bs58.encode(keypair.secretKey);

    console.log("Keypair from provided Private Key:");
    console.log(`{
        "publicKey": "\x1b[96m${publicKeyBase58}\x1b[0m",
        "privateKey": "\x1b[96m${privateKeyBase58}\x1b[0m",
        "secretKey": "\x1b[96m[${Array.from(keypair.secretKey).join(", ")}]\x1b[0m"
      }`);

    const { confirmSave } = await inquirer.prompt([
      {
        type: "list",
        name: "confirmSave",
        message: "Do you want to save the keypair to a file?",
        choices: [
          { name: "Yes, save the keypair", value: true },
          { name: "No, do not save", value: false },
        ],
      },
    ]);

    if (confirmSave) {
      const { filename } = await inquirer.prompt([
        {
          type: "input",
          name: "filename",
          message: "Enter filename for the keypair:",
          default: "keypair.json",
        },
      ]);

      const filePath = path.join(process.cwd(), filename);
      fs.writeFileSync(
        filePath,
        JSON.stringify(Array.from(keypair.secretKey), null, 2),
      );
      console.log(`Keypair saved to ${filePath}`);
    }
  } catch (error) {
    console.error("Failed to convert Private Key to Keypair:", error.message);
  }
}

main();
