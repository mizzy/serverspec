function CropText
{
  param($text, $fromPattern, $toPattern)
  
  $from, $to = ([regex]::matches($text, $fromPattern)), ([regex]::matches($text, $toPattern))
  if ($from.count -gt 0 -and $to.count -gt 0) {
    $text.substring($from[0].index, $to[0].index + $to[0].length - $from[0].index)
  } else {
    ""
  }
}
