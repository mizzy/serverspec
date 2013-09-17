function FindUser
{
  param($userName, $domain)
  if ($domain -eq $null) {$selectionCriteria = " and LocalAccount = true"}
  else {$selectionCriteria = " and Domain = '$domain'"}

  Get-WmiObject Win32_UserAccount -filter "Name = '$userName' $selectionCriteria"
}
