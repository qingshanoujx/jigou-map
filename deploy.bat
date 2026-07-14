@echo off
chcp 65001 >nul
echo ========================================
echo  机构地图 - 一键更新并部署到 GitHub
echo ========================================
echo.

cd /d C:\Users\Administrator\.openclaw\workspace

echo [1/3] 生成最新地图...
python build_full_map.py
if %ERRORLEVEL% NEQ 0 (
    echo 地图生成失败！
    pause
    exit /b 1
)

echo.
echo [2/3] 复制到 GitHub Pages 目录...
copy /Y full_institution_map.html C:\Users\Administrator\jigou-gh-pages\index.html >nul
echo OK

echo.
echo [3/3] 推送到 GitHub...
cd /d C:\Users\Administrator\jigou-gh-pages
git add -A
git commit -m "地图更新 %date% %time%"
git push
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo  ✅ 部署成功！
    echo  预计 1-2 分钟后生效
    echo  https://qingshanoujx.github.io/jigou-map/
    echo ========================================
) else (
    echo 推送失败，请检查 GitHub token
)

echo.
pause
