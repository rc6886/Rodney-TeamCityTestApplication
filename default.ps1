$projectName = "Rodney-TeamCityTestApplication"
$configuration = 'Debug'
$basedir = resolve-path '.\'
$src = "$basedir\"
$publish_dir = "$basedir\Publish"
$sln = "$src\Rodney-TeamCityTestApplication.sln"

task default -depends Compile

task CommonAssemblyInfo {
    $version = (Get-Date).ToString("yyyy.MM.dd.HHmm")
    create-commonAssemblyInfo "$version" $projectName "$src\CommonAssemblyInfo.cs"
	$packageVersion = $version
}

task Compile -depends CommonAssemblyInfo {
    exec { msbuild /t:clean /v:q /nologo /p:Configuration=$configuration $sln }
    exec { msbuild /t:build /v:q /nologo /p:Configuration=$configuration $sln }
}

function global:create-commonAssemblyInfo($version,$applicationName,$filename) {
  write-host ("Version: " + $version) -ForegroundColor Green
  write-host ("Project Name: " + $projectName) -ForegroundColor Green

"using System;
using System.Reflection;
using System.Runtime.InteropServices;

//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Changes to this file may cause incorrect behaviour and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

[assembly: ComVisibleAttribute(false)]
[assembly: AssemblyVersionAttribute(""$version"")]
[assembly: AssemblyFileVersionAttribute(""$version"")]
[assembly: AssemblyCopyrightAttribute(""Copyright 2015"")]
[assembly: AssemblyProductAttribute(""$projectName"")]
[assembly: AssemblyCompanyAttribute("""")]
[assembly: AssemblyConfigurationAttribute(""release"")]
[assembly: AssemblyInformationalVersionAttribute(""$version"")]"  | out-file $filename -encoding "ASCII"    
}