@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
CHCP 1251
CLS

REM SETLOCAL ENABLEEXTENSIONS
REM SET KEY_NAME="HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Ultimaker B.V."
REM SET VALUE_NAME="Ultimaker Cura"

REM REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Ultimaker B.V." /f "Ultimaker Cura" /k

ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
ECHO ВНИМАНИЕ! СКРИПТ УДАЛИТ ИЛИ ЗАМЕНИТ ОСТАТКИ ОТ СТАРЫХ ВЕРСИЙ ИНТЕГРАЦИИ
ECHO ИЗ ПАПКИ %USERPROFILE%\APPDATA\ROAMING\CURA\%CURAVERSION%
ECHO ЕСЛИ ВЫ ВРУЧНУЮ ПРАВИЛИ КАКИЕ-ЛИБО ФАЙЛЫ, 
ECHO ТО СОХРАНИТЕ ИХ ПЕРЕД ТЕМ, КАК ПРОДОЛЖИТЬ.
PAUSE
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
ECHO ВЫБОР ВЕРСИИ ПРОГРАММЫ:
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
:CHOOSECURAVERSION
ECHO Выберите версию программы Cura, для которой требуется установить интеграцию:
ECHO Нажмите 3 для Cura 4.3 - 4.3.X
ECHO Нажмите 4 для Cura 4.4 - 4.4.X
ECHO Нажмите 5 для Cura 4.5 - 4.5.X
CHOICE /C 3450 /N /M "Нажмите 0 для того, чтобы прекратить"
IF ERRORLEVEL 1 SET CURAVERSION=4.3
IF ERRORLEVEL 2 SET CURAVERSION=4.4
IF ERRORLEVEL 3 SET CURAVERSION=4.5
IF ERRORLEVEL 4 GOTO ENDOFTHESCRIPT
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
ECHO Выбрана версия программы %CURAVERSION%
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
SET ROAMINGFOLDER=%USERPROFILE%\AppData\Roaming\cura\%CURAVERSION%
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
ECHO УДАЛЕНИЕ СТАРЫХ ФАЙЛОВ ИНТЕГРАЦИИ:
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
REM definitions
DEL /Q %ROAMINGFOLDER%\definitions\flyingbear_base.def.json
DEL /Q %ROAMINGFOLDER%\definitions\flyingbear_ghost4s.def.json
REM extruders
DEL /Q %ROAMINGFOLDER%\extruders\flyingbear_base_extruder_0.def.json
DEL /Q %ROAMINGFOLDER%\extruders\flyingbear_ghost4s_extruder_0.def.json
REM images
DEL /Q %ROAMINGFOLDER%\images\flying_bear.png
DEL /Q %ROAMINGFOLDER%\images\inverted.png
DEL /Q %ROAMINGFOLDER%\images\heated_bed.png
REM materials
RD /S /Q %ROAMINGFOLDER%\materials\FD_Plast
REM quality
RD /S /Q %ROAMINGFOLDER%\quality\flyingbear
REM variants
DEL /Q %ROAMINGFOLDER%\variants\flyingbear*
REM Local
RD /S /Q %USERPROFILE%\AppData\Local\cura
CLS

ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
ECHO КОПИРОВАНИЕ НОВЫХ ФАЙЛОВ
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
XCOPY /E /I /Y definitions %ROAMINGFOLDER%\definitions
XCOPY /E /I /Y extruders %ROAMINGFOLDER%\extruders
XCOPY /E /I /Y images %ROAMINGFOLDER%\images
XCOPY /E /I /Y materials %ROAMINGFOLDER%\materials
XCOPY /E /I /Y meshes %ROAMINGFOLDER%\meshes
IF NOT %CURAVERSION% == 4.5 (
    XCOPY /E /I /Y quality%CURAVERSION% %ROAMINGFOLDER%\quality
    XCOPY /E /I /Y variants%CURAVERSION% %ROAMINGFOLDER%\variants
) ELSE (
    XCOPY /E /I /Y quality %ROAMINGFOLDER%\quality
    XCOPY /E /I /Y variants %ROAMINGFOLDER%\variants
)

CLS
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
ECHO ИНТЕГРАЦИЯ ЗАВЕРШЕНА
ECHO ••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

PAUSE

:ENDOFTHESCRIPT
