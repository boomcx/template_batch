import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app_bar_back_button.dart';

class AAppBar extends StatefulWidget implements PreferredSizeWidget {
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
    this.onWillPop,
    this.scrollController,
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
  final Future<bool> Function()? onWillPop;

  /// 滚动监听
  final ScrollController? scrollController;

  @override
  State<AAppBar> createState() => _AAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kMinInteractiveDimensionCupertino +
      (bottom?.preferredSize.height ?? 0) +
      2);
}

class _AAppBarState extends State<AAppBar> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController != null) {
      const height = (10);
      widget.scrollController!.addListener(() {
        double temp = widget.scrollController!.offset / height;

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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.onWillPop == null,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final res = await widget.onWillPop?.call();
        if (res == true) {
          Navigator.of(context).pop();
        }
      },
      // onWillPop: () async {
      //   final res = await onWillPop?.call();
      //   if (res == true) {
      //     // Navigator.of(context).pop();
      //     return true;
      //   }
      //   return false;
      // },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: widget.shadow
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
          backgroundColor: widget.backgroundColor?.withOpacity(_opacity),
          titleSpacing: 0,
          leadingWidth:
              widget.leadingWidth ?? kMinInteractiveDimensionCupertino + 2,
          leading: _buildLeading(context),
          automaticallyImplyLeading: !widget.isRootNavigator,
          centerTitle: widget.centerTitle,
          bottom: widget.bottom,
          title: widget.titleWidget != null
              ? SizedBox(
                  width: widget.titleWidgetWidth,
                  child: widget.titleWidget,
                )
              : (widget.title != null
                  ? Text(
                      widget.title!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: widget.backIconColor,
                      ),
                    ).paddingOnly(left: widget.isRootNavigator ? 12 : 0)
                  : null),
          systemOverlayStyle: widget.systemOverlayStyle,
          actions: widget.actions,
        ),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (widget.leading != null) return widget.leading;
    if (widget.isRootNavigator) return null;
    final route = ModalRoute.of(context);
    if (route is PageRoute && (route.canPop || route.fullscreenDialog)) {
      return AppBarBackButton(color: widget.backIconColor, superCtx: context);
    }
    return null;
  }
}

/// 设置页面滚动后 导航栏的颜色切换
// class GradientAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const GradientAppBar(
//     this.scrollController, {
//     super.key,
//     this.title,
//     this.isRootNavigator = false,
//     this.offset,
//     this.bottom,
//     this.leading,
//     this.leadingWidth,
//     this.isOverall = false,
//     this.colorInt = 0,
//     this.onWillPop,
//     this.centerTitle = true,
//     this.actions,
//   });

//   /// 滚动监听
//   final ScrollController scrollController;

//   /// 是否整体过渡，否则背景颜色变化
//   final bool isOverall;

//   /// 偏移量
//   final double? offset;

//   final String? title;
//   final bool isRootNavigator;
//   final PreferredSize? bottom;
//   final double? leadingWidth;
//   final Widget? leading;
//   final int colorInt;
//   final Future<bool> Function()? onWillPop;
//   final bool centerTitle;
//   final List<Widget>? actions;

//   @override
//   State<GradientAppBar> createState() => _GradientAppBarState();

//   @override
//   Size get preferredSize => Size.fromHeight(kMinInteractiveDimensionCupertino +
//       (bottom?.preferredSize.height ?? 0) +
//       2);
// }

// class _GradientAppBarState extends State<GradientAppBar> {
//   double _opacity = 0;

//   @override
//   void initState() {
//     super.initState();
//     final height =
//         widget.offset ?? (kNavigationBarHeight + Get.mediaQuery.padding.top);
//     widget.scrollController.addListener(() {
//       double temp = widget.scrollController.offset / height;

//       temp = min(max(temp, 0), 1);
//       if (_opacity != temp) {
//         if (mounted) {
//           setState(() {
//             _opacity = temp;
//           });
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.isOverall) {
//       return Opacity(
//         opacity: _opacity,
//         child: AAppBar(
//           title: widget.title,
//           isRootNavigator: widget.isRootNavigator,
//           leading: widget.leading,
//           leadingWidth: widget.leadingWidth,
//           bottom: widget.bottom,
//           onWillPop: widget.onWillPop,
//           centerTitle: widget.centerTitle,
//           actions: widget.actions,
//           // systemOverlayStyle: opacity.value > 0.5
//           //     ? SystemUiOverlayStyle.dark
//           //     : SystemUiOverlayStyle.light,
//         ),
//       );
//     }

//     return AAppBar(
//       title: widget.title,
//       isRootNavigator: widget.isRootNavigator,
//       leading: widget.leading,
//       leadingWidth: widget.leadingWidth,
//       bottom: widget.bottom,
//       onWillPop: widget.onWillPop,
//       centerTitle: widget.centerTitle,
//       actions: widget.actions,
//       // systemOverlayStyle: opacity.value > 0.5
//       //     ? SystemUiOverlayStyle.dark
//       //     : SystemUiOverlayStyle.light,
//       backIconColor: Color.fromARGB(
//           255,
//           (widget.colorInt * (1 - _opacity)).toInt(),
//           (widget.colorInt * (1 - _opacity)).toInt(),
//           (widget.colorInt * (1 - _opacity)).toInt()),
//       backgroundColor: Colors.white.withOpacity(_opacity),
//     );
//   }
// }
