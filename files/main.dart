import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'service.dart';

void main() async {
  await _initAsync();
  runApp(const MyApp());

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

_initAsync() async {
  await Hive.initFlutter();
  await Hive.openBox('app');
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
    return GetMaterialApp(
      theme: appThemeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      scrollBehavior: CustomScrollBehavior(),
      routingCallback: (value) {
        // 切换页面清空当前 Toast
        Toast.hideLoading();
      },
      navigatorObservers: [
        Toast.toastNavigatorObserver(),
      ],
      binds: [
        // 挂载公共服务
        Bind.put(AppService()),
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
        return Toast.init(context, child!);
      },
    );
  }
}
