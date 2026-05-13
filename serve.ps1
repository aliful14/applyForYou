# Minimal static file server for local preview (PowerShell 5.1+)
# Usage: .\serve.ps1              → tries ports 5500–5509
#        .\serve.ps1 -Port 8080   → use a specific port

param(
  [int]$Port = 0
)

$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

$portsToTry = if ($Port -gt 0) { @($Port) } else { 5500..5509 }
$listener = $null
$port = 0
foreach ($p in $portsToTry) {
  $tryListener = New-Object System.Net.HttpListener
  $tryListener.Prefixes.Add("http://127.0.0.1:$p/")
  $tryListener.Prefixes.Add("http://localhost:$p/")
  try {
    $tryListener.Start()
    $listener = $tryListener
    $port = $p
    break
  } catch {
    $tryListener.Close()
  }
}
if (-not $listener) {
  Write-Host "No free port found in range. Close other servers or run: .\serve.ps1 -Port 8080" -ForegroundColor Red
  exit 1
}

function Get-MimeType([string]$ext) {
  switch ($ext.ToLower()) {
    ".html" { "text/html; charset=utf-8" }
    ".css"  { "text/css; charset=utf-8" }
    ".js"   { "application/javascript; charset=utf-8" }
    ".svg"  { "image/svg+xml" }
    ".ico"  { "image/x-icon" }
    ".png"  { "image/png" }
    ".jpg"  { "image/jpeg" }
    ".jpeg" { "image/jpeg" }
    ".webp" { "image/webp" }
    ".txt"  { "text/plain; charset=utf-8" }
    ".xml"  { "application/xml" }
    default { "application/octet-stream" }
  }
}

Write-Host "ApplyForYou local preview" -ForegroundColor Cyan
Write-Host "Serving: $root" -ForegroundColor Gray
Write-Host "Open:    http://localhost:$port/" -ForegroundColor Green
Write-Host "Press Ctrl+C to stop." -ForegroundColor Yellow

try {
  while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $req = $ctx.Request
    $res = $ctx.Response
    $path = [System.Uri]::UnescapeDataString($req.Url.AbsolutePath)
    if ($path -eq "/" -or $path -eq "") { $path = "/index.html" }
    $local = Join-Path $root ($path.TrimStart("/").Replace("/", [IO.Path]::DirectorySeparatorChar))
    # Prevent path traversal
    $fullRoot = (Resolve-Path $root).Path
    try {
      $fullLocal = (Resolve-Path -LiteralPath $local -ErrorAction Stop).Path
    } catch {
      $fullLocal = $null
    }
    if (-not $fullLocal -or -not $fullLocal.StartsWith($fullRoot, [StringComparison]::OrdinalIgnoreCase)) {
      $res.StatusCode = 403
      $buf = [Text.Encoding]::UTF8.GetBytes("Forbidden")
      $res.ContentLength64 = $buf.Length
      $res.OutputStream.Write($buf, 0, $buf.Length)
      $res.Close()
      continue
    }
    if (-not (Test-Path -LiteralPath $fullLocal -PathType Leaf)) {
      $res.StatusCode = 404
      $buf = [Text.Encoding]::UTF8.GetBytes("Not Found")
      $res.ContentLength64 = $buf.Length
      $res.OutputStream.Write($buf, 0, $buf.Length)
      $res.Close()
      continue
    }
    $ext = [IO.Path]::GetExtension($fullLocal)
    $res.ContentType = Get-MimeType $ext
    $bytes = [IO.File]::ReadAllBytes($fullLocal)
    $res.ContentLength64 = $bytes.Length
    $res.OutputStream.Write($bytes, 0, $bytes.Length)
    $res.Close()
  }
} finally {
  $listener.Stop()
  $listener.Close()
}
