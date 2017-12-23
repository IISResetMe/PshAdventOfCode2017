filter Test-Passphrase {
  if($_.Length -eq (($_ -split ' ' |sort -Unique) -join ' ').Length){
    $_
  }
}
