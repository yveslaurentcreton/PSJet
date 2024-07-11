# PSJet - PowerShell Jet Tools

Welcome to PSJet, a collection of powerful and efficient PowerShell scripts to help streamline your workflow and automate tasks. PSJet is designed to provide a quick and easy solution for common administrative and development tasks, so you can focus on what really matters.

The scripts included in PSJet are designed to be fast, reliable, and easy to use. Whether you're a seasoned PowerShell user or just getting started, PSJet is the perfect tool to enhance your productivity.

With PSJet, you can perform a variety of tasks, including:

- Getting Windows information
- Automating repetitive tasks
- And much more!

## Getting Started

To get started with PSJet, simply install the module using the following command:

```powershell
Install-Module -Name PSJet -Force
```

While it is recommended to use PowerShell 7 or above for the best experience, PSJet can also be used with Windows PowerShell.

### Setup Script

To create an optimal environment for using PSJet, you can run the provided setup script. This script will upgrade PowerShellGet, install WinGet, Windows Terminal, and the latest version of PowerShell, ensuring you have a robust and enjoyable setup.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; irm "https://github.com/yveslaurentcreton/PSJet/releases/latest/download/psjet.ps1" | iex
```

## Contributions

PSJet is an open-source project and contributions are welcome! If you have a suggestion for a new script or an improvement to an existing one, please open an issue or submit a pull request.

## Support

If you need help using PSJet, please open an issue in the repository and we will be happy to assist you.

Thank you for using PSJet! We hope you find it as useful and efficient as we do.
