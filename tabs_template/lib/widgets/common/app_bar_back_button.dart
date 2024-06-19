import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '/pages/home/home.dart';
import '/support_files/assets.gen.dart';
import '/support_files/theme.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
    this.color,
    this.superCtx,
  });

  final Color? color;
  final BuildContext? superCtx;

  @override
  Widget build(BuildContext context) {
    // double size = min(22.w, 30);
    return Align(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Assets.images.icNavBack.image(
          width: 20,
          height: 20,
          color: color ?? context.appColors.text,
        ),
        onPressed: () async {
          if (superCtx != null) {
            Navigator.maybePop(superCtx!);
            return;
          }

          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          } else {
            Get.offAllNamed(kRouteHome);
          }
        },
      ),
    );
  }
}
