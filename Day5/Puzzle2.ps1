function Measure2-Steps 
{
    param(
        [string]$Path = 'input.txt'
    )

    $offsets = (Get-Content $Path) -as [int[]]

    $pos = 0
    $total = 0

    do{
        $prepos = $pos
        $pos += $offsets[$prepos]
        if($offsets[$prepos] -ge 3){
            $offsets[$prepos]--
        }
        else{
            $offsets[$prepos]++
        }
        $total++
    } while($pos -ge 0 -and $pos -lt $offsets.Count)

    return $total
}
