class MemoryBalancer
{
    hidden [int[]]$Banks

    MemoryBalancer([int[]]$Banks){
        $this.Banks = $Banks
    }

    [string]GetLabel(){
        return $this.Banks -join "`t"
    }

    [void]Print(){
        $this.GetLabel() |Write-Host
    }

    [void]Cycle(){
        $idx = $this.GetStartIndex()
        $buffer = 0
        $buffer,$this.Banks[$idx] = $this.Banks[$idx],$buffer
        $buffer..1 |ForEach-Object {
            $this.Banks[(++$idx % $this.Banks.Count)]++
        }
    }

    [int]GetStartIndex(){
        return $this.Banks.IndexOf(@($this.Banks|sort -Descending)[0])
    }
}

function Measure-Repetition
{
    param(
        [string]$InputConfiguration
    )

    $Banks = $InputConfiguration -split '\s+' -as [int[]]

    $Balancer = [MemoryBalancer]::new($Banks)

    $ConfigurationCache = @{
    }

    $Cycles = 0

    do{
        $ConfigurationCache[$Balancer.GetLabel()] = $Cycles++
        $Balancer.Cycle()
    } until ($ConfigurationCache.Contains($Balancer.GetLabel()))
    #$ConfigurationCache
    return $Cycles - $ConfigurationCache[$Balancer.GetLabel()]
}

Measure-Repetition '0 2 7 0'
