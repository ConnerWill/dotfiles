


<#   function PSConsoleHostReadLine{                        
    $inputFile = Join-Path $env:TEMP PSConsoleHostReadLine # This function launches Notepad and gets
    Set-Content $inputFile "PS > "                         # input from a text File that the user creates:
    notepad $inputFile | Out-Null                          # Notepad opens. Enter your command in it,
    $userInput = Get-Content $inputFile                    # Save the file, and then exit.
    $resultingCommand = $userInput.Replace("PS >", "")
    $resultingCommand
} #>








