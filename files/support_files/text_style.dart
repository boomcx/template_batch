import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore_for_file: non_constant_identifier_names

/// 根据主题配置，设置字体风格
///
/// 通过颜色`Color`获取普通字体大小的`TextStyle`
/// 然后持续扩展到`TextStyle`的其他属性
extension ColorTextStyle on Color {
  /// fontSize = 10
  TextStyle get font_10 => TextStyle(
        color: this,
        fontSize: 10.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 11
  TextStyle get font_11 => TextStyle(
        color: this,
        fontSize: 11.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 12
  TextStyle get font_12 => TextStyle(
        color: this,
        fontSize: 12.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 13
  TextStyle get font_13 => TextStyle(
        color: this,
        fontSize: 13.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 14
  TextStyle get font_14 => TextStyle(
        color: this,
        fontSize: 14.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 15
  TextStyle get font_15 => TextStyle(
        color: this,
        fontSize: 15.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 16
  TextStyle get font_16 => TextStyle(
        color: this,
        fontSize: 16.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 17
  TextStyle get font_17 => TextStyle(
        color: this,
        fontSize: 17.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 18
  TextStyle get font_18 => TextStyle(
        color: this,
        fontSize: 18.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 20
  TextStyle get font_20 => TextStyle(
        color: this,
        fontSize: 20.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 22
  TextStyle get font_22 => TextStyle(
        color: this,
        fontSize: 22.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// fontSize = 24
  TextStyle get font_24 => TextStyle(
        color: this,
        fontSize: 24.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );

  /// 自定义 fontSize
  TextStyle font(double size) => TextStyle(
        color: this,
        fontSize: size.sp,
        fontFamilyFallback: const ['PingFang SC', 'Heiti SC'],
        fontWeight: FontWeight.normal,
      );
}

/// 字体样式，字重的扩展
extension TextStyleExtWeight on TextStyle {
  /// FontWeight.normal
  TextStyle get normal => copyWith(fontWeight: FontWeight.normal);

  /// FontWeight.bold
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  /// FontWeight.Medium.
  // TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// FontWeight.SemiBold.
  // TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
}

/// 字体样式，行高
extension TextStyleExtLineHeight on TextStyle {
  /// height: 1.5
  TextStyle get height_1_5 => copyWith(height: 1.5);
}
