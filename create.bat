@echo off & cd /d %~dp0
mode con cols=120
chcp 65001>nul
echo +---------------------------------------------------------------------------------+
call :showLogo
echo This script will guide you through creating a flutter project with specified 
echo dependencies and file directories.
echo.
echo +---------------------------------------------------------------------------------+
rem Mark original path to access assets files for later use.
set scriptPath=%cd%

:inputProjectName
set /p projectName= Input project name:
if "%projectName%"=="" goto input
if "%projectName%"=="test" (
	call :error "'test' is not allowed as a project name, enter another name."
	goto inputProjectName
)

:inputProjecOrg
set /p projectOrg= Input project organization (such as com.example), or press Entry to use default:
if "%projectOrg%"=="" (
    set "projectOrg=com.example"
)

:inputProject
set /p v= Input project path(such as D:\FlutterWorkspace\Porjects), or press Entry to use default:
if not "%v%"=="" call :changeDir %v%
set projectPath=%cd%\%projectName%
echo [INFO] Project path is: %projectPath%

call :print "Start creating new flutter plugin project..."
echo flutter create --platforms=ios,android --org %projectOrg%  --pub %projectName%>temp.bat
call temp.bat
if errorlevel 1 (
	echo [INFO] Your flutter version is too low please update.
	echo flutter create --org %projectOrg%  --pub %projectName%>temp.bat
	call temp.bat
)
del temp.bat
call :print "Apply default configuration..."
call :createFolders %projectPath%
rem Add dependency
call :addFlutterDependency %projectPath%
call :addEBGRepository %projectPath%\android
call :addEBGRepository %projectPath%\example\android
pause
goto :eof

:error
echo !---------------------------------------------------------------------------------!
echo.
set msg=%1
echo [Error]: %msg:"=%
echo.
echo !---------------------------------------------------------------------------------!
goto :eof

:print
echo ===================================================================================
echo.
set msg=%1
echo %msg:"=%
echo.
echo ===================================================================================
goto :eof

:judgeInstall
set JUDGE_INSTALL_RET=
for /f "tokens=1" %%i in ('%1 --version^|findstr /c:"%1"') do set JUDGE_INSTALL_RET=%%i
if /i "%1"=="%JUDGE_INSTALL_RET%" (set %2=0) else (set %2=-1)
goto :eof

:changeDir
if not exist %1 md %1
if not exist %1 (
	call :error "Invalid directory, example: D:\test\test"
	goto inputProject
)
cd /d %1
goto :eof

:createFolders
setlocal enabledelayedexpansion
for %%i in (support_files services network models common) do (
    set "source_folder=%scriptPath%\%%i"
    set "destination_folder=%projectPath%\lib\%%i"

    xcopy "!source_folder!" "!destination_folder!" /E /I
)

echo Folder has been copied!
goto :eof

:appendFileContent
for /f "delims=" %%i in (%1) do if "%%i"=="" (echo.>>%2) else (echo %%i>>%2)
goto :eof

:addFlutterDependency
set pubspec=%1\pubspec.yaml
setlocal enabledelayedexpansion

REM 读取 pubspec.yaml 文件内容
for /f "eol== delims=" %%a in (%pubspec%) do (
    set "line=%%a"
    setlocal enabledelayedexpansion

    REM 查找 cupertino_icons 行
	echo !line! | findstr /i /c:"cupertino_icons:" >nul
	if !errorlevel! equ 0 (
		REM 在 cupertino_icons 行之后插入新的依赖项
		@REM echo !line!>> %pubspec%.tmp
		echo   get: ^^5.0.0-release-candidate-4>> %pubspec%.tmp
		echo   json_annotation: ^^4.8.1>> %pubspec%.tmp
		echo   freezed_annotation: ^^2.2.0>> %pubspec%.tmp
		echo   hive_flutter: ^^1.1.0>> %pubspec%.tmp
		echo   bot_toast: ^^4.0.3>> %pubspec%.tmp
		echo   easy_refresh: ^^3.0.5>> %pubspec%.tmp
		echo   dio: ^^5.0.2>> %pubspec%.tmp
		echo   retrofit: ^^4.0.1>> %pubspec%.tmp
		echo   flutter_spinkit: ^^5.1.0>> %pubspec%.tmp
		echo   simple_animations: ^^5.0.0+3>> %pubspec%.tmp
		echo   cached_network_image: ^^3.2.2>> %pubspec%.tmp
		echo   event_bus: ^^2.0.0>> %pubspec%.tmp
		echo   logger: ^^1.2.2>> %pubspec%.tmp
		echo   # 启动图: flutter pub run flutter_native_splash:create>> %pubspec%.tmp
		echo   # flutter_native_splash: ^^2.3.0>> %pubspec%.tmp
	) 

	REM 查找 flutter_lints 行
	echo !line! | findstr /i /c:"flutter_lints:" >nul
	if !errorlevel! equ 0 (
		REM 在 flutter_lints 行之后插入新的依赖项
		@REM echo !line!>> %pubspec%.tmp
		echo   build_runner: ^^2.3.3>> %pubspec%.tmp 
		echo   flutter_gen_runner: ^^5.2.0>> %pubspec%.tmp 
		echo   json_serializable: ^^6.7.0>> %pubspec%.tmp 
		echo   freezed: ^^2.3.5>> %pubspec%.tmp 
		echo   retrofit_generator: ^^6.0.0+1>> %pubspec%.tmp 
		echo   # 一键生成启动图标: flutter pub run flutter_launcher_icons>> %pubspec%.tmp 
		echo   # flutter_launcher_icons: ^^0.13.1>> %pubspec%.tmp 
	) 

	REM 将当前行写入临时文件
	echo !line!>> %pubspec%.tmp

)

REM 在文件末尾插入自定义内容
echo.>> %pubspec%.tmp
echo flutter_gen:>> %pubspec%.tmp
echo   output: lib/support_files/>> %pubspec%.tmp
echo   line_length: 80>> %pubspec%.tmp

REM 将临时文件替换回原始文件
move /y %pubspec%.tmp %pubspec% >nul

echo Insert dependency complete!
goto :eof


:addEBGRepository
set src=%1\build.gradle
set temp=%src%.temp
setlocal enabledelayedexpansion
for /f "eol== delims=" %%i in ('findstr /i /n .* %src%') do (
	set "var=%%i"
	set line=!var:*:=!
	set shrink=!line: =!
	if defined line (
		if /i not "!shrink!"=="" (
			if "!shrink!"=="repositories{" (
				echo !line!>> %temp%
				echo         maven {>> %temp%
				echo           url 'http://your.host.com/artifactory/maven-down/'>> %temp%
				echo             credentials {>> %temp%
				echo               username "username">> %temp%
				echo               password "password">> %temp%
				echo             }>> %temp%
				echo         }>> %temp%
			) else (
				echo !line!>> %temp%
			)
		) else (
			echo.>> %temp%
		)
	) else (
		echo.>> %temp%
	)
)
endlocal
del %src%
pushd %1
ren build.gradle.temp build.gradle
popd
goto :eof

:showLogo
if not exist .outlogo (
echo CiAgX18gICAgICAgX19fX18gICAgIF9fX19fXyAgICAgIF9fX19fICAgIAogL1xfXCAgICAgKSBfX18gKCAgIC9fL1xfX19cICAgICkgX19fICggICAKKCAoICggICAgLyAvXF8vXCBcICApICkgX19fLyAgIC8gL1xfL1wgXCAgCiBcIFxfXCAgLyAvXy8gKF9cIFwvXy8gLyAgX19fIC8gL18vIChfXCBcIAogLyAvIC9fX1wgXCApXy8gLyAvXCBcIFxfL1xfX1xcIFwgKV8vIC8gLyAKKCAoX19fX18oXCBcL19cLyAvICApXykgIFwvIF8vIFwgXC9fXC8gLyAgCiBcL19fX19fLyApX19fX18oICAgXF9cX19fXy8gICAgKV9fX19fKCAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK>.logo
certutil -decode .logo .outlogo>nul
del .logo
)
type .outlogo
goto :eof
