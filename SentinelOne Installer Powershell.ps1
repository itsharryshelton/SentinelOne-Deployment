#This Script is tailored to specifically work with Datto RMM, the CurrentDIR variable is used to reference the uploaded file. This SHOULD work with the installer in the same directory. Or Change the $ExePath with the correct path or share path of the installer.
#This installer process is specifically for the .exe installer using site tokens to assign it, ensure you update to $Args variable with your site token otherwise it won't install correctly.
#This script uses checking of the specific agent exe to see if it's installed, you can adjust this as requeired, or just adjust it to C:\Program Files\SentinelOne instead of the full path.

$CurrentDIR = $PSScriptRoot
$ExePath = "$CurrentDIR\SentinelOneInstaller.exe"
$Args = "-t REPLACE-ME-WITH-SITE-TOKEN"
$InstallCheckPath = "C:\Program Files\SentinelOne\Sentinel Agent VERSION NUMBER\SentinelAgent.exe"

#Check if already installed
if (Test-Path $InstallCheckPath) {
    Write-Output "SentinelOne already installed."
    Exit 0
} else {
    Write-Output "Installing SentinelOne..."
    Start-Process $ExePath -ArgumentList $Args -Wait

    #Check after install to see if it was successful
    $maxRetries = 5
    $retryCount = 0
    $success = $false

    do {
        Start-Sleep -Seconds 3
        if (Test-Path $InstallCheckPath) {
            $success = $true
        } else {
            $retryCount++
        }
    } until ($success -or $retryCount -ge $maxRetries)

    if ($success) {
        Write-Output "Found: $InstallCheckPath"
        Write-Output "SentinelOne installation successful."
        Exit 0
    } else {
        Write-Output "Faild to Find: $InstallCheckPath after 5 attempts"
        Write-Output "SentinelOne installation failed or the expected file path is incorrect."
        Exit 1
    }
}
