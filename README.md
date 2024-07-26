### 前言

根目录 /simple_template 和 /tabs_template 是完整的模版文件，后续修改都是在这两个项目里面进行；

对于 flutter 项目的配置从官方角度来说，其实已经够简单了。但是从实际业务出发，我们往往会多出一些公共的配置、插件、归纳甚至更多自定义的东西。这就对我们新起项目造成了不小的困扰：

- 公共的文件迁移（复制到新项目后一堆警告与错误）；
- 公共插件的引入，在`.yaml`中补全插件;
- 多文件的相互引用（`import`有时候会拼接项目名称，例如：`import 'package:xxx/xxx.dart`，或者相对路径层级不对）；
- 对新项目`main.dart`文件的修改（这个其实可以抽离实现主体，在`main.dart`文件中直接`runApp(...)`，不做其他操作）；
- 基础图片资源的重复导入；
- 或者其他；

上述问题相信看到这里的小伙伴多少有点感同身受吧。博主一直想写一个自用模版项目的脚本，但苦于对文件生成脚本生疏（主要还是太懒 (￣ ▽ ￣)"），一直没有实现这个伟大的抱负，直到遇见了她 [# batch: flutter 插件工程模版的创建](https://blog.csdn.net/csfchh/article/details/115033798)，好嘛，该我（~~依~~）大（~~葫~~）显（~~芦~~）身（~~画~~）手（~~瓢~~）的时候到了！！！

### 正文

我们先抛开文件的创建，文件内容的填充或者整体文件夹的复制，这些实际脚本操作是如何实现的。优先梳理一下对于我们想要生成的最终产物，需要得到些什么需要做什么。

这里针对我自己的模版项目 [template_getx](https://github.com/boomcx/template_getx) 而言

- 首先我们需要创建基础的项目结构`flutter create xxx ...`；
- 然后再往创建的结构中添加下列内容（添加顺序随意）:

1. 常用插件的引入；
2. 项目模块（文件夹分类）的划分；
3. 公共文件的引入；
4. `main.dart`文件的修改；
5. 基础资源`Assets`文件的引入；

- 完成添加后执行相应的`flutter`命令；
- 最后得到完整的项目

最终得到的产物是一个可直接运行，带 tabbar 的模版项目。

![GIF 2023-6-25 18-04-25.gif](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0ebbbac887324de99154949a7a9aafe0~tplv-k3u1fbpfcp-watermark.image?)

> 1、使用脚本的过程

![企业微信截图_16876875851911.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0a3b96cde63c41d3954e26cb99409446~tplv-k3u1fbpfcp-watermark.image?)

> 2、生成的模版项目结构

下面开始具体说说`batch`的实现，因为不熟悉 batch 的所有命令，所以这里只对使用到的阐述一下（ (￣ ▽ ￣)"，其他使用可以谷歌、可以 ChatGPT）。

#### 1、脚本静态展示（LOGO+提示文本）

```bat

echo +---------------------------------------------------------------------------------+
call :showLogo
echo This script will guide you through creating a flutter project with specified
echo dependencies and file directories.
echo.
echo +---------------------------------------------------------------------------------+
```

`echo`：可以为终端输出显示，后续也用到输出具体内容到目标文件

`:showLogo`：自定义的标签，具体实现是为了显示打开终端显示自定义的 LOGO;

```bat
:showLogo
if not exist .outlogo (
echo CiAgX18gICAgICAgX19fX18gICAgIF9fX19fXyAgICAgIF9fX19fICAgIAogL1xfXCAgICAgKSBfX18gKCAgIC9fL1xfX19cICAgICkgX19fICggICAKKCAoICggICAgLyAvXF8vXCBcICApICkgX19fLyAgIC8gL1xfL1wgXCAgCiBcIFxfXCAgLyAvXy8gKF9cIFwvXy8gLyAgX19fIC8gL18vIChfXCBcIAogLyAvIC9fX1wgXCApXy8gLyAvXCBcIFxfL1xfX1xcIFwgKV8vIC8gLyAKKCAoX19fX18oXCBcL19cLyAvICApXykgIFwvIF8vIFwgXC9fXC8gLyAgCiBcL19fX19fLyApX19fX18oICAgXF9cX19fXy8gICAgKV9fX19fKCAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK>.logo
certutil -decode .logo .outlogo>nul
del .logo
)
type .outlogo
goto :eof
```

判断是否添加自定义的 LOGO，如果没有则输出默认内容。

`.outlogo`：自己添加的 LOGO 内容的文件

`goto :eof`：继续执行后续脚本

#### 2、提示输入项目名称

```bat
:inputProjectName
set /p projectName= Input project name:
if "%projectName%"=="" goto input
if "%projectName%"=="test" (
	call :error "'test' is not allowed as a project name, enter another name."
	goto inputProjectName
)
```

给定固定的提示语句，提示用户输入需要生成的`flutter`项目名称，如果不输入则重复提示输入。

`goto inputProjectName`：指定执行 bat 命令的标签（提示重复输入）

#### 3、提示输入 flutter 项目的组织机构

```bat
:inputProjecOrg
set /p projectOrg= Input project organization (such as com.example), or press Entry to use default:
if "%projectOrg%"=="" (
    set "projectOrg=com.example"
)

```

定义变量`projectOrg`接收用户输入内容，如果不输入则使用默认的组织机构名称，`set "projectOrg=com.example"`为设置默认组织机构。

#### 4、提示输入项目输出路径

```bat
:inputProject
set /p v= Input project path(such as D:\FlutterWorkspace\Porjects), or press Entry to use default:
if not "%v%"=="" call :changeDir %v%
set projectPath=%cd%\%projectName%
echo [INFO] Project path is: %projectPath%
```

提示输入项目输出路径，如果不输入则默认创建到`create.bat`脚本的同级目录下，建议测试命令是否正常输出可以不输入，正常项目还是有必要输入具体的项目路径的。

`:changeDir`：创建输入的项目路径，如果创建失败则返回重新输入。

#### 5、执行 flutter create

```bat
call :print "Start creating new flutter plugin project..."
echo flutter create --platforms=ios,android --org %projectOrg% --pub %projectName%>temp.bat
call temp.bat
if errorlevel 1 (
	echo [INFO] Your flutter version is too low please update.
	echo flutter create --org %projectOrg%  --pub %projectName%>temp.bat
	call temp.bat
)
del temp.bat
```

这里主要是创建基本的项目结构，方便后续修改为自己的项目模版。 `flutter create --platforms=ios,android --org %projectOrg% --pub %projectName%`该命令可以拼接其他的操作，输入需要用书输入则可以提供终端输入变量的模式。

#### 6、插入模版项目的文件（夹）

```bat
:createFolders
call :print "Generate configuration files..."

xcopy "%scriptPath%\files" "%1\lib\" /E /I /Y

set "source_folder=%scriptPath%\assets"
xcopy "%source_folder%" "%projectPath%\assets" /S /I /Y /V >nul

goto :eof
```

`%1`：是标签`:createFolders`传递的变量`%projectPath%`具体值为`flutter`项目路径；

`%scriptPath%`：是当前脚本所在的目录路径；

`xcopy "%scriptPath%\files" "%1\lib\" /E /I /Y`：复制当前脚本同级文件夹`files`下的所有内容至，`flutter`项目路径`lib`下；

`xcopy "%source_folder%" "%projectPath%\assets" /S /I /Y /V >nul`：复制静态资源至项目路径；

- `/E`：复制包括子文件夹和空文件夹在内的所有文件和文件夹;
- `/I`：如果目标目录不存在，则会自动创建目标文件夹;
- `/Y`：确认所有覆盖操作，即在目标文件夹中存在同名文件时自动覆盖;
- `/S` 参数表示递归复制子文件夹中的文件;
- `/V`参数用于显示详细的复制操作日志;

#### 7、.yaml 文件中添加常用插件

```
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
		REM 在 cupertino_icons 行之后插入新的依赖项
		@REM echo !line!>> %pubspec%.tmp
		echo   flutter_localizations:>> %pubspec%.tmp
		echo     sdk: flutter>> %pubspec%.tmp
		echo   get: ^^5.0.0-release-candidate-4>> %pubspec%.tmp
		echo   json_annotation: ^^4.8.1>> %pubspec%.tmp
		echo   freezed_annotation: ^^2.2.0>> %pubspec%.tmp
		echo   flutter_hooks: ^^0.18.6>> %pubspec%.tmp
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
		echo   star_menu: ^^3.1.4>> %pubspec%.tmp
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

goto :eof
```

-`for /f "eol== delims=" %%a in (%pubspec%) do `：循环遍历.yaml 文件每一行内容，判断是否有符合条件的行，并在该行后插入需要添加的插件。文末内容的添加直接添加至循环以外就可以了。

`setlocal enabledelayedexpansion`：设置本地为延迟扩展。
在 cmd 执行命令前会对脚本进行预处理，其中有一个过程是变量识别过程，在这个过程中，如果有两个%括起来的如%value%类似这样的变量，就会对其进行识别，并且查找这个变量对应的值，再而将值替换掉这个变量，这个替换值的过程,就叫做变量扩展，然后再执行命令。

`echo ... >> %pubspec%.tmp `：将内容写入到临时文件，结束所有操作后替换掉项目原有的`pubspec.yaml`。

`echo !line! | findstr /i /c:"cupertino_icons:" >nul`：执行输出当前行`!line!`中是否包含`cupertino_icons:`，如果成功执行则后续判断表示满足我们想要插入的内容的行，否则不插入自定义内容，具体内容按规划插入就可以了。后续的几个判断都是类似的处理方式。

`!errorlevel!`：为前一句语句的执行状态，`0`表示执行成功；`1`表示执行失败。

`move /y %pubspec%.tmp %pubspec% >nu`：将临时文件替换掉我们原有的项目文件，完成插件插值。

#### 8、执行 flutter 命令

```bat
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

REM 返回到原始目录
cd /d "%~dp0"
exit /b
goto :eof

```

在`VS Code`编辑器下正常来说，我们完成了`步骤7`编辑器会自动更新`pubspec.yaml`文件，更新我们的插件管理文件。

但是在这里我的`pubspec.yaml`文件中包含`build_runner`的编译内容（`retrofit_generator`、`freezed`等），所以需要额外执行一次`flutter pub run build_runner build`。由于让编辑器自动更新插件我们无法把握`pub get`完成的时机，为避免`dart`命令执行的冲突，这里我直接执行插件更新，然后执行`build_runner`.

`cd /d "%projectPath%"`：进入到项目路径，`cd /d "%~dp0"`：返回 bat 脚本路径。

`echo flutter pub get>temp.bat`：将执行命令写入临时文件`temp.bat`，
`call temp.bat`：执行脚本内容，`del temp.bat`：执行完毕后移除临时文件。

`exit /b`：当脚本运行到“exit /b”行时，不会执行此行之后的命令，并且调用当前脚本后的命令将继续执行。

到这里整个执行流程已经完成了。

### 总结

`batch`属于 Windows 下的批量执行命令，在文件操作方面感觉还是挺简单的，前提还是得对它有基本了解，迎（~~硬~~）难（~~着~~）而（~~头~~）上，还是蛮哇噻的...(￣-￣)"。

后续可能会对 [`template_getx`](https://github.com/boomcx/template_getx) 项目的使用进行简单的介绍和梳理。

使用 ChatGPT 附图：
![企业微信截图_16877458436465.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/418651b64a664cd89f5b83ca468c8515~tplv-k3u1fbpfcp-watermark.image?)

Git 地址：[flutter 模版项目命令](https://github.com/boomcx/template_batch)

bat 使用推荐：[BAT 批处理 常用命令 [MD]](https://www.cnblogs.com/baiqiantao/p/11274817.html#md)

模版项目产出灵感：[flutter 插件工程模版的创建](https://blog.csdn.net/csfchh/article/details/115033798)
