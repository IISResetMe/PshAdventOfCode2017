function Measure-Garbage
{
    param(
        [string]$Path = 'input.txt'
    )

    $Stream = Get-Content $Path |Select -First 1

    $inGarbage = $false
    $totalGarbage = 0

    for($i = 0; $i -lt $Stream.Length; $i++){

        $char = $Stream[$i]

        if($char -eq '!' -or $inGarbage -and $char -ne '>'){
            if($char -eq '!'){
                $i++
            } 
            else{
                $totalGarbage++
            }
            continue
        }

        switch($char){
            '<' {
                $inGarbage = $true
            }
            '>' {
                $inGarbage = $false
            }
        }
    }

    return $totalGarbage
}
