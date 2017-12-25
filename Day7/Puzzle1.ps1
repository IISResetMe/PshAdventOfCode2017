function Get-BottomProgram 
{
    param(
        [string]$Path = 'input.txt'
    )

    $Lines = Get-Content $Path

    $SubsSeen = @{}
    $Bases = @{}

    $Lines |ForEach-Object {
        $base,$subs = $_ -split ' -> '
        if($subs -and $subs.Trim()){
            $subs.Trim() -split ', ' |%{
                $SubsSeen[$_] = $true
            }
        }

        $Bases[($base -split ' ')[0]] = $true
    }

    $Bases.Keys |? {$_ -notin $SubsSeen.Keys}
}
