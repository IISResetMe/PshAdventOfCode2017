(Get-Content .\input.txt |%{
    $Depth,$Range = $_ -split ': ' -as [int[]]
    $Roundtrip = ($Range * 2) - 2
    if($Depth % $Roundtrip -eq 0){
        $Depth * $Range
    }
} |measure -Sum).Sum
