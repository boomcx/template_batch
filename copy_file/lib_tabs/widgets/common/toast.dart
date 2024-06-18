import 'dart:math';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/support_files/theme.dart';
import 'app_progress_indicator.dart';

String _message = '';

/// easy show toast
showMessage(String message, {Function()? onDissmiss}) {
  if (_message == message) return;

  hideLoading();
  _message = message;
  Toast.message(message, onClose: () {
    _message = '';
    onDissmiss?.call();
  });
}

showLoading({String? message}) {
  hideLoading();
  Toast.showLoading(message: message);
}

hideLoading() {
  Toast.hideLoading();
}

class Toast {
  static NavigatorObserver toastNavigatorObserver() =>
      BotToastNavigatorObserver();

  static Widget init(BuildContext context, Widget child) {
    return BotToastInit().call(context, child);
  }

  static void showError(String message) {
    BotToast.showCustomText(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      align: Alignment.center,
      toastBuilder: (cancelFunc) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPaddingLR),
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddingLR,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                angle: pi / 4,
                child: const Icon(
                  Icons.add_circle_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void message(String message, {VoidCallback? onClose}) {
    Toast.hideLoading();
    BotToast.showCustomText(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 2),
      align: Alignment.center,
      onClose: () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          onClose?.call();
        });
      },
      toastBuilder: (cancelFunc) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddingLR,
            vertical: 28,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.75),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  static void showSuccess(String message) {
    BotToast.showCustomText(
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      align: Alignment.center,
      toastBuilder: (cancelFunc) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPaddingLR),
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPaddingLR,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showLoading({String? message}) {
    const size = 60.0;

    BotToast.showCustomLoading(
        clickClose: true,
        backgroundColor: Colors.transparent,
        toastBuilder: (cancelFunc) {
          final indicator = AppProgressIndicator(
            size: 40,
            color1: Colors.white.withOpacity(0),
            color2: Colors.white,
          );
          if (message == null) {
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              ),
              alignment: Alignment.center,
              child: indicator,
            );
          }
          return Container(
            constraints: const BoxConstraints(minWidth: size, minHeight: size),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                indicator,
                const SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void hideLoading() {
    BotToast.closeAllLoading();
  }
}
