function Measure-Steps 
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
        $offsets[$prepos]++
        $total++
    } while($pos -ge 0 -and $pos -lt $offsets.Count)

    return $total
}
