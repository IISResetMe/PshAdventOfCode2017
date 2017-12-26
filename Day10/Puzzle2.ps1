function Get-HashedList
{
    param(
        [byte[]]$Lengths,
        [byte[]]$List = 0..255 -as [byte[]],
        [int]$CurrentPosition = 0,
        [int]$SkipSize = 0
    )

    function Get-ReversedSequence 
    {
        param([byte[]]$Array,[int]$Start,[int]$Length)

        $indices = @($Start..($Start + $Length - 1)).ForEach({$_ % $Array.Count})
        $subsequence = $Array[$indices]
        [array]::Reverse($subsequence)

        for($i = 0; $i -lt $indices.Count; $i++){
            $Array[$indices[$i]] = $subsequence[$i]
        }

        return $Array
    }

    foreach($length in $Lengths){
        $list = Get-ReversedSequence $list -Start $currentPosition -Length $length
        $currentPosition += ($length + $skipSize++)
    }
    
    return @{
        List = $list
        CurrentPosition = $CurrentPosition
        SkipSize = $SkipSize
    }
}

function Get-HashString{
    param(
        [byte[]]$Lengths
    )

    $currentPosition = 0
    $skipSize = 0

    $Lengths = [byte[]]@($Lengths;17,31,73,47,23)

    $sparseHash = Get-HashedList -Lengths $Lengths 

    2..64 |% {
        $sparseHash = Get-HashedList -Lengths $Lengths @sparseHash
    }

    $denseHash = for($i = 0; $i -lt $sparseHash.List.Count; $i += 16){
        $b = $sparseHash.List[$i..($i+15)]
        $x = 0
        for($j = 0; $j -lt $b.Count; $j++){
            $x = $x -bxor $b[$j]
        }
        $x
    }

    ($denseHash.ForEach({'{0:X2}' -f $_})-join'').ToLower()
}

$Lengths = (Get-Content .\input.txt).ToCharArray() -as [int[]]
Get-HashString -Lengths $Lengths
