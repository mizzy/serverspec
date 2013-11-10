function IsPortListening
{
  param($portNumber, $protocol)
  $netstatOutput = netstat -an | Out-String
  $networkIPs = (Get-WmiObject Win32_NetworkAdapterConfiguration | ? {$_.IPEnabled}) | %{ $_.IPAddress[0] }
  foreach ($ipaddress in $networkIPs)
  {
    $matchExpression = ("$ipaddress" + ":" + $portNumber)
    if ($protocol) { $matchExpression = ($protocol.toUpper() + "\s+$matchExpression") }
    if ($netstatOutput -match $matchExpression) { return $true }
  }
  $false
}