Install-WindowsFeature -name Web-Server -IncludeManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45 -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionDynamic -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures -All
Enable-WindowsOptionalFeature -Online -FeatureName WCF-Services45 -All
Enable-WindowsOptionalFeature -Online -FeatureName WCF-HTTP-Activation45 -All
Enable-WindowsOptionalFeature -Online -FeatureName WCF-TCP-Activation45 -All
Enable-WindowsOptionalFeature -Online -FeatureName WCF-HTTP-Activation -All
Enable-WindowsOptionalFeature -Online -FeatureName WCF-NonHTTP-Activation -All
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication -All

$rwUrl = 'https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi'
Start-Process msiexec.exe -Wait -ArgumentList "/I $rwUrl /quiet"
 
#$dotnet6download = "https://download.visualstudio.microsoft.com/download/pr/0c2039d2-0072-43a8-bb20-766b9a91d001/0e2288a2f07743e63778416b2367bb88/dotnet-hosting-6.0.4-win.exe"
#$dotnet6file = "$PSScriptRoot\dotnet-hosting-6.0.4-win.exe"
#Invoke-WebRequest -Uri $dotnet6download -OutFile $dotnet6file
#& $dotnet6file /install /quiet /norestart | Out-Host

#$dnframworkdownload = "https://go.microsoft.com/fwlink/?LinkId=2085155"
#$dnframworkfile = "$PSScriptRoot\ndp48-web.exe"
#Invoke-WebRequest -Uri $dnframworkdownload -OutFile $dnframworkfile
#& $dnframworkfile /q | Out-Host

