function Measure-AOCSpiralManhattanDistance{
    param([int]$N)

    if($N -le 3){
        return $N - 1
    }

    $NearestRoot = [Math]::Ceiling([Math]::Sqrt($N))

    $Width = if($NearestRoot % 2 -ne 0){
        $NearestRoot
    }
    else{
        $NearestRoot + 1
    }
    $Gap = ($Width - 1) / 2;
    $Rev = $N - [Math]::Pow(($Width - 2),2)
    $Offset = $Rev % ($Width - 1)
    
    return $Gap + [Math]::Abs($Offset - $Gap)
}

#Should be 31
Measure-AOCSpiralManhattanDistance 1024

<#
# From https://www.reddit.com/r/adventofcode/comments/7h7ufl/2017_day_3_solutions/dqoxrb7/

const steps = n => {
    const root = Math.ceil(Math.sqrt(n));
    const curR = root % 2 !== 0 ? root : root + 1;
    const numR = (curR - 1) / 2;
    const cycle = n - ((curR - 2) ** 2);
    const innerOffset = cycle % (curR - 1);

    return numR + Math.abs(innerOffset - numR);
};

#>
