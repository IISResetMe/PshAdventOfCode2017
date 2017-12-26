function Execute-Instructions
{
    param(
        [string]$Path = 'input.txt'
    )

    $Instructions = Get-Content $Path
    $Registers = @{}

    $Instructions |ForEach-Object {
        $m = $($_ |sls '^(?<reg>\w+) (?<ins>(in|de)c) (?<delta>\-?\d+) if (?<sub>\w+) (?<op>[<>!=]*) (?<test>\-?\d+)$').Matches[0]
        $eval = switch($m.Groups['op'].Value){
            '>' {
                {param($a,$b) $a -gt $b}
            }
            '<' {
                {param($a,$b) $a -lt $b}
            }
            '>=' {
                {param($a,$b) $a -ge $b}
            }
            '<=' {
                {param($a,$b) $a -le $b}
            }
            '==' {
                {param($a,$b) $a -eq $b}
            }
            '!=' {
                {param($a,$b) $a -ne $b}
            }
        }
        $a,$b = +$Registers[$m.Groups['sub'].Value],+$m.Groups['test'].Value
        if(&$eval -a $a -b $b){
            $delta = (@(1,-1)[$m.Groups['ins'].Value -eq 'dec'] * $m.Groups['delta'].Value)
            $Registers[$m.Groups['reg'].Value] += $delta

        }
    }

    return $Registers
}

(Execute-Instructions).GetEnumerator() |Sort Value |Select -Last 1
