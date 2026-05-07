@echo off
chcp 65001 > nul
echo ============================================
echo  交易日誌 — 更新資料並匯出網站 JSON
echo ============================================
echo.

echo [1/2] 重算每日損益 XLSX ...
python rebuild_daily_pnl.py
if errorlevel 1 (
    echo.
    echo [錯誤] rebuild_daily_pnl.py 執行失敗，請檢查上方錯誤訊息。
    pause
    exit /b 1
)

echo.
echo [2/2] 匯出 docs\data.json ...
python export_json.py
if errorlevel 1 (
    echo.
    echo [錯誤] export_json.py 執行失敗，請檢查上方錯誤訊息。
    pause
    exit /b 1
)

echo.
echo ============================================
echo  完成！接下來執行 git push：
echo.
echo    git add docs/data.json
echo    git commit -m "update: %DATE%"
echo    git push
echo ============================================
pause
