Option Explicit
Dim objShell, fso, scriptDir

Set fso = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

Set objShell = CreateObject("Shell.Application")
objShell.ShellExecute "powershell.exe", _
    "-NoProfile -ExecutionPolicy Bypass -File """ & scriptDir & "\switch_network.ps1"" toggle", _
    "", "runas", 0
