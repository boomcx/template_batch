import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

/// deep link
const String kUrlScheme = 'example://test';

/// 开屏协议
const String kPrivacyPolicy = 'privacy_policy';

/// 定义导航栏高度 kToolbarHeight
const kNavigationBarHeight = kMinInteractiveDimensionCupertino;
final kStatusBarHeight = ScreenUtil().statusBarHeight;

class ThrottleClick extends StatelessWidget {
  const ThrottleClick({required this.child, this.onTap, super.key});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      // behavior: HitTestBehavior.translucent,
      padding: EdgeInsets.zero,
      pressedOpacity: 0.9,
      minSize: 10,
      onPressed: onTap == null
          ? null
          : () {
              onTap?.call();
            }.throttleWithTimeout(timeout: 1200),
      child: child,
    );
  }
}

/// 扩展点击节流
extension ThrottleClickExt on Widget {
  /// 点击节流
  ///
  /// [onTap] 点击事件
  /// [pageId] 页面id
  /// [eventId] 事件id
  Widget onTaped({required VoidCallback? onTap, int? pageId, int? eventId}) {
    return ThrottleClick(
      onTap: () {
        onTap?.call();
      },
      child: this,
    );
  }
}

/// 富文本点击节流
///
/// [onTap] 点击事件
/// [pageId] 页面id
/// [eventId] 事件id
GestureRecognizer? onRichSpanTaped(
    {required VoidCallback? onTap, int? pageId, int? eventId}) {
  return TapGestureRecognizer()
    ..onTap = () {
      onTap?.call();
    }.throttleWithTimeout(timeout: 1200);
}

/// 输入节流
Function(dynamic) throttle(Function(dynamic) func,
    {Duration delay = const Duration(milliseconds: 1200)}) {
  Timer? timer;
  target(value) {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func.call(value);
    });
  }

  return target;
}

Timer? timerVoid;
void Function() throttleVoid(Function func,
    {Duration delay = const Duration(milliseconds: 1200)}) {
  Timer? timerVoid;
  target() {
    if (timerVoid?.isActive ?? false) {
      timerVoid?.cancel();
      timerVoid = null;
    }
    timerVoid = Timer(delay, () {
      func.call();
    });
  }

  return target;
}

extension FunctionExt on Function {
  VoidCallback throttle() {
    return FunctionProxy(this).throttle;
  }

  VoidCallback throttleWithTimeout({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).throttleWithTimeout;
  }

  VoidCallback debounce({int? timeout}) {
    return FunctionProxy(this, timeout: timeout).debounce;
  }
}

class FunctionProxy {
  static final Map<String, bool> _funcThrottle = {};
  static final Map<String, Timer> _funcDebounce = {};
  final Function? target;

  final int timeout;

  FunctionProxy(this.target, {int? timeout}) : timeout = timeout ?? 500;

  void throttle() async {
    String key = hashCode.toString();
    bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      try {
        await target?.call();
      } catch (e) {
        rethrow;
      } finally {
        _funcThrottle.remove(key);
      }
    }
  }

  void throttleWithTimeout() {
    String key = hashCode.toString();
    bool enable = _funcThrottle[key] ?? true;
    if (enable) {
      _funcThrottle[key] = false;
      Timer(Duration(milliseconds: timeout), () {
        _funcThrottle.remove(key);
      });
      target?.call();
    }
  }

  void debounce() {
    String key = hashCode.toString();
    Timer? timer = _funcDebounce[key];
    timer?.cancel();
    timer = Timer(Duration(milliseconds: timeout), () {
      Timer? t = _funcDebounce.remove(key);
      t?.cancel();
      target?.call();
    });
    _funcDebounce[key] = timer;
  }
}
