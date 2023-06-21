import 'dart:async';
import 'package:flutter/cupertino.dart';

typedef RunningTitleBuilder = String Function(int remainingTime);

class CountdownButton extends StatefulWidget {
  const CountdownButton({
    Key? key,
    this.title = '',
    this.titleWidget,
    this.runningTitleBuilder,
    this.titleStyle,
    this.runningTitleStyle,
    this.color,
    this.disabledColor,
    this.borderRadius,
    this.padding,
    this.duration = 60,
    this.onPressed,
    this.onCompleted,
  }) : super(key: key);

  final String title;
  final Widget? titleWidget;

  final TextStyle? titleStyle;
  final TextStyle? runningTitleStyle;
  final Color? color;
  final Color? disabledColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final RunningTitleBuilder? runningTitleBuilder;
  final int duration;
  final VoidCallback? onPressed;
  final VoidCallback? onCompleted;

  @override
  CountdownButtonState createState() => CountdownButtonState();
}

class CountdownButtonState extends State<CountdownButton> {
  Timer? _timer;
  int _remainingTime = 0;
  bool _isRunning = false;

  void start() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _remainingTime = widget.duration;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
        if (_remainingTime == 0) {
          timer.cancel();
          _timer = null;
          _isRunning = false;
          if (widget.onCompleted != null) {
            widget.onCompleted!();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (_isRunning) {
      if (widget.runningTitleBuilder != null) {
        title = widget.runningTitleBuilder!(_remainingTime);
      } else {
        title = '${_remainingTime}s';
      }
    } else {
      title = widget.title;
    }
    return CupertinoButton(
      padding: widget.padding,
      color: widget.color,
      disabledColor:
          widget.disabledColor ?? CupertinoColors.quaternarySystemFill,
      borderRadius: widget.borderRadius,
      onPressed: _isRunning ? null : widget.onPressed,
      child: widget.titleWidget ??
          Text(
            title,
            style: _isRunning ? widget.runningTitleStyle : widget.titleStyle,
          ),
    );
  }
}
