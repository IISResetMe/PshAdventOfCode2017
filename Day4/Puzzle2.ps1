function Test-Anagram
{
    param(
        [string]$InputObject,

        [string]$ReferenceObject
    )

    ($InputObject.Length -eq $ReferenceObject.Length) -and (-join($InputObject.ToCharArray()|sort) -eq -join($ReferenceObject.ToCharArray()|sort))
}

function Test-Passphrase
{
    param(
        [string]$Passphrase
    )

    $words = $Passphrase -split ' '
    for($i = 0; $i -lt ($words.Count - 1); $i++){
        for($j = ($i+1); $j -lt $words.Count; $j++){
            if(Test-Anagram $words[$i] $words[$j]){
                return $false
            }
        }
    }
    return $true
}
