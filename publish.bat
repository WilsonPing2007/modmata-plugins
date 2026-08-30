@echo off
chcp 65001 >nul
title ModMata 插件商店 - 一键发布
cd /d "%~dp0"

echo ============================================
echo    ModMata 插件商店 ^| 一键发布
echo ============================================
echo.
echo   [步骤 1] 把你的插件 .json 文件放进 plugins\ 文件夹
echo    （文件名 = 插件 id，如 my-plugin.json）
echo    （要更新插件？直接覆盖同名文件即可）
echo.
pause

where node >nul 2>nul || (echo [错误] 找不到 Node.js，请先安装 & pause & exit /b 1)
where git >nul 2>nul || (echo [错误] 找不到 Git & pause & exit /b 1)
set "GH_CMD=gh"
where gh >nul 2>nul || set "GH_CMD=C:\Program Files\GitHub CLI\gh.exe"
if not exist "%GH_CMD%" (echo [错误] 找不到 GitHub CLI ^(gh.exe^) & pause & exit /b 1)

echo.
echo [1/3] 生成插件索引（index.json）...
node scripts\build-index.cjs
if errorlevel 1 (echo [错误] 索引生成失败 & pause & exit /b 1)

echo.
echo [2/3] 提交到仓库...
set /p COMMIT_MSG=发布说明（直接回车用默认）: 
if "%COMMIT_MSG%"=="" set "COMMIT_MSG=update: 插件更新"
git add -A
git commit -m "%COMMIT_MSG%" >nul 2>nul
if errorlevel 1 (echo [提示] 没有新内容可发布（plugins\ 里没有变化） & pause & exit /b 1)

echo.
echo [3/3] 推送到 GitHub...
"%GH_CMD%" auth status >nul 2>nul
if errorlevel 1 (echo [错误] 未登录 GitHub，请先运行 gh auth login & pause & exit /b 1)
git -c credential.helper="!gh auth git-credential" push origin main
if errorlevel 1 (echo [错误] 推送失败，检查网络后重新双击本脚本 & pause & exit /b 1)

echo.
echo ============================================
echo   ✅ 发布成功！
echo   打开 ModMata → 设置 → 第三方插件 → 刷新
echo   就能看到新插件了（全世界可安装）
echo ============================================
pause
