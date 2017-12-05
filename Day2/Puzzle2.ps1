function Measure-AOCCheckSum
{
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$Row
    )

    process {
        $Values = -split $Row
        for($dividend = 0; $dividend -lt $Values.Count; $dividend++){
            for($divisor = 0; $divisor -lt $Values.Count;$divisor++){
                if($dividend -eq $divisor){
                    continue
                }
                Write-Verbose "$($Values[$dividend]) : $($Values[$divisor])"
                if(($Values[$dividend] % $Values[$divisor]) -eq 0){
                    return $Values[$dividend] / $Values[$divisor]
                }
            }
        }
    }
}

$Rows = @'
5 9 2 8
9 4 7 3
3 8 6 5
'@ -split '\r?\n' |ForEach-Object Trim

($Rows |Measure-AOCCheckSum |Measure-Object -Sum).Sum
