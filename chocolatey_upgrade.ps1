# Ensure Chocolatey is available in the execution policy
Set-ExecutionPolicy Bypass -Scope Process -Force

# Check if Chocolatey is installed
if (!(Test-Path "$env:ProgramData\Chocolatey")) {
    Write-Warning "Chocolatey is not installed. Please install Chocolatey before running this script."
    exit 1
}

# Get a list of outdated packages
$outdatedPackages = choco outdated -r

# Check if there are any outdated packages
if ($outdatedPackages.Count -eq 0) {
    Write-Host "No outdated packages found."
    exit 0
}

# Update the outdated packages
Write-Host "Updating outdated packages:"

foreach ($package in $outdatedPackages) {
    Write-Host "Updating $package.Id"
    choco upgrade $package.Id -y
}
