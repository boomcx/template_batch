import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template_getx/app.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Assets.images.icNavBack.image(
          width: 22,
          height: 22,
          color: color ?? context.appColors.text1,
        ),
        onPressed: () async {
          final navigator = Navigator.of(context);

          if (navigator.canPop()) {
            navigator.pop();
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        },
      ),
    );
  }
}
