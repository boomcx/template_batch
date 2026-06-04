#!/usr/bin/env python3

import os
import shutil
import subprocess
from pathlib import Path

print(
    r"""

Flutter 项目创建脚本！
 _                           _         _                         _         
| |                         | |       | |                       | |        
| |_  ___  _ __ ___   _ __  | |  __ _ | |_  ___      __ _   ___ | |_ __  __
| __|/ _ \| '_ ` _ \ | '_ \ | | / _` || __|/ _ \    / _` | / _ \| __|\ \/ /
| |_|  __/| | | | | || |_) || || (_| || |_|  __/   | (_| ||  __/| |_  >  < 
 \__|\___||_| |_| |_|| .__/ |_| \__,_| \__|\___|    \__, | \___| \__|/_/\_\
     
                     | |                     ______  __/ |                 
                     |_|                    |______||___/    
      
      """
)


def get_project_name(prompt):
    """读取非空项目名称。"""
    while True:
        project_name = input(prompt)
        if project_name.strip() != "":
            break
        else:
            print("项目名称不能为空！")
    return project_name


def get_project_org(prompt):
    """读取项目组织名，未输入时使用默认 Bundle ID 前缀。"""
    project_org = input(prompt)
    if project_org.strip() == "":
        project_org = "com.example"
    return project_org


def get_project_type(prompt):
    """读取模板类型编号。"""
    while True:
        project_type = input(prompt)
        if project_type.isdigit():
            break
        else:
            print("项目类型错误！")
    return project_type


def copy_folder(source_folder, destination_folder):
    """递归复制模板目录到目标项目。"""
    if not os.path.exists(destination_folder):
        os.makedirs(destination_folder)

    for item in os.listdir(source_folder):
        source = os.path.join(source_folder, item)
        destination = os.path.join(destination_folder, item)

        if os.path.isdir(source):
            copy_folder(source, destination)
        else:
            shutil.copy2(source, destination)


def replace_in_file(file, old_str, new_str):
    """替换命中行，用于注入 pubspec 配置。"""
    file_data = ""
    with open(file, "r", encoding="utf-8") as f:
        for line in f:
            if old_str in line:
                # remove_line(file, line)
                line = new_str
                # line = line.replace(old_str, new_str)
            file_data += line
    with open(file, "w", encoding="utf-8") as f:
        f.write(file_data)


def read_package_name(pubspec_file):
    """从 pubspec.yaml 读取 Dart 包名。"""
    with open(pubspec_file, "r", encoding="utf-8") as f:
        for line in f:
            if line.startswith("name:"):
                return line.split(":", 1)[1].strip()
    raise ValueError(f"未找到包名: {pubspec_file}")


def rewrite_package_imports(project_dir, source_package, target_package):
    """把模板包名导入替换为目标项目包名。"""
    replace_from = f"package:{source_package}/"
    replace_to = f"package:{target_package}/"
    for root in ("lib", "test"):
        root_dir = Path(project_dir) / root
        if not root_dir.exists():
            continue
        for dart_file in root_dir.rglob("*.dart"):
            text = dart_file.read_text(encoding="utf-8")
            new_text = text.replace(replace_from, replace_to)
            if new_text != text:
                dart_file.write_text(new_text, encoding="utf-8")


def find_jdk17_home():
    """查找本机 JDK 17，供 Android Gradle 构建使用。"""
    if os.name != "posix":
        return None
    java_home = Path("/usr/libexec/java_home")
    if not java_home.exists():
        return None
    try:
        result = subprocess.run(
            [str(java_home), "-v", "17"],
            check=True,
            capture_output=True,
            text=True,
        )
    except subprocess.CalledProcessError:
        return None
    return result.stdout.strip()


def configure_android_gradle_jdk(project_dir):
    """为目标项目写入 Gradle JDK 17 配置。"""
    jdk_home = find_jdk17_home()
    if not jdk_home:
        print("*** 未检测到 JDK 17，Android 构建请手动配置 Gradle JDK 为 17")
        return

    gradle_properties = Path(project_dir) / "android" / "gradle.properties"
    if not gradle_properties.exists():
        return

    lines = gradle_properties.read_text(encoding="utf-8").splitlines()
    property_line = f"org.gradle.java.home={jdk_home}"
    updated = False
    for index, line in enumerate(lines):
        if line.startswith("org.gradle.java.home="):
            lines[index] = property_line
            updated = True
            break
    if not updated:
        lines.insert(1, property_line)
    gradle_properties.write_text("\n".join(lines) + "\n", encoding="utf-8")


# def remove_line(file_name, line_to_skip):
#     """
#     删除指定行
#     """
#     with open(file_name, "r", encoding="utf-8") as read_file:
#         lines = read_file.readlines()
#     with open(file_name, "w", encoding="utf-8") as write_file:
#         for current_line, line in enumerate(lines, start=1):
#             if current_line != line_to_skip:
#                 write_file.write(line)


# 当前脚本文件路径
# /Users/xxx/Desktop/template_batch
scriptPath = Path(__file__).resolve().parent

# 创建项目配置
project_name = get_project_name("请输入项目名称：")
project_org = get_project_org("请输入项目BundleID（默认：com.example）：")

# 获取用户输入的目标路径
project_path = input(f"请输入项目目录（默认：{scriptPath}）：")

if project_path == "":
    project_path = str(scriptPath)
if not os.path.exists(project_path):
    os.makedirs(project_path)


# 项目类型
project_type = get_project_type(
    f"""请选择项目目录结构：
1. 单页面模版
2. tabs结构模版
"""
)

# 切换到目标工程目录
os.chdir(project_path)

# print("*** 项目输出目录：", project_path)
# print("*** 名称：", project_name)
# print("*** 组织：", project_org)

print("*** 正在创建项目...")
subprocess.run(
    ["flutter", "create", "--platforms", "ios,android", project_name, "--org", project_org],
    check=True,
)

print("*** 复制模版文件...")
# assets
copy_folder(
    f"{scriptPath}/tabs_template/assets", f"{project_path}/{project_name}/assets"
)

# lib
source_lib = f"{scriptPath}/{'simple_template' if project_type == '1'  else  'tabs_template' }/lib"
print(source_lib)
copy_folder(source_lib, f"{project_path}/{project_name}/lib")

configure_android_gradle_jdk(Path(project_path) / project_name)


print("*** 修改插件文件...")
pubspec = f"{project_path}/{project_name}/pubspec.yaml"

# dependencies
replace_in_file(
    pubspec,
    "cupertino_icons:",
    """ 
  cupertino_icons: ^1.0.8

  flutter_localizations:
    sdk: flutter

  # get: ^5.0.0-release-candidate-6
  get: 5.0.0-release-candidate-9.2.1
  animated_bottom_navigation_bar: ^1.4.0
  json_annotation: ^4.9.0
  get_storage: ^2.1.1
  bot_toast: ^4.1.3
  easy_refresh: 3.4.0
  infinite_scroll_pagination: ^5.1.1
  dio: ^5.9.2
  retrofit: ^4.1.0
  flutter_screenutil: ^5.9.3
  flutter_spinkit: ^5.2.1
  simple_animations: ^5.1.0
  event_bus: ^2.0.1
  photo_view: ^0.15.0
  # wechat_assets_picker: ^9.0.4
  # wechat_camera_picker: ^4.2.2
  flutter_native_splash: ^2.4.4
  path_provider: ^2.1.5
  # cached_network_image: ^3.2.2
  extended_image: ^9.1.0
  image_gallery_saver_plus: ^4.0.1
  permission_handler: ^12.0.1
  package_info_plus: ^9.0.1
  device_info_plus: ^10.1.2
  url_launcher: ^6.3.1
  internet_connection_checker_plus: ^3.0.0

    """,
)

# dev_dependencies
replace_in_file(
    pubspec,
    "flutter_lints:",
    """
  flutter_lints: ^5.0.0
  build_runner: ^2.4.12
  flutter_gen_runner: ^5.10.0
  json_serializable: ^6.8.0
  retrofit_generator: ^9.1.2
  # 一键生成启动图标: dart pub run flutter_launcher_icons
  flutter_launcher_icons: ^0.14.4
  pretty_dio_logger: ^1.4.0

    """,
)

# 资源引用路径
replace_in_file(
    pubspec,
    "uses-material-design: true",
    """
  uses-material-design: true
  assets:
    - assets/images/
           """,
)

# 添加build生成文件路径
with open(pubspec, "a") as file:
    file.write(
        """
flutter_gen:
  output: lib/support_files/
  line_length: 80
               """
    )


# 添加analysis_options配置
with open(f"{project_path}/{project_name}/analysis_options.yaml", "a") as file:
    file.write(
        """
analyzer:
  exclude:
    - "**/*.g.dart"
    - /**/generated/**/*.dart
  errors:
    invalid_annotation_target: ignore
    use_build_context_synchronously: ignore
    unused_element: ignore
  plugins:
    - custom_lint
               """
    )


template_package_name = read_package_name(scriptPath / "tabs_template" / "pubspec.yaml")
target_package_name = read_package_name(Path(project_path) / project_name / "pubspec.yaml")
rewrite_package_imports(
    Path(project_path) / project_name,
    template_package_name,
    target_package_name,
)

print("*** 执行 dart run build_runner build ...")
os.chdir(os.path.join(project_path, project_name))
subprocess.run(["dart", "run", "build_runner", "build"], check=True)
