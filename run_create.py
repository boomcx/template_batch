#!/usr/bin/env python3

import os
import shutil

print(
    """

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


# 用户输入项目名称
def get_project_name(prompt):
    while True:
        project_name = input(prompt)
        if project_name.strip() != "":
            break
        else:
            print("项目名称不能为空！")
    return project_name


# 用户输入项目组织名称
def get_project_org(prompt):
    project_org = input(prompt)
    if project_org.strip() == "":
        project_org = "com.example"
    return project_org


# 选择项目类型
def get_project_type(prompt):
    while True:
        project_type = input(prompt)
        if project_type.isdigit():
            break
        else:
            print("项目类型错误！")
    return project_type


# 复制文件
def copy_folder(source_folder, destination_folder):
    if not os.path.exists(destination_folder):
        os.makedirs(destination_folder)

    for item in os.listdir(source_folder):
        source = os.path.join(source_folder, item)
        destination = os.path.join(destination_folder, item)

        if os.path.isdir(source):
            copy_folder(source, destination)
        else:
            shutil.copy2(source, destination)


# 文件修改
def modfy_file(file, old_str, new_str):
    """
    替换文件中的字符串
    :param file:文件名
    :param old_str:就字符串
    :param new_str:新字符串
    :return:
    """
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
scriptPath = os.path.dirname(__file__)

# 创建项目配置
project_name = get_project_name("请输入项目名称：")
project_org = get_project_org("请输入项目BundleID（默认：com.example）：")

# 获取用户输入的目标路径
project_path = input(f"请输入项目目录（默认：{scriptPath}）：")

if project_path == "":
    project_path = scriptPath
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
os.system(f"flutter create --platforms ios,android {project_name} --org {project_org}")

print("*** 复制模版文件...")
# assets
copy_folder(
    f"{scriptPath}/tabs_template/assets", f"{project_path}/{project_name}/assets"
)

# lib
source_lib = f"{scriptPath}/{'simple_template' if project_type == '1'  else  'tabs_template' }/lib"
print(source_lib)
copy_folder(source_lib, f"{project_path}/{project_name}/lib")


print("*** 修改插件文件...")
pubspec = f"{project_path}/{project_name}/pubspec.yaml"

# dependencies
modfy_file(
    pubspec,
    "cupertino_icons:",
    """ 
  cupertino_icons: ^1.0.8

  flutter_localizations:
    sdk: flutter

  # 状态管理库
  get: ^5.0.0-release-candidate-6

  # 路由管理
  # go_router: ^13.2.2
  animated_bottom_navigation_bar: ^1.3.3

  # json 解析注解
  json_annotation: ^4.9.0

  # frezzed 注解
  freezed_annotation: ^2.4.1

  # 快捷状态处理
  flutter_hooks: ^0.20.3

  # 本地缓存
  get_storage: ^2.1.1

  # 消息吐司
  bot_toast: ^4.1.3

  # 刷新
  easy_refresh: ^3.4.0

  # 滚动加载更多
  infinite_scroll_pagination: ^4.0.0

  # 网络请求
  dio: ^5.4.3+1

  # 网络请求注解
  retrofit: ^4.1.0

  # 像素适配
  flutter_screenutil: ^5.9.3

  # 加载动画
  flutter_spinkit: ^5.2.1

  # 快速构建animation builder
  simple_animations: ^5.0.2
  # cached_network_image: ^3.2.2

  event_bus: ^2.0.0

  # 相册 / 相机
  photo_view: ^0.15.0
  wechat_assets_picker: ^9.0.4
  wechat_camera_picker: ^4.2.2

  # 启动图: flutter pub run flutter_native_splash:create
  flutter_native_splash: ^2.4.0

  # 文件路径
  path_provider: ^2.1.3

  # 图片
  extended_image: ^8.2.1

  # 图片保存
  # 最新sdk可以替换插件[image_gallery_saver_plus]
  image_gallery_saver: ^2.0.3

  # 系统操作权限
  permission_handler: ^11.3.1

  # App包信息
  package_info_plus: ^8.0.0

  # 设备信息
  device_info_plus: ^10.1.0

  # 打开url
  url_launcher: ^6.3.0
    """,
)

# dev_dependencies
modfy_file(
    pubspec,
    "flutter_lints:",
    """
  flutter_lints: ^4.0.0
  build_runner: ^2.4.11
  flutter_gen_runner: ^5.5.0+1
  json_serializable: ^6.8.0
  freezed: ^2.5.2
  retrofit_generator: ^8.1.0
  # 一键生成启动图标: flutter pub run flutter_launcher_icons
  flutter_launcher_icons: ^0.13.1
    """,
)

# 资源引用路径
modfy_file(
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


print("*** 执行 dart run build_runner build ...")
os.chdir(os.path.join(project_path, project_name))
os.system(f"dart run build_runner build")
