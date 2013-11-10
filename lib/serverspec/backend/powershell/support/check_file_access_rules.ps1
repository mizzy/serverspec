function CheckFileAccessRules
{
  param($path, $identity, $rules)
  
  $accessRules = @((Get-Acl $path).access | Where-Object {$_.AccessControlType -eq 'Allow' -and $_.IdentityReference -eq $identity })
  $match = @($accessRules | Where-Object {($_.FileSystemRights.ToString().Split(',') | % {$_.trim()} | ? {$rules -contains $_}) -ne $null})
  $match.count -gt 0
}
