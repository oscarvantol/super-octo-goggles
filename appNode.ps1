Install-WindowsFeature -name Web-Server -IncludeManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionDynamic
Enable-WindowsOptionalFeature -Online -FeatureName WCF-HTTP-Activation
Enable-WindowsOptionalFeature -Online -FeatureName WCF-NonHTTP-Activation
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication

 
$dotnet6download = "https://download.visualstudio.microsoft.com/download/pr/0c2039d2-0072-43a8-bb20-766b9a91d001/0e2288a2f07743e63778416b2367bb88/dotnet-hosting-6.0.4-win.exe"
$dotnet6file = "$PSScriptRoot\dotnet-hosting-6.0.4-win.exe"
Invoke-WebRequest -Uri $dotnet6download -OutFile $dotnet6file
& $dotnet6file /install /quiet /norestart | Out-Host

$dnframworkdownload = "https://go.microsoft.com/fwlink/?LinkId=2085155"
$dnframworkfile = "$PSScriptRoot\ndp48-web.exe"
Invoke-WebRequest -Uri $dnframworkdownload -OutFile $dnframworkfile
& $dnframworkfile /q | Out-Host

Install-WindowsFeature NET-WCF-HTTP-Activation45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
