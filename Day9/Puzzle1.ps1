function Measure-Score 
{
    param(
        [string]$Path = 'input.txt'
    )

    $Stream = Get-Content $Path |Select -First 1

    $inGarbage = $false
    $totalScore = 0
    $depth = 1

    for($i = 0; $i -lt $Stream.Length; $i++){

        $char = $Stream[$i]

        if($char -eq '!' -or $inGarbage -and $char -ne '>'){
            $i += ($char -eq '!')
            continue
        }

        switch($char){
            '<' {
                $inGarbage = $true
            }
            '>' {
                $inGarbage = $false
            }
            '{' {
                $totalScore += $depth++
            }
            '}' {
                $depth--
            }
        }
    }

    return $totalScore
}
