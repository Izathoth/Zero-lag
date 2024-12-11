@echo off
:: Certifique-se de executar este script como Administrador
echo ========================================
echo Otimização Completa do Windows
echo ========================================
echo.

:: 1. Limpando arquivos temporários
echo [1/9] Limpando arquivos temporários...
del /s /q "%TEMP%\*"
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i"
del /s /q "%SystemRoot%\Temp\*"
for /d %%i in ("%SystemRoot%\Temp\*") do rd /s /q "%%i"

:: 2. Limpando cache do Windows Update
echo [2/9] Limpando cache do Windows Update...
net stop wuauserv
del /s /q "%SystemRoot%\SoftwareDistribution\Download\*"
net start wuauserv

:: 3. Limpando cache do navegador (Edge, IE)
echo [3/9] Limpando cache do navegador (Edge e Internet Explorer)...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255

:: 4. Limpando a Lixeira
echo [4/9] Limpando a Lixeira...
rd /s /q "%SystemRoot%\$Recycle.Bin"

:: 5. Verificando integridade do sistema
echo [5/9] Verificando arquivos do sistema (sfc /scannow)...
sfc /scannow

:: 6. Verificando erros no disco
echo [6/9] Verificando erros no disco (chkdsk)...
echo Isso pode demorar. Aguarde...
chkdsk C: /f /r

:: 7. Desfragmentando o disco (se HDD)
echo [7/9] Desfragmentando o disco (se HDD)...
defrag C: /U /V

:: 8. Ajustando configurações de inicialização
echo [8/9] Desativando programas desnecessários na inicialização...
powershell -Command "& {Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Run | ForEach-Object {Remove-ItemProperty -Path $_.PSPath -Name $_.PSChildName -ErrorAction SilentlyContinue}}"
powershell -Command "& {Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Run | ForEach-Object {Remove-ItemProperty -Path $_.PSPath -Name $_.PSChildName -ErrorAction SilentlyContinue}}"

:: 9. Limpando cache de DNS
echo [9/9] Limpando cache de DNS...
ipconfig /flushdns

:: Finalizando
echo ========================================
echo Otimização concluída!
echo ========================================
pause