<#
Run Streamlit weather dashboard helper

Usage:
# 1) Provide API key on the command line:
#    powershell -ExecutionPolicy Bypass -File .\run_app.ps1 -ApiKey "YOUR_KEY"
# 2) Or run interactively (script will prompt for API key if not set in env):
#    .\run_app.ps1
#
Options:
# -ApiKey <string>       : Set the OPENWEATHER_API_KEY for this session
# -ForceReinstall        : Reinstall dependencies from requirements.txt
#
# The script expects to live in the repository root (same folder as requirements.txt).
#
# Note: running the script will activate the venv for the duration of the script's process.
# To run Streamlit and keep the session interactive, the script launches Streamlit as a child process.
#>

param(
    [string]$ApiKey = $null,
    [switch]$ForceReinstall
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptDir

if (-not (Test-Path ".venv")) {
    Write-Host "Creating virtual environment .venv..."
    python -m venv .venv
}

Write-Host "Activating virtual environment..."
. .\.venv\Scripts\Activate.ps1

Write-Host "Installing requirements..."
pip install --upgrade pip
if ($ForceReinstall) {
    pip install --force-reinstall -r requirements.txt
} else {
    pip install -r requirements.txt
}

if ($ApiKey) {
    Write-Host "Using API key from parameter."
    $env:OPENWEATHER_API_KEY = $ApiKey
} elseif (-not $env:OPENWEATHER_API_KEY) {
    # Prompt for key (secure input)
    $secure = Read-Host "OpenWeather API key not found in environment. Enter API key (input hidden)" -AsSecureString
    if ($secure.Length -gt 0) {
        $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
        try {
            $plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
            $env:OPENWEATHER_API_KEY = $plain
        } finally {
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
        }
    } else {
        Write-Error "No API key provided. Exiting."
        exit 1
    }
} else {
    Write-Host "Using OPENWEATHER_API_KEY from environment."
}

Write-Host "Launching Streamlit app..."
streamlit run .\weather-dashboard\weather_dashboard.py
