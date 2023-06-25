import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import '../widgets/app_progress_indicator.dart';

class RefreshFooter extends Footer {
  const RefreshFooter({
    super.triggerOffset = 70,
    super.clamping = false,
    super.processedDuration = const Duration(
      milliseconds: 500,
    ),
    super.position = IndicatorPosition.above,
    super.safeArea = false,
    this.backgroundColor,
  });

  final Color? backgroundColor;

  @override
  Widget build(Object context, IndicatorState state) {
    Widget child = const SizedBox();
    return child;
  }
}

class _NoMore extends StatelessWidget {
  const _NoMore();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        '- 没有更多数据了 -',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.blueGrey[100],
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppProgressIndicator(
            size: 25,
            color1: Colors.blue.withOpacity(0),
            color2: Colors.blue,
          ),
          const SizedBox(width: 8),
          const Text(
            '加载中...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingTapMore extends StatelessWidget {
  const _LoadingTapMore();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh,
              size: 16,
              color: Colors.blueGrey[100],
            ),
            const SizedBox(width: 1),
            Text(
              '点击加载',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[100],
              ),
            ),
          ],
        ));
  }
}
