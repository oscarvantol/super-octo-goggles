Install-WindowsFeature -name Web-Server -IncludeManagementTools

$url = "https://go.microsoft.com/fwlink/?LinkId=287166"
$output = "$PSScriptRoot\WebPlatformInstaller_amd64_en-US.msi"
Invoke-WebRequest -Uri $url -OutFile $output
& "$PSScriptRoot\WebPlatformInstaller_amd64_en-US.msi" /qn /norestart -Out-Host

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
WebpiCmd.exe /Install /Products:'UrlRewrite2,ARRv3_0' /AcceptEULA /Log:WebpiCmd.log

Install-WindowsFeature NET-WCF-HTTP-Activation45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication

$dotnet6download = "https://download.visualstudio.microsoft.com/download/pr/0c2039d2-0072-43a8-bb20-766b9a91d001/0e2288a2f07743e63778416b2367bb88/dotnet-hosting-6.0.4-win.exe"
$dotnet6file = "$PSScriptRoot\dotnet-hosting-6.0.4-win.exe"
Invoke-WebRequest -Uri $dotnet6download -OutFile $dotnet6file
& $dotnet6file /install /quiet /norestart | Out-Host

$dnframworkdownload = "https://go.microsoft.com/fwlink/?LinkId=2085155"
$dnframworkfile = "$PSScriptRoot\ndp48-web.exe"
Invoke-WebRequest -Uri $dnframworkdownload -OutFile $dnframworkfile
& $dnframworkfile /q | Out-Host
