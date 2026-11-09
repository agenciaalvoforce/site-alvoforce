# Monta index.html a partir de _fonte.html, embutindo o simbolo, o logo e o favicon oficiais.
# Uso: powershell -File build.ps1
$aqui = $PSScriptRoot
$assets = Join-Path (Split-Path -Parent (Split-Path -Parent $aqui)) "PROPOSTAS AG\_tmp\assets"
$src = [IO.File]::ReadAllText((Join-Path $aqui "_fonte.html"))
$h2 = [IO.File]::ReadAllText((Join-Path $assets "h2.svg"))
$s2 = [IO.File]::ReadAllText((Join-Path $assets "s2.svg"))
$hd = [regex]::Matches($h2, ' d="([^"]+)"')
$sd = [regex]::Matches($s2, ' d="([^"]+)"')
$simb = $sd[0].Groups[1].Value
$fav = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 684.36 684.36"><rect width="684.36" height="684.36" rx="140" fill="#1E1E1C"/><g transform="translate(92 92) scale(.73) matrix(1 0 0 -1 1 683.3621)"><path fill="#C8A76B" d="' + $simb + '"/></g></svg>'
$favUri = "data:image/svg+xml;base64," + [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($fav))
$out = $src.Replace("@@SIMBOLO@@", $simb).Replace("@@LOGO_SIMB@@", $hd[0].Groups[1].Value).Replace("@@LOGO_PALAVRA@@", $hd[1].Groups[1].Value).Replace("@@FAVICON@@", $favUri)
[IO.File]::WriteAllText((Join-Path $aqui "index.html"), $out, (New-Object Text.UTF8Encoding($false)))
"ok " + $out.Length
