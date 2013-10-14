function FindService
{
  param($name)
  Get-WmiObject Win32_Service | Where-Object {$_.Name -eq $name -or $_.DisplayName -eq $name}
}