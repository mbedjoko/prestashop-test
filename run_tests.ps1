<#
 Lance la campagne Robot Framework et genere results/log.html et results/report.html.

 Exemples :
   .\run_tests.ps1                                  # toute la campagne (hors tests "a-valider")
   .\run_tests.ps1 -Include smoke                   # uniquement les tests de fumee
   .\run_tests.ps1 -Include securite -Headless      # tests de securite, sans fenetre
   .\run_tests.ps1 -Url http://localhost:8081       # autre URL de boutique
   .\run_tests.ps1 -AvecAValider                    # inclut les tests encore a valider
#>
param(
    [string]$Url = "http://localhost:8080",
    [string]$Include = "",
    [switch]$Headless,
    [switch]$AvecAValider
)

$robotArgs = @(
    "--outputdir", "results",
    "--variable", "URL:$Url",
    "--variable", "HEADLESS:$($Headless.IsPresent)"
)
if (-not $AvecAValider) { $robotArgs += @("--exclude", "a-valider") }
if ($Include -ne "")    { $robotArgs += @("--include", $Include) }
$robotArgs += "tests"

robot @robotArgs
