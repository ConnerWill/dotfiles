
function Show-ColorsANSI {
  $colors = [enum]::GetValues([System.ConsoleColor])
  Foreach ($bgcolor in $colors){
      Foreach ($fgcolor in $colors) { Write-Host "$fgcolor|"  -ForegroundColor $fgcolor -BackgroundColor $bgcolor -NoNewLine }
      Write-Host " on $bgcolor"
  }
}

function Show-ColorList( ) {
  $colors = [Enum]::GetValues( [ConsoleColor] )
  $max = ($colors | foreach { "$_ ".Length } | Measure-Object -Maximum).Maximum
  foreach( $color in $colors ) {
    Write-Host (" {0,2} {1,$max} " -f [int]$color,$color) -NoNewline
    Write-Host "$color" -Foreground $color
  }
}

Function New-ANSIBar {
  [cmdletbinding()]
  Param(
      [Parameter(Mandatory,HelpMessage= "Enter a range of 256 color values, e.g. (232..255)")]
      [ValidateNotNullOrEmpty()]
      [int[]]$Range,
      [Parameter(HelpMessage = "How many spaces do you want in the bar? This will increase the length of the bar.")]
      [int]$Spacing = 1
  )
  $esc = "$([char]0x1b)"
  $out = @()
  $blank = " "*$spacing
  $out += $range | ForEach-Object {
      "$esc[48;5;$($_)m$($blank)$esc[0m"
  }

  $out += $range | Sort-Object -Descending | ForEach-Object {
      "$esc[48;5;$($_)m$($blank)$esc[0m"
  }
  $out -join ""
}




