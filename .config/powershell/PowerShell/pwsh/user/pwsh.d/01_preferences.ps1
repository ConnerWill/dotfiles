<# 
The following table lists the preference variables and their default
values.

  Variable                         Default Value
  -------------------------------- ----------------------------------------------------------------
  $ConfirmPreference               High
  $DebugPreference                 SilentlyContinue
  $ErrorActionPreference           Continue
  $ErrorView                       ConciseView
  $FormatEnumerationLimit          4
  $InformationPreference           SilentlyContinue
  $LogCommandHealthEvent           $False (not logged)
  $LogCommandLifecycleEvent        $False (not logged)
  $LogEngineHealthEvent            $True (logged)
  $LogEngineLifecycleEvent         $True (logged)
  $LogProviderLifecycleEvent       $True (logged)
  $LogProviderHealthEvent          $True (logged)
  $MaximumHistoryCount             4096
  $OFS                             Space character (" ")
  $OutputEncoding                  UTF8Encoding object
  $ProgressPreference              Continue
  $PSDefaultParameterValues        @{} (empty hash table)
  $PSEmailServer                   $Null (none)
  $PSModuleAutoLoadingPreference   All
  $PSSessionApplicationName        'wsman'
  $PSSessionConfigurationName      'http://schemas.microsoft.com/powershell/Microsoft.PowerShell'
  $PSSessionOption                 PSSessionOption object
  $Transcript                      $Null (none)
  $VerbosePreference               SilentlyContinue
  $WarningPreference               Continue
  $WhatIfPreference                $False
 #>

# $PwSH_Custom_Preference_HashTable = @{     
#     $ConfirmPreference             = High
#     $DebugPreference               = SilentlyContinue
#     $ErrorActionPreference         = Continue
#     $ErrorView                     = ConciseView
#     $FormatEnumerationLimit        = 4
#     $InformationPreference         = SilentlyContinue
#     $LogCommandHealthEvent         = $False
#     $LogCommandLifecycleEvent      = $False
#     $LogEngineHealthEvent          = $True
#     $LogEngineLifecycleEvent       = $True
#     $LogProviderLifecycleEvent     = $True
#     $LogProviderHealthEvent        = $True
#     $MaximumHistoryCount           = 8192
#     $OFS                           = " "
#     $OutputEncoding                = UTF8Encoding object
#     $ProgressPreference            = Continue
#     $PSDefaultParameterValues      = @{}
#     $PSEmailServer                 = $Null
#     $PSModuleAutoLoadingPreference = All
#     $PSSessionApplicationName      = 'wsman'
#     $PSSessionConfigurationName    = 'http://schemas.microsoft.com/powershell/Microsoft.PowerShell'
#     $PSSessionOption               = PSSessionOption object
#     $Transcript                    = $Null
#     $VerbosePreference             = SilentlyContinue
#     $WarningPreference             = Continue
#     $WhatIfPreference              = $False
#  }

#${env:*}




 function Write-to-BRUH {
  <#
  .SYNOPSIS
      Writes customized output to a host.
  .DESCRIPTION
      The Write-Host cmdlet customizes output. You can specify the color of text by using
      the ForegroundColor parameter, and you can specify the background color by using the
      BackgroundColor parameter. The Separator parameter lets you specify a string to use to
      separate displayed objects. The particular result depends on the program that is
      hosting Windows PowerShell.
  #>
  [CmdletBinding()]
  param(
      [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromRemainingArguments = $true)]
      [psobject]$Object,

      [switch]$NoNewline,

      [psobject]$Separator,

      [System.ConsoleColor]$ForegroundColor,

      [System.ConsoleColor]$BackgroundColor
  )
  begin {
  #  Write-Output $Object 
    $ObjectStr = $Object.ToString()
    Write-Host "BRUH:    $ObjectStr"  -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor -NoNewline $NoNewline
  }
 }


# if ($host.Name -eq 'ConsoleHost'){
#     $ModulesArray = @(`
#                        "get-childitemcolor",   # Get-ChildItemColor
#                        "PSReadLine",           # PSReadLine
#                        "$_PWSH_LOAD_DIR\modules\modules-available\PSReadLineViVisualMode\src\PSReadLineViVisualMode",  # PSReadLineViVisualMode
#                        "Plaster",              # Plaster
#                        "posh-git",
#                        "Plaster"
#                     )
#     foreach ($LoadModule in $ModulesArray){
#         #Import-Module -Name $LoadModule -Verbose
#         Write-Output "`e[0;1;38;5;93mLoading: `e[0;1;38;5;43m$LoadModule`e[0m"
#     }
# }