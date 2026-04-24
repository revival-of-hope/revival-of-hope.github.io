[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$contentDir = "content/post/archives"
$imagesSourceDir = "images"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

# 递归获取所有 index.md
$articles = Get-ChildItem -Path $contentDir -Filter "index.md" -Recurse

foreach ($article in $articles) {
    $content = [System.IO.File]::ReadAllText($article.FullName, [System.Text.Encoding]::UTF8)
    $lines = $content -split "`r?`n"
    $hasChanged = $false
    $newLines = @()

    foreach ($line in $lines) {
        # 匹配逻辑：检查行内是否包含 images/
        if ($line -like "*images/*") {
            # 提取路径：处理 image: 格式或 ![..](..) 格式
            # 找到 images/ 的起始位置
            $index = $line.IndexOf("images/")
            if ($index -ge 0) {
                # 截取从 images/ 开始到结尾的部分，尝试清理末尾的引号或右括号
                $rawPath = $line.Substring($index).TrimEnd('"', ')', ' ', "`r", "`n")
                
                # 物理图片在 images 文件夹下的相对路径
                $relativeImagePath = $rawPath.Replace("images/", "")
                $sourceFile = Join-Path (Get-Location) (Join-Path $imagesSourceDir $relativeImagePath)

                if (Test-Path $sourceFile) {
                    $destDir = $article.DirectoryName
                    $fileName = Split-Path $sourceFile -Leaf
                    $destFile = Join-Path $destDir $fileName

                    # 物理移动图片
                    Move-Item -Path $sourceFile -Destination $destFile -Force
                    
                    # 替换该行的路径部分：不管是 ../images/ 还是 images/，一律换成文件名
                    # 寻找路径起始点（考虑 ../）
                    $startOfPath = $line.LastIndexOf("../images/")
                    if ($startOfPath -lt 0) { $startOfPath = $line.LastIndexOf("images/") }
                    
                    # 构造新行
                    $lineBeforePath = $line.Substring(0, $startOfPath)
                    # 找到路径结束后的剩余部分 (如 ")")
                    $endOfPathIndex = $index + $rawPath.Length
                    $lineAfterPath = ""
                    if ($endOfPathIndex -lt $line.Length) {
                        $lineAfterPath = $line.Substring($endOfPathIndex)
                    }
                    
                    $line = $lineBeforePath + $fileName + $lineAfterPath
                    $hasChanged = $true
                    Write-Host "Processed: $fileName" -ForegroundColor Green
                }
            }
        }
        $newLines += $line
    }

    if ($hasChanged) {
        $newContent = [string]::Join("`r`n", $newLines)
        [System.IO.File]::WriteAllText($article.FullName, $newContent, $utf8NoBom)
    }
}

Write-Host "Done." -ForegroundColor Yellow