# Axial-to-cubic distance calculation courtesy of https://www.redblobgames.com/grids/hexagons/
function ConvertTo-Cube
{
    param($hex)

    $x = $hex.q
    $z = $hex.r
    $y = -$x-$z

    return [pscustomobject]@{
        x = $x
        y = $y
        z = $z
    }
}

function Get-CubeDistance
{
    param($a,$b)

    ([Math]::Abs($a.x - $b.x) + [Math]::Abs($a.y - $b.y) + [Math]::Abs($a.z - $b.z)) / 2
}

function Get-HexDistance
{
    param($a, $b)

    $ac = ConvertTo-Cube $a
    $bc = ConvertTo-Cube $b

    return Get-CubeDistance $ac $bc
}

function Go
{
    param($direction,$hex)

    switch($direction){
        'n' {
            $hex.r--
        }
        'ne' {
            $hex.q++
            $hex.r--
        }
        'se' {
            $hex.q++
        }
        's' {
            $hex.r++
        }
        'sw' {
            $hex.q--
            $hex.r++
        }
        'nw' {
            $hex.q--
        }
    }

    return $hex
}

$Start,$Cursor = 1..2 |% {
    [pscustomobject]@{
        q = 0
        r = 0
    }
}

Get-Content .\input.txt -Delimiter ',' |ForEach-Object Trim ',' |ForEach-Object {
    $Cursor = Go $_ -hex $Cursor
}

Get-HexDistance -a $Start -b $Cursor
