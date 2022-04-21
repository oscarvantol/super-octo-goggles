$url = "https://go.microsoft.com/fwlink/?LinkId=287166"
$output = "$PSScriptRoot\WebPlatformInstaller_amd64_en-US.msi"
Invoke-WebRequest -Uri $url -OutFile $output
& "$PSScriptRoot\WebPlatformInstaller_amd64_en-US.msi" /qn /norestart
Install-WindowsFeature -name Web-Server -IncludeManagementTools

$count=0;
$maxTries = 20
do {
    If (-not (Test-Path 'C:\Program Files\Microsoft\Web Platform Installert')) {
        Write-Output '.'
        Start-Sleep -Seconds 5
        $count++
    } else {
        Write-Output $count
        $count = $maxTries
    }

} While ($count -lt $maxTries)

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
WebpiCmd.exe /Install /Products:'UrlRewrite2,ARRv3_0' /AcceptEULA /Log:WebpiCmd.log

Install-WindowsFeature NET-WCF-HTTP-Activation45
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication -NoRestart
