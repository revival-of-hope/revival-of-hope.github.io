[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$contentDir = "content/post"
$imagesSourceDir = "images"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

# 1. 预构建图片全局索引（解决路径偏移问题）
Write-Host "Building image library index..." -ForegroundColor Cyan
if (-not (Test-Path $imagesSourceDir)) {
    Write-Error "Source images directory not found!"; exit
}
$imageLibrary = Get-ChildItem -Path $imagesSourceDir -File -Recurse

# 2. 获取所有待处理的 .md 文件
$mdFiles = Get-ChildItem -Path $contentDir -Filter "*.md" -Recurse | Where-Object { 
    $_.Name -ne "index.md" -and $_.Name -ne "_index.md" 
}

foreach ($file in $mdFiles) {
    Write-Host "`nProcessing: $($file.Name)" -ForegroundColor Cyan
    
    # 3. 创建 Page Bundle 文件夹
    $folderName = $file.BaseName
    $targetDir = Join-Path $file.DirectoryName $folderName
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir | Out-Null
    }

    # 4. 预读取内容并重命名/移动 MD 文件
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $newMdPath = Join-Path $targetDir "index.md"
    
    # 5. 图片处理逻辑
    $hasChanged = $false
    # 匹配各类 images/ 路径变体
    $pattern = '(?:"|(?<=\())(?:(?:\.\./)+|\./)?images/([^")\r\n\s]+)(?:"|\))'
    $matches = [regex]::Matches($content, $pattern)
    
    foreach ($match in $matches) {
        $extractedPath = $match.Groups[1].Value.Trim()
        $fileName = Split-Path $extractedPath -Leaf
        
        # 忽略变量占位符
        if ($fileName -like "*$*") { continue }

        # 搜索图片：先查直接路径，找不到再查全局索引
        $sourceFile = Join-Path (Get-Location) (Join-Path $imagesSourceDir $extractedPath)
        if (-not (Test-Path -LiteralPath $sourceFile)) {
            $foundFile = $imageLibrary | Where-Object { $_.Name -eq $fileName } | Select-Object -First 1
            if ($foundFile) { $sourceFile = $foundFile.FullName }
        }

        if (Test-Path -LiteralPath $sourceFile) {
            $destFile = Join-Path $targetDir $fileName
            
            # 移动图片到新文件夹
            if (Test-Path -LiteralPath $sourceFile) {
                Move-Item -LiteralPath $sourceFile -Destination $destFile -Force
            }
            
            # 修正 Markdown 引用路径为纯文件名
            $oldFullString = $match.Value
            $newFullString = $oldFullString.Substring(0,1) + $fileName + $oldFullString.Substring($oldFullString.Length - 1)
            $content = $content.Replace($oldFullString, $newFullString)
            $hasChanged = $true
            Write-Host "  [Image] Moved & Relinked: $fileName" -ForegroundColor Green
        } else {
            Write-Warning "  [Image] Missing: $fileName"
        }
    }

    # 6. 写入新 index.md 并物理删除旧 .md
    [System.IO.File]::WriteAllText($newMdPath, $content, $utf8NoBom)
    Remove-Item -Path $file.FullName -Force
    Write-Host "  [Bundle] Created folder and index.md" -ForegroundColor Gray
}

Write-Host "`nAll operations completed." -ForegroundColor Yellow