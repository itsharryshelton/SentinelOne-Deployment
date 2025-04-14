# SentinelOne-Deployment
## SentinelOne Installer Deployment via Powershell through Datto RMM Specifically

This Script is tailored to specifically work with Datto RMM, the CurrentDIR variable is used to reference the uploaded file. This SHOULD work with the installer in the same directory. Or Change the $ExePath with the correct path or share path of the installer

This installer process is specifically for the .exe installer using site tokens to assign it, ensure you update to $Args variable with your site token otherwise it won't install correctly.

This script uses checking of the specific agent exe to see if it's installed, you can adjust this as requeired, or just adjust it to C:\Program Files\SentinelOne instead of the full path.
