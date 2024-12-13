import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '/utils/common.dart';
import 'app_bar_back_button.dart';

class AAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AAppBar({
    super.key,
    this.leading,
    this.leadingWidth,
    this.title,
    this.titleWidget,
    this.titleWidgetWidth,
    this.backgroundColor,
    this.shadow = false,
    this.systemOverlayStyle,
    this.backIconColor,
    this.actions,
    this.isRootNavigator = false,
    this.centerTitle = true,
    this.bottom,
    this.onPopInvoked,
  });

  final double? leadingWidth;
  final Widget? leading;
  final String? title;
  final Widget? titleWidget;
  final double? titleWidgetWidth;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool shadow;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Color? backIconColor;
  final bool isRootNavigator;
  final bool centerTitle;
  final PreferredSize? bottom;
  final Future<void> Function(dynamic result)? onPopInvoked;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: onPopInvoked == null,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await onPopInvoked?.call(result);
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: shadow
              ? [
                  BoxShadow(
                    color: const Color(0xFFB3B8CB).withOpacity(0.16),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: AppBar(
          backgroundColor: backgroundColor,
          titleSpacing: 0,
          leadingWidth: leadingWidth ?? kMinInteractiveDimensionCupertino + 2,
          leading: _buildLeading(context),
          automaticallyImplyLeading: !isRootNavigator,
          centerTitle: centerTitle,
          bottom: bottom,
          title: titleWidget != null
              ? SizedBox(
                  width: titleWidgetWidth,
                  child: titleWidget,
                )
              : (title != null
                  ? Text(
                      title!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: backIconColor,
                      ),
                    ).paddingOnly(left: isRootNavigator ? 12 : 0)
                  : null),
          systemOverlayStyle: systemOverlayStyle,
          actions: actions,
        ),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;
    if (isRootNavigator) return null;
    final route = ModalRoute.of(context);
    if (route is PageRoute && (route.canPop || route.fullscreenDialog)) {
      return AppBarBackButton(color: backIconColor, superCtx: context);
    }
    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kMinInteractiveDimensionCupertino + (bottom?.preferredSize.height ?? 0));
}

/// 设置页面滚动后 导航栏的颜色切换
class GradientAppBar extends StatefulWidget implements PreferredSizeWidget {
  const GradientAppBar(
    this.controller, {
    super.key,
    this.title,
    this.isRootNavigator = false,
    this.offset,
    this.bottom,
    this.leading,
    this.leadingWidth,
    this.isOverall = false,
    this.colorInt = 255,
    this.onPopInvoked,
    this.centerTitle = true,
    this.actions,
  });

  /// 滚动监听
  final ScrollController controller;

  /// 是否整体过渡
  final bool isOverall;

  /// 偏移量
  final double? offset;

  final String? title;
  final bool isRootNavigator;
  final PreferredSize? bottom;
  final double? leadingWidth;
  final Widget? leading;
  final int colorInt;
  final Future<void> Function(dynamic result)? onPopInvoked;
  final bool centerTitle;
  final List<Widget>? actions;

  @override
  State<GradientAppBar> createState() => _GradientAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(
      kMinInteractiveDimensionCupertino + (bottom?.preferredSize.height ?? 0));
}

class _GradientAppBarState extends State<GradientAppBar> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    final height =
        widget.offset ?? (kNavigationBarHeight + Get.mediaQuery.padding.top);
    widget.controller.addListener(() {
      double temp = widget.controller.offset / height;

      temp = min(max(temp, 0), 1);
      if (_opacity != temp) {
        if (mounted) {
          setState(() {
            _opacity = temp;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isOverall) {
      return Opacity(
        opacity: _opacity,
        child: AAppBar(
          title: widget.title,
          isRootNavigator: widget.isRootNavigator,
          leading: widget.leading,
          leadingWidth: widget.leadingWidth,
          bottom: widget.bottom,
          onPopInvoked: widget.onPopInvoked,
          centerTitle: widget.centerTitle,
          actions: widget.actions,
          // systemOverlayStyle: opacity.value > 0.5
          //     ? SystemUiOverlayStyle.dark
          //     : SystemUiOverlayStyle.light,
        ),
      );
    }

    return AAppBar(
      title: widget.title,
      isRootNavigator: widget.isRootNavigator,
      leading: widget.leading,
      leadingWidth: widget.leadingWidth,
      bottom: widget.bottom,
      onPopInvoked: widget.onPopInvoked,
      centerTitle: widget.centerTitle,
      actions: widget.actions,

      // systemOverlayStyle: opacity.value > 0.5
      //     ? SystemUiOverlayStyle.dark
      //     : SystemUiOverlayStyle.light,
      backIconColor: Color.fromARGB(
          255,
          (widget.colorInt * (1 - _opacity)).toInt(),
          (widget.colorInt * (1 - _opacity)).toInt(),
          (widget.colorInt * (1 - _opacity)).toInt()),
      backgroundColor: Colors.white.withOpacity(_opacity),
    );
  }
}
