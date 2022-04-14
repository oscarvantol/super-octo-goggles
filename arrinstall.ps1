Install-WindowsFeature -name Web-Server -IncludeManagementTools
$url = "https://go.microsoft.com/fwlink/?LinkId=287166"
$output = "$PSScriptRoot\WebPlatformInstaller_amd64_en-US.msi"
Invoke-WebRequest -Uri $url -OutFile $output
& "$PSScriptRoot\WebPlatformInstaller_amd64_en-US.msi" /quiet
WebpiCmd.exe /Install /Products:'UrlRewrite2,ARRv3_0' /AcceptEULA /Log:WebpiCmd.log
