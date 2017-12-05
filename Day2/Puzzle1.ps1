function Measure-AOCCheckSum
{
    param(
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$Row
    )

    process {
        $Smallest,$Largest = (-split $Row -as [int[]] |Sort-Object)[0..-1]

        return $Largest - $Smallest
    }
}

$Rows = @'
5 1 9 5
7 5 3
2 4 6 8
'@ -split '\r?\n'

($Rows |Measure-AOCCheckSum |Measure-Object -Sum).Sum
