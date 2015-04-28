param($installPath, $toolsPath, $package, $project)

Import-Module (Join-Path $toolsPath Utility.psd1)
if ($project.Type -eq 'Web Site') {
    $projectRoot = Get-ProjectRoot $project
    if (!$projectRoot) {
        return;
    }

    $binDirectory = Join-Path $projectRoot "bin\vlc"
    $libDirectory = Join-Path $installPath "lib\net40"
    $nativeBinDirectory = Join-Path $installPath "vlc"

    if (test-path $libDirectory -pathType container) {
        Remove-FilesFromVSFolder $libDirectory $binDirectory "*.dll"
    }
    Remove-FilesFromVSFolder $nativeBinDirectory $binDirectory "*"
}
elseif($project.ExtenderNames -contains "WebApplication") 
{
    $depAsm = Get-ChildProjectItem $Project "_bin_deployableAssemblies";
	if($depAsm) 
    {
        $nativeBinDirectory = Join-Path $installPath "vlc"
        Remove-ItemsFromProject $depAsm $nativeBinDirectory
        Remove-EmptyFolder $depAsm
    }
}
else {
    $buildStep = Get-XCopyBuildStep $installPath  "vlc"
    Remove-BuildStep $project "Post" $buildStep
}
Remove-Module Utility