$ErrorActionPreference = "Stop"

function Invoke-QuartoTarget {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [string]$WorkingDirectory,

        [Parameter(Mandatory = $true)]
        [string]$InputFile,

        [Parameter(Mandatory = $true)]
        [string]$Format,

        [Parameter(Mandatory = $true)]
        [string]$ExpectedOutput
    )

    Write-Host ""
    Write-Host "==> $Name [$Format]"

    $outputPath = Join-Path $WorkingDirectory $ExpectedOutput
    if (Test-Path $outputPath) {
        Remove-Item $outputPath -Force
    }

    Push-Location $WorkingDirectory
    try {
        $stdoutFile = [System.IO.Path]::GetTempFileName()
        $stderrFile = [System.IO.Path]::GetTempFileName()
        try {
            $process = Start-Process `
                -FilePath "cmd.exe" `
                -ArgumentList "/c", "quarto render $InputFile --to $Format" `
                -NoNewWindow `
                -Wait `
                -PassThru `
                -RedirectStandardOutput $stdoutFile `
                -RedirectStandardError $stderrFile

            $exitCode = $process.ExitCode
            $captured = @()
            if (Test-Path $stdoutFile) {
                $captured += Get-Content $stdoutFile
            }
            if (Test-Path $stderrFile) {
                $captured += Get-Content $stderrFile
            }
        }
        finally {
            if (Test-Path $stdoutFile) {
                Remove-Item $stdoutFile -Force
            }
            if (Test-Path $stderrFile) {
                Remove-Item $stderrFile -Force
            }
        }
    }
    finally {
        Pop-Location
    }

    $captured | ForEach-Object { Write-Host $_ }

    if (Test-Path $outputPath) {
        if ($exitCode -ne 0) {
            Write-Warning "Quarto exited with code $exitCode, but '$ExpectedOutput' was created. Treating this build as successful."
        }
        else {
            Write-Host "OK: $ExpectedOutput"
        }

        return @{
            Name = $Name
            Format = $Format
            Output = $outputPath
            Success = $true
        }
    }

    throw "Build '$Name' in format '$Format' did not create '$ExpectedOutput'."
}

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$results = @()

$results += Invoke-QuartoTarget `
    -Name "report" `
    -WorkingDirectory (Join-Path $root "report") `
    -InputFile "report.qmd" `
    -Format "pdf" `
    -ExpectedOutput "report.pdf"

$results += Invoke-QuartoTarget `
    -Name "report" `
    -WorkingDirectory (Join-Path $root "report") `
    -InputFile "report.qmd" `
    -Format "docx" `
    -ExpectedOutput "report.docx"

$results += Invoke-QuartoTarget `
    -Name "presentation" `
    -WorkingDirectory (Join-Path $root "presentation") `
    -InputFile "presentation.qmd" `
    -Format "revealjs" `
    -ExpectedOutput "presentation.html"

$results += Invoke-QuartoTarget `
    -Name "presentation" `
    -WorkingDirectory (Join-Path $root "presentation") `
    -InputFile "presentation.qmd" `
    -Format "beamer" `
    -ExpectedOutput "presentation.pdf"

Write-Host ""
Write-Host "Build completed:"
$results | ForEach-Object {
    Write-Host (" - {0} [{1}] -> {2}" -f $_.Name, $_.Format, $_.Output)
}
