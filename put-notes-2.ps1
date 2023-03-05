# default mouse cursor's location
[int] $startX = 84
[int] $startY = 150
[int] $endX = 1898
[int] $endY = 670
# $scrollBarX = 22 # <- adjust endX
[int] $maxBar = 4
[int] $lines = 14 # 7 == 1 octave
[int] $fullLines = 24 # 12 == 1 octave
[int[]] $linesArray = @(0, 2, 4, 5, 7, 9, 11, 12, 14, 16, 17, 19, 21, 23)
[int] $shortestNote = 8 # 16 == 1/16, 8 == 1/8
[int] $longestNote = 2
[int] $notes = $maxBar * $shortestNote
# [int] $notes = 16
# $elevation = 410 # the height of the lowest note <- adjust endY
[int] $xGap = ($endX-$startX)/$notes
[int] $yGap = ($endY-$startY)/$fullLines
[int] $interval = 3 # msec

# click L
function click-L ($ms) {
    $blankProbability = Get-Random -Maximum 300 -Minimum 1 # if the num is less than 100, no note
    if ($blankProbability -gt 100) {
        $SendMouseClick::mouse_event(0x0002, 0, 0, 0, 0);
        $SendMouseClick::mouse_event(0x0004, 0, 0, 0, 0);
        Start-Sleep -m $ms
    }
}

# move the cursor
function move-mouse ($mx, $my, $ms) {
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($mx, $my)
    Start-Sleep -m $ms
}

function vardump ($x, $y) {
    write-host $x X
    write-host $y Y
    write-host $notes notes
    write-host $xGap xGap
    write-host $yGap yGap
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

for ($i=0; $i -le $notes; $i++){
    [int] $num = Get-Random -Maximum $lines -Minimum 1
    [int] $x2 = $i * $xGap + $startX
    # $y2 = $endY - ($yGap * $num)
    [int] $y2 = $endY - ($yGap * $linesArray[$num-1])
    # if ($i -ge 15) { $y2 = $y + $yi }
    # if (($i -ge 5) -And ($i -le 10)) { $y2 = $y + $yi }
    move-mouse $x2 $y2 $interval
    click-L $interval
    # vardump $x2 $y2 $interval
    Write-Host $num NUM
}

Start-Sleep -m 300
[System.Windows.Forms.SendKeys]::SendWait(" ")

# -eq、 -ieq、 -ceq  ==
# -ne、 -ine、 -cne  !=
# -gt、 -igt、 -cgt  >
# -ge、 -ige、 -cge  >=
# -lt、 -ilt、 -clt  <
# -le、 -ile、 -cle  <=