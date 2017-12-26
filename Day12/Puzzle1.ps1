$Edges = [ordered]@{}

$Lines = Get-Content .\input.txt |%{
    $r,$e = $_ -split ' <-> ' -split ', ' -as [int[]]
    $Edges["$r"] = $e
}

function Get-ReachablePipe {
    param(
        $pipes,
        $pipe
    )

    [array]$global:pipesVisited += $pipe

    foreach($edge in $pipes["$pipe"] |Where-Object {$global:pipesVisited -notcontains "$_"}) {
        $null = Get-ReachablePipe $pipes $edge
    }

    return @($global:pipesVisited |Sort -Unique)
}

@(Get-ReachablePipe -pipes $Edges -pipe 0).Count
