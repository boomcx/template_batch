// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 配置字体
/// color  + fontSize + weight + line
///
final myAppColors = Get.context!.appColors;

extension AppTheme on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}

/// 默认配置颜色
const _appColors = AppColors(
  primary: Color(0xFF165DFF),
  secondary: Color(0xFF33BF56),
  comFFF: Color(0xFFFFFFFF),
  com000: Color(0xFF000000),
  background: Color(0xFFF6F8FA),
  backgroundGrey: Color(0xFFFFEAEA),
  divider: Color(0xFFF6F8FA),
  shimmerBaseColor: Color(0xFFDFDFDF),
  shimmerHighlightColor: Color(0xFFCCCCCC),
  barrierColor: Color(0x43010101),
  textPlaceholder: Color(0xFFB1B4C3),
  textPlaceholderGray: Color(0xFF5D667B),
  text: Color(0xFF0B1526),
  text1: Color(0xFF8D93A6),
  text2: Color(0xFFB1B4C3),
  text3: Color(0xFFD0D3DE),
  text4: Color(0xFF5D667B),
  text5: Color(0xFF33BF56),
  text6: Color(0xFFFF3232),
  text7: Color(0xFF83521A),
  border: Color(0xFFD0D3DE),
);

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.secondary,
    required this.text,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.text7,
    required this.textPlaceholder,
    required this.textPlaceholderGray,
    required this.comFFF,
    required this.com000,
    required this.divider,
    required this.barrierColor,
    required this.background,
    required this.backgroundGrey,
    required this.shimmerBaseColor,
    required this.shimmerHighlightColor,
    required this.border,
  });

  /// Color(0xFF165DFF)
  final Color primary;

  ///
  final Color secondary;

  /// Color(0xFFF6F8FA),
  final Color divider;

  /// Color(0xFFF6F8FA)
  final Color background;
  final Color backgroundGrey;

  /// Color(0x43010101),
  final Color barrierColor;

  /// Color(0xFFDFDFDF),
  final Color shimmerBaseColor;

  /// Color(0xFFCCCCCC),
  final Color shimmerHighlightColor;

  final Color comFFF;
  final Color com000;

  /// Color(0xFF0B1526),
  final Color text;

  ///  Color(0xFF8D93A6),
  final Color text1;

  /// Color(0xFFB1B4C3),
  final Color text2;

  /// Color(0xFFD0D3DE),
  final Color text3;

  /// Color(0xFF5D667B),
  final Color text4;

  /// Color(0xFF33BF56),
  final Color text5;

  /// Color(0xFFFF3232),
  final Color text6;

  /// Color(0xFF83521A),
  final Color text7;

  /// Color(0xFFB1B4C3),
  final Color textPlaceholder;

  /// Color(0xFF5D667B),
  final Color textPlaceholderGray;

  /// Color(0xFFD0D3DE),
  final Color border;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? divider,
    Color? background,
    Color? backgroundGrey,
    Color? barrierColor,
    Color? shimmerBaseColor,
    Color? shimmerHighlightColor,
    Color? comFFF,
    Color? com000,
    Color? text,
    Color? text1,
    Color? text2,
    Color? text3,
    Color? text4,
    Color? text5,
    Color? text6,
    Color? text7,
    Color? textPlaceholder,
    Color? textPlaceholderGray,
    Color? border,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      divider: divider ?? this.divider,
      background: background ?? this.background,
      backgroundGrey: backgroundGrey ?? this.backgroundGrey,
      barrierColor: barrierColor ?? this.barrierColor,
      shimmerBaseColor: shimmerBaseColor ?? this.shimmerBaseColor,
      shimmerHighlightColor:
          shimmerHighlightColor ?? this.shimmerHighlightColor,
      comFFF: comFFF ?? this.comFFF,
      com000: com000 ?? this.com000,
      text: text ?? this.text,
      text1: text1 ?? this.text1,
      text2: text2 ?? this.text2,
      text3: text3 ?? this.text3,
      text4: text4 ?? this.text4,
      text5: text5 ?? this.text5,
      text6: text6 ?? this.text6,
      text7: text6 ?? this.text7,
      textPlaceholder: textPlaceholder ?? this.textPlaceholder,
      textPlaceholderGray: textPlaceholderGray ?? this.textPlaceholderGray,
      border: border ?? this.border,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      text: Color.lerp(text, other.text, t)!,
      text1: Color.lerp(text1, other.text1, t)!,
      text2: Color.lerp(text2, other.text2, t)!,
      text3: Color.lerp(text3, other.text3, t)!,
      text4: Color.lerp(text4, other.text4, t)!,
      text5: Color.lerp(text5, other.text5, t)!,
      text6: Color.lerp(text6, other.text6, t)!,
      text7: Color.lerp(text7, other.text7, t)!,
      textPlaceholder: Color.lerp(textPlaceholder, other.textPlaceholder, t)!,
      textPlaceholderGray:
          Color.lerp(textPlaceholderGray, other.textPlaceholderGray, t)!,
      comFFF: Color.lerp(comFFF, other.comFFF, t)!,
      com000: Color.lerp(com000, other.com000, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t)!,
      background: Color.lerp(background, other.background, t)!,
      backgroundGrey: Color.lerp(backgroundGrey, other.backgroundGrey, t)!,
      shimmerBaseColor:
          Color.lerp(shimmerBaseColor, other.shimmerBaseColor, t)!,
      shimmerHighlightColor:
          Color.lerp(shimmerHighlightColor, other.shimmerHighlightColor, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}

/// 默认主题配置
final appThemeData = ThemeData(
  primaryColor: _appColors.primary,
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: _appColors.background,
  splashFactory: NoSplash.splashFactory,
  splashColor: Colors.transparent, // 点击时的高亮效果设置为透明
  highlightColor: Colors.transparent, // 长按时的扩散效果设置为透明
  // fontFamily: 'PingFang SC',
  bottomAppBarTheme: const BottomAppBarTheme(
    surfaceTintColor: Colors.white,
    color: Colors.white,
    shadowColor: Colors.black,
    elevation: 8,
  ),
  textSelectionTheme: TextSelectionThemeData(
    // selectionHandleColor: _appColors.primary.withOpacity(0.8),
    selectionColor: _appColors.primary.withOpacity(0.2),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: _appColors.text,
      fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
      fontWeight: FontWeight.normal,
    ),
    // 大部分地方的文字颜色
    titleMedium: TextStyle(
      color: _appColors.text,
      fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
      fontWeight: FontWeight.normal,
    ),
  ),
  cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
    primaryColor: _appColors.primary,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        color: _appColors.text,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      ),
      navTitleTextStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: _appColors.text,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.white,
    backgroundColor: _appColors.comFFF,
    iconTheme: IconThemeData(color: _appColors.text),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _appColors.text,
      fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
    ),
    centerTitle: true,
    elevation: 0,
    systemOverlayStyle: kSystemUiOverlayStyle,
  ),
  dividerColor: _appColors.divider,
  // highlightColor: Colors.black.withOpacity(0.05),
  extensions: const [_appColors],
);

const kDefaultAnimationDuration = Duration(milliseconds: 250);
final kPadding_24 = 16.0.r;
const kDefaultPaddingLR = 16.0;
const kDefaultRadius = 4.0;

const kSystemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.white,
);

const kSystemUiOverlayStyleDark = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.white,
);

Widget bottomSlideAnimation(
  BuildContext context,
  Animation<double> animation,
  Widget child,
) {
  final slideAnimation =
      Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
          .chain(CurveTween(curve: Curves.easeOut))
          .animate(animation);
  return Align(
    alignment: Alignment.bottomCenter,
    child: SlideTransition(
      position: slideAnimation,
      child: child,
    ),
  );
}

Widget popFadeAnimation(
    BuildContext context, Animation<double> animation, Widget child) {
  Animation<double> curve = CurvedAnimation(
    parent: animation,
    curve: Curves.slowMiddle,
  );
  final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curve);
  final scaleAnimation = Tween<double>(begin: 1.1, end: 1).animate(curve);
  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      scale: scaleAnimation,
      child: child,
    ),
  );
}
