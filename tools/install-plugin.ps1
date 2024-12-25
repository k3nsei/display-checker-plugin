#!/usr/bin/env pwsh

$dir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$plgPath = [System.IO.Path]::Combine($dir, 'DisplayCheckerPlugin.lplug4')
$dstDir = [System.IO.Path]::Combine($env:LOCALAPPDATA, 'Logi', 'LogiPluginService', 'Plugins', 'DisplayChecker')

try {
  if (-not (Test-Path -Path $dstDir)) {
    New-Item -ItemType Directory -Path $dstDir | Out-Null
  }

  if ((Get-ChildItem -Path $dstDir | Measure-Object).Count -gt 0) {
    Remove-Item -Recurse -Force -Path (Get-ChildItem -Path $dstDir).FullName
  }

  Add-Type -AssemblyName System.IO.Compression.FileSystem
  [System.IO.Compression.ZipFile]::ExtractToDirectory($plgPath, $dstDir)

  Write-Output "Plugin installation complete."
  Write-Output "The plugin has been installed to: $dstDir"
}
catch {
  Write-Error "Plugin installation failed: $_"
}
