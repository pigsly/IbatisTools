@echo *********************************
@echo *Sample command for BO:         *
@echo *********************************
@echo *OneBook                        *
@echo *OneBook2ManyPage               *
@echo *********************************
@echo *Sample command for DAO         *
@echo *********************************
@echo *selectforBookListByYahoo       *
@echo *selectforBookObjectByYahoo     *
@echo *selectforBookObjectBySelective *
@echo *selectforBookListBySelective   *
@echo *********************************
@set /P input=Please enter Statement:
@echo %input%
genBoCode.bat -m %input% 
rem 
clear;
pause;

