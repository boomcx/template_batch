import 'package:flutter/cupertino.dart';
import 'package:template_getx/app.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.padding = const EdgeInsets.all(10),
  }) : super(key: key);

  final String title;
  final EdgeInsets padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return CupertinoButton(
      pressedOpacity: 0.8,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: UnconstrainedBox(
        child: Container(
          alignment: Alignment.center,
          padding: padding,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colors.comFFF,
            ),
          ),
        ),
      ),
    );
  }
}
