@echo Executing psake build with default.ps1 configuration
@echo off
.\tools\NuGet\nuget.exe restore "Rodney-TeamCityTestApplication.sln" -source "https://nuget.org/api/v2/" -RequireConsent -o "packages"

powershell.exe -NoProfile -ExecutionPolicy unrestricted -Command "& {Import-Module '.\psake.psm1'; invoke-psake .\default.ps1 %1 -parameters @{"version"="'%2'"}; if ($lastexitcode -ne 0) {write-host "ERROR: $lastexitcode" -fore RED; exit $lastexitcode} }" 