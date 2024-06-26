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
echo flutter create --platforms=ios,android --org %projectOrg% --pub %projectName%>temp.bat
call temp.bat
if errorlevel 1 (
	echo [INFO] Your flutter version is too low please update.
	echo flutter create --org %projectOrg%  --pub %projectName%>temp.bat
	call temp.bat
)
del temp.bat
call :createFolders %projectPath%
call :addFlutterDependency %projectPath%
@REM call :addEBGRepository %projectPath%\android
@REM call :addEBGRepository %projectPath%\example\android
call :flutterCLI %projectPath%
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
echo.
set msg=%1
echo %msg:"=%
echo.
goto :eof

:changeDir
if not exist %1 md %1
if not exist %1 (
	call :error "Invalid directory, example: D:\test\test"
	goto inputProject
)
cd /d %1
goto :eof

@REM 复制lib下的公共文件
:createFolders
call :print "Generate configuration files..."

@REM for %%i in (app support_files services network models common) do (

@REM     set "source_folder=%scriptPath%\files\%%i"
@REM     set "destination_folder=%1\lib\%%i"
	
@REM 	setlocal enabledelayedexpansion

@REM     xcopy "!source_folder!" "!destination_folder!" /S /I /Y /V >nul
	
@REM 	endlocal

@REM )
  
xcopy "%scriptPath%\copy_file\lib" "%1\lib\" /E /I /Y

set "source_folder=%scriptPath%\copy_file\assets"
xcopy "%source_folder%" "%projectPath%\assets" /S /I /Y /V >nul

@REM for %%i in (app main models service tabbar) do (

@REM     set "source_file=%scriptPath%\files\%%i.dart"
@REM     set "destination_file=%1\lib\%%i.dart"

@REM 	setlocal enabledelayedexpansion

@REM 	( type "!source_file!" ) > "!destination_file!" 

@REM 	endlocal
@REM )

goto :eof
 

@REM 添加设置依赖
:addFlutterDependency
call :print "Insert dependency..."

set pubspec=%1\pubspec.yaml

REM 读取 pubspec.yaml 文件内容
for /f "eol== delims=" %%a in (%pubspec%) do (
    set "line=%%a"
    setlocal enabledelayedexpansion

	REM 将当前行写入临时文件
	echo !line!>> %pubspec%.tmp

    REM 查找 cupertino_icons 行
	echo !line! | findstr /i /c:"cupertino_icons:" >nul
	if !errorlevel! equ 0 (
	
		REM  在 cupertino_icons 行之后插入新的依赖项
		@REM echo !line!>> %pubspec%.tmp
		echo.  >>   %pubspec%.tmp
		echo   flutter_localizations:>> %pubspec%.tmp
		echo     sdk: flutter>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 状态管理库>> %pubspec%.tmp
		echo   get^: ^^5.0.0-release-candidate-5>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # tabbar>> %pubspec%.tmp
		echo   persistent_bottom_nav_bar_v2^: ^^5.1.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # json 解析注解>> %pubspec%.tmp
		echo   json_annotation: ^^4.8.1>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # frezzed 注解>> %pubspec%.tmp
		echo   freezed_annotation: ^^2.4.1>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 快捷状态处理>> %pubspec%.tmp
		echo   flutter_hooks: ^^0.20.3>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 本地缓存>> %pubspec%.tmp
		echo   get_storage: ^^2.1.1>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 消息吐司>> %pubspec%.tmp
		echo   bot_toast: ^^4.1.3>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 刷新>> %pubspec%.tmp
		echo   easy_refresh: ^^3.3.3+1>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 滚动加载更多>> %pubspec%.tmp
		echo   infinite_scroll_pagination: ^^4.0.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 网络请求>> %pubspec%.tmp
		echo   dio: ^^5.4.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 网络请求注解>> %pubspec%.tmp
		echo   retrofit: ^^4.0.3>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 像素适配>> %pubspec%.tmp
		echo   flutter_screenutil: ^^5.9.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 加载动画>> %pubspec%.tmp
		echo   flutter_spinkit: ^^5.2.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 快速构建animation builder>> %pubspec%.tmp
		echo   simple_animations: ^^5.0.2>> %pubspec%.tmp
		echo   # cached_network_image: ^^3.2.2>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 全局通知
		echo   event_bus: ^^2.0.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 相册 / 相机>> %pubspec%.tmp
		echo   photo_view: ^^0.14.0>> %pubspec%.tmp
		echo   wechat_assets_picker: ^^9.0.0-dev.2>> %pubspec%.tmp
		echo   wechat_camera_picker: ^^4.2.0-dev.3>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 启动图: flutter pub run flutter_native_splash:create>> %pubspec%.tmp
		echo   flutter_native_splash: ^^2.3.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 文件路径>> %pubspec%.tmp
		echo   path_provider: ^^2.1.1>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 图片>> %pubspec%.tmp
		echo   extended_image: ^^8.2.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 图片保存>> %pubspec%.tmp
		echo   image_gallery_saver: ^^2.0.3>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 系统操作权限>> %pubspec%.tmp
		echo   permission_handler: ^^11.1.0>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # App包信息>> %pubspec%.tmp
		echo   package_info_plus: ^^5.0.1>> %pubspec%.tmp

		echo.  >>   %pubspec%.tmp
		echo   # 设备信息>> %pubspec%.tmp
		echo   device_info_plus: ^^9.1.2>> %pubspec%.tmp
		echo.  >>   %pubspec%.tmp
	
) 

	REM 查找 flutter_lints 行
	echo !line! | findstr /i /c:"flutter_lints:" >nul
	if !errorlevel! equ 0 (
		REM 在 flutter_lints 行之后插入新的依赖项
		@REM echo !line!>> %pubspec%.tmp
		echo.  >>   %pubspec%.tmp
		echo   build_runner: ^^2.3.3>> %pubspec%.tmp 
		echo   flutter_gen_runner: ^^5.2.0>> %pubspec%.tmp 
		echo   json_serializable: ^^6.7.0>> %pubspec%.tmp 
		echo   freezed: ^^2.3.5>> %pubspec%.tmp 
		echo   retrofit_generator: ^^6.0.0+1>> %pubspec%.tmp 
		echo   # 一键生成启动图标: flutter pub run flutter_launcher_icons>> %pubspec%.tmp 
		echo   flutter_launcher_icons: ^^0.13.1>> %pubspec%.tmp 
		echo.  >>   %pubspec%.tmp
	) 
	
	REM 查找 assets 行
	echo !line! | findstr /i /c:"uses-material-design:" >nul
	if !errorlevel! equ 0 (
		REM 在 uses-material-design 行之后插入新的依赖项
		echo   assets:>> %pubspec%.tmp 
		echo     - assets/images/>> %pubspec%.tmp 
	) 

	endlocal
)

REM 在文件末尾插入自定义内容
echo.>> %pubspec%.tmp
echo flutter_gen:>> %pubspec%.tmp
echo   output: lib/support_files/>> %pubspec%.tmp
echo   line_length: 80>> %pubspec%.tmp

REM 将临时文件替换回原始文件
move /y %pubspec%.tmp %pubspec% >nul

REM 在文件 analysis_options 末尾插入自定义内容
set analysis=%1\analysis_options.yaml

for /f "eol== delims=" %%a in (%analysis%) do (
    set "line=%%a"
    setlocal enabledelayedexpansion

	REM 将当前行写入临时文件
	echo !line!>> %analysis%.tmp

	endlocal
)

echo. >> %analysis%.tmp
echo analyzer:>> %analysis%.tmp
echo   exclude:>> %analysis%.tmp
echo     - "**/*.g.dart">> %analysis%.tmp
echo     - /**/generated/**/*.dart>> %analysis%.tmp
echo   errors:>> %analysis%.tmp
echo     invalid_annotation_target: ignore>> %analysis%.tmp
echo     use_build_context_synchronously: ignore>> %analysis%.tmp
echo     unused_element: ignore>> %analysis%.tmp
echo   plugins:>> %analysis%.tmp
echo     - custom_lint>> %analysis%.tmp

REM 将临时文件替换回原始文件
move /y %analysis%.tmp %analysis% >nul

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


:flutterCLI
call :print "Run flutter CLI..."

REM 进入指定文件夹
cd /d "%projectPath%"

REM 运行命令

echo flutter pub get>temp.bat
call temp.bat
del temp.bat

echo flutter pub run build_runner build>temp.bat
call temp.bat
del temp.bat

@REM echo get create page:home>temp.bat
@REM call temp.bat
@REM del temp.bat

@REM echo get create page:mine>temp.bat
@REM call temp.bat
@REM del temp.bat

REM 返回到原始目录
cd /d "%~dp0"
exit /b
goto :eof
 