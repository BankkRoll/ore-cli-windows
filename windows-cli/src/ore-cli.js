#!/usr/bin/env node
const inquirer = require("inquirer");
const { spawn } = require("child_process");
const path = require("path");

async function main() {
  try {
    const scriptsDirectory = path.join(__dirname, "../../");
    const scripts = [
      "StartCheckRewards.ps1",
      "StartMining.ps1",
      "StartClaiming.ps1",
    ];

    const answer = await inquirer.prompt([
      {
        type: "list",
        name: "selectedScript",
        message: "Choose a PowerShell script to run:",
        choices: scripts,
      },
    ]);

    const scriptPath = path.join(scriptsDirectory, answer.selectedScript);

    const ps = spawn(
      "powershell.exe",
      ["-NoProfile", "-ExecutionPolicy", "Bypass", "-File", scriptPath],
      {
        stdio: "inherit",
      },
    );

    ps.on("error", (err) => {
      throw err;
    });

    ps.on("exit", (code, signal) => {
      if (code) {
        console.error(`PowerShell script exited with code ${code}`);
      } else if (signal) {
        console.error(`PowerShell script was killed with signal ${signal}`);
      } else {
        console.log(`PowerShell script completed successfully.`);
      }
    });
  } catch (error) {
    console.error(
      "Failed to run ore-cli:",
      error instanceof Error ? error.message : error,
    );
  }
}

main();
