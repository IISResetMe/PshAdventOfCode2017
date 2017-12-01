function Measure-AOCSequenceHalfway
{
    param(
        [string]$Sequence
    )

    $MatchingDigits = for($i = 0; $i -lt $Sequence.Length; $i++){
        if($Sequence[$i] -eq $Sequence[($i + ($Sequence.Length/2)) % $Sequence.Length]){
            "$($Sequence[$i])" -as [int]
        }
    }

    return ($MatchingDigits |Measure-Object -Sum).Sum
}
