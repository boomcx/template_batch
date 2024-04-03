import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'routes/app_pages.dart';
import 'service.dart';

void main() async {
  await _initAsync();
  runApp(const MyApp());
  await _initAsyncComplete();
}

_initAsync() async {
  // 启动图
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 初始化
  await _initStorage();
  await ScreenUtil.ensureScreenSize();

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

// 启动后配置
Future _initAsyncComplete() async {
  // 调起主屏后，移除闪屏页
  FlutterNativeSplash.remove();

  // 日志
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
}

Future _initStorage() async {
  await GetStorage.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // 使用`mobSDK`前，必须在用户同意隐私协议时设置
    // 避免部分功能无法使用
    // policyGrant();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return GetMaterialApp(
      // 多主题切换
      // theme: ThemeManager.to.getThemeData(),
      // 仅有深色模式切换，可以用下列方式
      themeMode: ThemeManager.to.mode,
      theme: ThemeManager.to.themeData(),
      darkTheme: ThemeManager.to.themeData(true),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // unknownRoute: AppPages.unknownRoute,
      // scrollBehavior: CustomScrollBehavior(),
      routingCallback: (value) {
        // 切换页面清空当前 Toast
        Toast.hideLoading();
        context.keyboardDissmiss();
      },
      navigatorObservers: [
        Toast.toastNavigatorObserver(),
      ],
      binds: [
        // 挂载公共服务
        Bind.put(AppService()),
        Bind.put(ConfigService()),
        Bind.put(UserService()),
      ],
      debugShowCheckedModeBanner: false,
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('zh', 'CN'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      defaultTransition: Transition.rightToLeft,
      builder: (context, child) {
        return Toast.init(
          context,
          GestureDetector(
            onTap: () => context.keyboardDissmiss(),
            child: child!,
          ),
        );
      },
    );
  }
}
