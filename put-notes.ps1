# default mouse cursor's location
$x = 360
$y = 360
$xGap = 65
$yGap = 72
$interval = 50

# click L
function click-L {
    $SendMouseClick::mouse_event(0x0002, 0, 0, 0, 0);
    $SendMouseClick::mouse_event(0x0004, 0, 0, 0, 0);
    Start-Sleep -m $interval
}

# move the cursor
function move-mouse ($mx, $my) {
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($mx, $my)
    Start-Sleep -m $interval
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
Start-Sleep -m 50

for ($i=0; $i -lt 20; $i++){
    if ($i -ge 15) {
        $mx = 
        Write-Host "1です"
        move-mouse $x+($i * $xGap) $y+()
    } elseif ($i -eq 2){
        Write-Host "2です"
    } elseif ($i -eq 3){
        Write-Host "3です"
    } else {
        Write-Host "その他です"
    }
}