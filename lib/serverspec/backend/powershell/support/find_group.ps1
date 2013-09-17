function FindGroup
{
  param($groupName, $domain)
  if ($domain -eq $null) {$selectionCriteria = " and LocalAccount = true"}
  else {$selectionCriteria = " and Domain = '$domain'"}

  Get-WmiObject Win32_Group -filter "Name = '$groupName' $selectionCriteria"
}