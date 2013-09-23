function CheckFileAccessRules
{
  param($path, $identity, $rules)
  
  $result = $false
  $accessRules = (Get-Acl $path).access | Where-Object {$_.AccessControlType -eq 'Allow' -and $_.IdentityReference -eq $identity }
  if ($accessRules) {
    $match = $accessRules.FileSystemRights.ToString() -Split (', ') | ?{$rules -contains $_}
    $result = $match -ne $null -or $match.length -gt 0
  }
  $result
}
