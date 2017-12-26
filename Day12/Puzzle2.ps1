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

$found = @()
$count = 0

foreach($edge in $Edges.Keys){
    if($found -notcontains "$edge"){
        $global:pipesVisited = @()
        $connectedPipes = Get-ReachablePipe -pipes $Edges -pipe "$edge"
        $count++
        $found = @($found;$connectedPipes) |Sort -Unique
    }
}

$count
