@echo off
chcp 65001 >nul
title Well Dweller - Restore Original Files
echo ===================================================
echo         Well Dweller - Restore Original Files
echo ===================================================
echo.

set /p GAMEDIR="Paste the game folder path then press Enter: "
set GAMEDIR=%GAMEDIR:"=%

if not exist "%GAMEDIR%\Arabic_Patch_Backup\data.win" (
    echo No backup was found in this folder.
    pause
    exit /b 1
)

copy /Y "%GAMEDIR%\Arabic_Patch_Backup\data.win" "%GAMEDIR%\data.win" >nul
copy /Y "%GAMEDIR%\Arabic_Patch_Backup\translations.ini" "%GAMEDIR%\translations.ini" >nul

echo.
echo Original files restored successfully.
pause