# For local testing, you can pass buildVersion.
# Example usage:
# ./test-example.ps1 -buildVersion 25.1.3
param (
    [string]$buildVersion = $Env:CodeCentralBuildVersion
)

$global:BUILD_VERSION = $buildVersion
$global:ERROR_CODE = 0
$global:FAILED_PROJECTS = @()

function Resolve-NpmVersion {
    param (
        [string]$packageName,
        [string]$version
    )

    # Check if the exact version exists on npm
    $null = npm view "$packageName@$version" version 2>&1
    if ($LASTEXITCODE -eq 0) {
        return $version
    }

    # Exact version not found — try the beta tag
    $betaVersion = "$version-beta"
    $null = npm view "$packageName@$betaVersion" version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Output "Version $version not found on npm, using $betaVersion"
        return $betaVersion
    }

    # Neither found — return original and let npm install surface the error
    return $version
}

function Update-PackageVersion {
    param (
        [string]$packageJsonPath,
        [string]$packageName,
        [string]$version
    )

    $packageJson = Get-Content -Path $packageJsonPath -Raw | ConvertFrom-Json

    if ($packageJson.dependencies.$packageName) {
        $packageJson.dependencies.$packageName = $version
        $packageJson | ConvertTo-Json -Depth 10 | Set-Content -Path $packageJsonPath
        Write-Output "Updated $packageName to $version"
    }
}

function Process-WebpackProject {
    param (
        [string]$folderName,
        [string[]]$devextremePackages,
        [string]$buildVersion
    )

    if (-not (Test-Path $folderName)) {
        Write-Output "Directory $folderName does not exist. Skipping..."
        return
    }

    Write-Output ""
    Write-Output "Processing folder: $folderName"
    Push-Location $folderName

    try {
        $packageJsonPath = "package.json"

        # Resolve the actual available version (falls back to -beta if stable not published yet)
        $resolvedVersion = Resolve-NpmVersion -packageName "devextreme" -version $buildVersion

        if (Test-Path $packageJsonPath) {
            Write-Output "Updating DevExtreme package versions to $resolvedVersion"
            foreach ($package in $devextremePackages) {
                Update-PackageVersion -packageJsonPath $packageJsonPath -packageName $package -version $resolvedVersion
            }
        }

        Write-Output "Removing node_modules and package-lock.json"
        Remove-Item -Recurse -Force node_modules -ErrorAction SilentlyContinue
        Remove-Item -Force package-lock.json -ErrorAction SilentlyContinue

        Write-Output "Running npm install"
        npm install --no-audit --no-fund
        if (-not $?) {
            throw "npm install failed in $folderName"
        }

        Write-Output "Running npm build"
        npm run build
        if (-not $?) {
            throw "npm build failed in $folderName"
        }

        Write-Output "Successfully processed $folderName"
    } catch {
        Write-Error "An error occurred: $_"
        $global:LASTEXITCODE = 1
        $global:ERROR_CODE = 1
        $global:FAILED_PROJECTS += $folderName
    } finally {
        Pop-Location
    }
}

function Process-AllProjects {
    param (
        [string]$buildVersion
    )

    Write-Output ""
    Write-Output "Starting build process"
    Write-Output "Build Version: $buildVersion"

    $projects = @(
        @{ Name = "webpack-jquery"; Packages = @("devextreme", "devextreme-dist") },
        @{ Name = "webpack-react"; Packages = @("devextreme", "devextreme-react") },
        @{ Name = "webpack-vue"; Packages = @("devextreme", "devextreme-vue") }
    )

    foreach ($project in $projects) {
        Process-WebpackProject -folderName $project.Name -devextremePackages $project.Packages -buildVersion $buildVersion
    }
}

Process-AllProjects -buildVersion $global:BUILD_VERSION

Write-Output ""
Write-Output "Finished testing version: $global:BUILD_VERSION. Error code: $global:ERROR_CODE"
if ($global:ERROR_CODE -ne 0 -and $global:FAILED_PROJECTS.Count -gt 0) {
    Write-Output "FAILED PROJECTS: $(($global:FAILED_PROJECTS -join ", "))"
}

exit $global:ERROR_CODE
