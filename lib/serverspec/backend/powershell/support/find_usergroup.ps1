function FindUserGroup
{
  param($userName, $groupName, $userDomain, $groupDomain)
  $user = FindUser -userName $userName -domain $userDomain
  $group = FindGroup -groupName $groupName -domain $groupDomain
  if ($user -and $group) {
    Get-WmiObject Win32_GroupUser -filter ("GroupComponent = 'Win32_Group.Domain=`"" + $group.domain + "`",Name=`"" + $group.name + "`"' and PartComponent = 'Win32_UserAccount.Domain=`"" + $user.domain + "`",Name=`"" + $user.name + "`"'")
  }
}