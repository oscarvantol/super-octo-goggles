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
Start-Process msiexec.exe -Wait -ArgumentList "/I $arrUrl /quiet"

$rwUrl = 'https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi'
Start-Process msiexec.exe -Wait -ArgumentList "/I $rwUrl /quiet"




param($BlueFarm, $GreenFarm, [String[]] $BlueHosts, [String[]] $GreenHosts)

$rwUrl = 'https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi'
Start-Process msiexec.exe -Wait -ArgumentList "/I $rwUrl /quiet"

$arrUrl = "https://download.microsoft.com/download/E/9/8/E9849D6A-020E-47E4-9FD0-A023E99B54EB/requestRouter_amd64.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/I $arrUrl /quiet"


cd $Env:windir'\system32\inetsrv'
.\appcmd.exe set config  -section:webFarms /+"[name='$BlueFarm']" /commit:apphost

foreach ($hostName in $BlueHosts) {
    .\appcmd.exe set config  -section:webFarms /+"[name='$BlueFarm'].[address='$hostName']" /commit:apphost
}


.\appcmd.exe set config  -section:webFarms /+"[name='$GreenFarm']" /commit:apphost

foreach ($hostName in $GreenHosts) {
.\appcmd.exe set config  -section:webFarms /+"[name='$GreenFarm'].[address='$hostName']" /commit:apphost
}


.\appcmd.exe set config  -section:system.webServer/rewrite/globalRules /+"[name='LiveSSL', patternSyntax='Wildcard',stopProcessing='True']" /commit:apphost
#.\appcmd.exe set config  -section:system.webServer/rewrite/globalRules /"[name='LiveSSL',patternSyntax='Wildcard',stopProcessing='True'].match.url:*"  /commit:apphost
#.\appcmd.exe set config  -section:system.webServer/rewrite/globalRules /[name='LiveSSL',patternSyntax='Wildcard',stopProcessing='True'].action.type:"Rewrite" /[name='LiveSSL',patternSyntax='Wildcard',stopProcessing='True'].action.url:"http://myServerFarm/{R:0}"  /commit:apphost
