function FindService
{
  param($name)
  Get-WmiObject Win32_Service | Where-Object {$_.serviceName -eq $name -or $_.displayName -eq $name}
}