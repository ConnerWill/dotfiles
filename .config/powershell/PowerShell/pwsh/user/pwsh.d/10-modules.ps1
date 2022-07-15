Function yays(){
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromRemainingArguments = $true, Mandatory = $true)]
        [string]$SearchQuery
    )
    If ($SearchQuery -eq $null){
        return 
    }
    else {
        Find-Module -Filter $SearchQuery `
        | Select-Object -Property Rank,Name,Description,Properties `
            | Format-Table -AutoSize -Wrap
    }
}



if ($host.Name -eq 'ConsoleHost'){
    $ModulesArray = @(`
                       "get-childitemcolor",   # Get-ChildItemColor
                       "PSReadLine",           # PSReadLine
                       "$_PWSH_LOAD_DIR\modules\modules-available\PSReadLineViVisualMode\src\PSReadLineViVisualMode",  # PSReadLineViVisualMode
                       "Plaster",              # Plaster
                       "posh-git",
                       "Plaster"
                    )
    foreach ($LoadModule in $ModulesArray){
        #Import-Module -Name $LoadModule -Verbose
        Write-Output "`e[0;1;38;5;93mLoading: `e[0;1;38;5;43m$LoadModule`e[0m"
    }
}