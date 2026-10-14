@echo off

:: example: s.bat 4 2 3

if "%1" == "" (
    echo.
    echo Missing argument 1,2,3,4!
    echo.
    call :showHelp 
    exit /b 101

) else (

    if "%2" == "" (
        echo.
        echo Missing argument 2,3,4!
        echo.
        call :showHelp
        exit /b 101
    
    ) else (

        if "%3" == "" (
            echo.
            echo Missing argument 3,4!
            echo.
            call :showHelp
            exit /b 101
        ) else (

            if "%4" == "" (
                echo.
                echo Missing argument 4
                echo.
                call :showHelp
                exit /b 101
            )

        )

    )

)

goto :eof


:showHelp
echo Usage: script.bat ^<tabValue^> ^<sectNumA^> ^<sectNumB^> ^<serverAddr^>
echo.
echo        tabValue: Tab key value
echo        sectNumA: section number for the first command
echo        sectNumB: section number for the second command
echo        serverAddr: server address and port
echo.
exit /b 101