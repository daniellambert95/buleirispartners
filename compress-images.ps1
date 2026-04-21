# Image compression script
Add-Type -AssemblyName System.Drawing

$images = @(
    "logo.png",
    "Building photo.webp",
    "step1.png",
    "step2.png",
    "step3.png",
    "step4.png",
    "step5.png",
    "step6.png",
    "demo-finance-form-bg.jpg",
    "demo-finance-slider-01.jpg",
    "demo-finance-slider-02.jpg",
    "demo-finance-slider-03.jpg",
    "demo-finance-bg-01.jpg",
    "demo-finance-01.jpg",
    "demo-finance-02.jpg",
    "demo-finance-about-title-bg.jpg",
    "demo-finance-team-bg.jpg",
    "demo-finance-contact-bg.jpg"
)

$imagesDir = ".\images"
$backupDir = ".\images\original_backup_" + (Get-Date -Format "yyyyMMdd_HHmmss")

# Create backup directory
New-Item -ItemType Directory -Force -Path $backupDir | Out-Null

Write-Host "`nStarting image compression..." -ForegroundColor Green
Write-Host "Backup directory: $backupDir`n" -ForegroundColor Cyan

$totalOriginal = 0
$totalCompressed = 0

foreach ($img in $images) {
    $imagePath = Join-Path $imagesDir $img
    
    if (Test-Path $imagePath) {
        # Skip webp files
        if ($img -like "*.webp") {
            Write-Host "Skipping webp: $img (webp already compressed)`n" -ForegroundColor Yellow
            continue
        }
        
        $originalSize = (Get-Item $imagePath).Length
        $totalOriginal += $originalSize
        $backupPath = Join-Path $backupDir $img
        
        # Create backup
        Copy-Item $imagePath $backupPath -Force
        
        Write-Host "Processing: $img" -ForegroundColor Yellow
        Write-Host "  Original size: $([math]::Round($originalSize/1KB, 2)) KB ($([math]::Round($originalSize/1MB, 2)) MB)"
        
        # Compress image
        try {
            $image = [System.Drawing.Image]::FromFile($imagePath)
            
            # Determine encoder based on file type
            if ($img -like "*.png") {
                $encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/png' }
                $quality = 85
            }
            else {
                $encoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
                $quality = 80
            }
            
            $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
            $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, $quality)
            
            $tempPath = $imagePath + ".tmp"
            $image.Save($tempPath, $encoder, $encoderParams)
            $image.Dispose()
            
            # Replace original with compressed
            Remove-Item $imagePath -Force
            Move-Item $tempPath $imagePath -Force
            
            $newSize = (Get-Item $imagePath).Length
            $totalCompressed += $newSize
            $reduction = [math]::Round((($originalSize - $newSize) / $originalSize) * 100, 1)
            
            Write-Host "  Compressed size: $([math]::Round($newSize/1KB, 2)) KB ($([math]::Round($newSize/1MB, 2)) MB)" -ForegroundColor Green
            Write-Host "  Reduction: $reduction%`n" -ForegroundColor Cyan
        }
        catch {
            Write-Host "  Error: $_`n" -ForegroundColor Red
        }
    }
    else {
        Write-Host "Not found: $img`n" -ForegroundColor Red
    }
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Compression completed!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "Total original size: $([math]::Round($totalOriginal/1MB, 2)) MB" -ForegroundColor Yellow
Write-Host "Total compressed size: $([math]::Round($totalCompressed/1MB, 2)) MB" -ForegroundColor Green
Write-Host "Total reduction: $([math]::Round((($totalOriginal - $totalCompressed) / $totalOriginal) * 100, 1))%" -ForegroundColor Cyan
Write-Host "Space saved: $([math]::Round(($totalOriginal - $totalCompressed)/1MB, 2)) MB" -ForegroundColor Magenta
Write-Host "`nOriginal images backed up to: $backupDir" -ForegroundColor Cyan
