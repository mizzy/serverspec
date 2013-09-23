function FindInstalledApplication
{
  param($appName, $appVersion)
  $selectionCriteria = "(Name like '$appName' or PackageName like '$appName') and InstallState = 5"
  if ($appVersion -ne $null) { $selectionCriteria += " and version = '$appVersion'"}
  Get-WmiObject Win32_Product -filter $selectionCriteria
}