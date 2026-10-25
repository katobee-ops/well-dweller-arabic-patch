@echo off
chcp 65001 >nul
title Well Dweller - Arabic Patch Installer
echo ===================================================
echo         Well Dweller - Arabic Patch Installer
echo ===================================================
echo.

set /p GAMEDIR="Paste the game folder path (the one containing data.win) then press Enter: "
set GAMEDIR=%GAMEDIR:"=%

if not exist "%GAMEDIR%\data.win" (
    echo.
    echo ERROR: data.win was not found in that folder.
    pause
    exit /b 1
)

if not exist "%GAMEDIR%\translations.ini" (
    echo.
    echo ERROR: translations.ini was not found in that folder.
    pause
    exit /b 1
)

echo.
echo Backing up your original files...
if not exist "%GAMEDIR%\Arabic_Patch_Backup" mkdir "%GAMEDIR%\Arabic_Patch_Backup"
copy /Y "%GAMEDIR%\data.win" "%GAMEDIR%\Arabic_Patch_Backup\data.win" >nul
copy /Y "%GAMEDIR%\translations.ini" "%GAMEDIR%\Arabic_Patch_Backup\translations.ini" >nul

echo Applying Arabic patch to data.win (this may take a minute)...
"%~dp0xdelta3.exe" -d -s "%GAMEDIR%\data.win" "%~dp0data_patch.xdelta" "%GAMEDIR%\data_arabic_temp.win"
if errorlevel 1 (
    echo.
    echo ERROR: Failed to patch data.win.
    echo This usually means your game version is different from the one this patch was made for.
    echo Try: Steam ^> Properties ^> Installed Files ^> Verify integrity of game files
    del "%GAMEDIR%\data_arabic_temp.win" 2>nul
    pause
    exit /b 1
)

echo Applying Arabic patch to translations.ini ...
"%~dp0xdelta3.exe" -d -s "%GAMEDIR%\translations.ini" "%~dp0translations_patch.xdelta" "%GAMEDIR%\translations_arabic_temp.ini"
if errorlevel 1 (
    echo.
    echo ERROR: Failed to patch translations.ini.
    del "%GAMEDIR%\translations_arabic_temp.ini" 2>nul
    pause
    exit /b 1
)

move /Y "%GAMEDIR%\data_arabic_temp.win" "%GAMEDIR%\data.win" >nul
move /Y "%GAMEDIR%\translations_arabic_temp.ini" "%GAMEDIR%\translations.ini" >nul

echo.
echo ===================================================
echo Done! The Arabic patch is now applied. Enjoy the game!
echo Your original files are backed up in: %GAMEDIR%\Arabic_Patch_Backup
echo ===================================================
pause