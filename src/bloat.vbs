Set objShell = CreateObject("WScript.Shell")

If Not WScript.Arguments.Named.Exists("elevated") Then
    Set shell = CreateObject("Shell.Application")
    shell.ShellExecute "wscript.exe", Chr(34) & _
        WScript.ScriptFullName & Chr(34) & " /elevated", "", "runas", 1
    WScript.Quit
End If

intResponse = MsgBox("Do you want to bloat Windows again?" & vbCrLf & "If you regret it, you will need to debloat it back!", vbYesNo, "BloatWindows11")

If intResponse = vbYes Then
    objShell.Run "powershell.exe -w h -c 'Get-AppxPackage -allusers | foreach {Add-AppxPackage -register “$($_.InstallLocation)\appxmanifest.xml” -DisableDevelopmentMode}'"
    MsgBox("Now just wait, your apps will be back soon")
ElseIf intResponse = vbNo Then
    MsgBox("Canceled")
    Wscript.quit()
End If

Set objShell = Nothing
