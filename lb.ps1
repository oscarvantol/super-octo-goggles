Install-WindowsFeature -name Web-Server -IncludeManagementTools
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

$arrUrl = "https://download.microsoft.com/download/E/9/8/E9849D6A-020E-47E4-9FD0-A023E99B54EB/requestRouter_amd64.msi"
$arrFile = "$PSScriptRoot\requestRouter_amd64.msi" 
Invoke-WebRequest -Uri $arrUrl -OutFile $arrFile
& $arrFile /qn | Out-Host
