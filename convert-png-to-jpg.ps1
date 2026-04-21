# Convert large PNG files to optimized JPG
Add-Type -AssemblyName System.Drawing

$pngImages = @(
    "step1.png",
    "step2.png",
    "step3.png",
    "step4.png",
    "step5.png",
    "step6.png"
)

$imagesDir = ".\images"

Write-Host "`nConverting large PNG files to optimized JPG..." -ForegroundColor Green

$totalOriginal = 0
$totalCompressed = 0

foreach ($pngFile in $pngImages) {
    $pngPath = Join-Path $imagesDir $pngFile
    $jpgFile = $pngFile -replace '\.png$', '.jpg'
    $jpgPath = Join-Path $imagesDir $jpgFile
    
    if (Test-Path $pngPath) {
        $originalSize = (Get-Item $pngPath).Length
        $totalOriginal += $originalSize
        
        Write-Host "`nProcessing: $pngFile" -ForegroundColor Yellow
        Write-Host "  Original size: $([math]::Round($originalSize/1KB, 2)) KB ($([math]::Round($originalSize/1MB, 2)) MB)"
        
        try {
            # Load PNG image
            $image = [System.Drawing.Image]::FromFile($pngPath)
            
            # Create JPG encoder with quality 85
            $encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
            $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
            $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 85)
            
            # Save as JPG
            $image.Save($jpgPath, $encoder, $encoderParams)
            $image.Dispose()
            
            $newSize = (Get-Item $jpgPath).Length
            $totalCompressed += $newSize
            $reduction = [math]::Round((($originalSize - $newSize) / $originalSize) * 100, 1)
            
            Write-Host "  Converted to: $jpgFile" -ForegroundColor Green
            Write-Host "  New size: $([math]::Round($newSize/1KB, 2)) KB ($([math]::Round($newSize/1MB, 2)) MB)" -ForegroundColor Green
            Write-Host "  Reduction: $reduction%" -ForegroundColor Cyan
            Write-Host "  Space saved: $([math]::Round(($originalSize - $newSize)/1MB, 2)) MB" -ForegroundColor Magenta
        }
        catch {
            Write-Host "  Error: $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "`nNot found: $pngFile" -ForegroundColor Red
    }
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Conversion completed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Total original PNG size: $([math]::Round($totalOriginal/1MB, 2)) MB" -ForegroundColor Yellow
Write-Host "Total JPG size: $([math]::Round($totalCompressed/1MB, 2)) MB" -ForegroundColor Green
Write-Host "Total reduction: $([math]::Round((($totalOriginal - $totalCompressed) / $totalOriginal) * 100, 1))%" -ForegroundColor Cyan
Write-Host "Total space saved: $([math]::Round(($totalOriginal - $totalCompressed)/1MB, 2)) MB" -ForegroundColor Magenta
Write-Host "`nNext step: Update HTML files to use .jpg instead of .png for step images" -ForegroundColor Yellow
