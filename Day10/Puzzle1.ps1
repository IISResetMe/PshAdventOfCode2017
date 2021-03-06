function Get-HashedList
{
    param(
        [byte[]]$Lengths
    )

    $list = 0..255 -as [byte[]]
    $currentPosition = 0 
    $skipSize = 0

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
    
    return $list
}

$Lengths = (Get-Content input.txt) -split ',' -as [int[]]
$HashedList = Get-HashedList -Lengths $Lengths
$HashedList[0] * $HashedList[1]
