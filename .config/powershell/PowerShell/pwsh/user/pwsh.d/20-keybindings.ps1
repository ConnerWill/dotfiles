#using namespace System.Management.Automation
#using namespace System.Management.Automation.Language

Import-Module PSReadLine

If (!($_Define_PSReadLineEditMode)){$_Define_PSReadLineEditMode = "Windows"}
Write-Output "`e[0;1;38;5;93mPSReadLine Edit Mode : `e[0;1;38;5;48m$_Define_PSReadLineEditMode`e[0m"

Set-PSReadLineOption -EditMode $_Define_PSReadLineEditMode

function List-PwSHKeybindings(){
    Clear-Host
    Get-PSReadLineKeyHandler | Select-Object *
    Write-Output "`n`e[0;1;38;5;190mYou can also press the keybinding     : `e[0;1;38;5;201m'Alt+?' ('Alt+Shift+/')`e[0;1;38;5;190mthen press the keybinding you want to view.`e[0m`n"
}
Write-Output "`e[0;1;38;5;190mView keybindings by running command : `e[0;1;38;5;201m'List-PwSHKeybindings`e[0m"