# default mouse cursor's location
$x = 360
$y = 720
$xGap = 10
$yGap = 36
$interval = 10 # msec

# click L
function click-L ($ms) {
    $SendMouseClick::mouse_event(0x0002, 0, 0, 0, 0);
    $SendMouseClick::mouse_event(0x0004, 0, 0, 0, 0);
    Start-Sleep -m $ms
}

# move the cursor
function move-mouse ($mx, $my, $ms) {
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($mx, $my)
    Start-Sleep -m $ms
}

function vardump ($x, $y) {
    write-host $x X
    write-host $y Y
}

# declare .NET Framework
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

# declare Windows API
$signature=@'
[DllImport("user32.dll",CharSet=CharSet.Auto,CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
$SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru

# back to the previous window
# ALT + TAB (move to the previous window)
[System.Windows.Forms.SendKeys]::SendWait("%{TAB}")
Start-Sleep -m 3000

for ($i=0; $i -le 120; $i++){
    $x2 = $i * $xGap + $x
    $y2 = Get-Random -Maximum 800 -Minimum 360
    # if ($i -ge 15) { $y2 = $y + $yi }
    # if (($i -ge 5) -And ($i -le 10)) { $y2 = $y + $yi }
    move-mouse $x2 $y2 $interval
    click-L $interval
    vardump $x2 $y2 $interval
}

Start-Sleep -m 300
[System.Windows.Forms.SendKeys]::SendWait(" ")

# -eq、 -ieq、 -ceq  ==
# -ne、 -ine、 -cne  !=
# -gt、 -igt、 -cgt  >
# -ge、 -ige、 -cge  >=
# -lt、 -ilt、 -clt  <
# -le、 -ile、 -cle  <=