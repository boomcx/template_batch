import 'package:flutter/material.dart';

class HighlightedButton extends StatefulWidget {
  const HighlightedButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.color,
    this.highlightColor,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? highlightColor;

  @override
  State<HighlightedButton> createState() => _HighlightedButtonState();
}

class _HighlightedButtonState extends State<HighlightedButton>
    with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 10);
  static const Duration kFadeInDuration = Duration(milliseconds: 100);
  bool _buttonHeldDown = false;
  AnimationController? _animationController;
  final Tween<double> _opacityTween = Tween<double>(begin: 0, end: 1.0);
  Animation<double>? _opacityAnimation;

  void _onTapDown(TapDownDetails details) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _onTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController!.isAnimating) return;
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController!.animateTo(1.0, duration: kFadeOutDuration)
        : _animationController!.animateTo(0.0, duration: kFadeInDuration);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _opacityAnimation = _animationController!
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _onTapDown : null,
      onTapUp: enabled ? _onTapUp : null,
      onTapCancel: enabled ? _onTapCancel : null,
      onTap: widget.onPressed,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              color: widget.color,
            ),
          ),
          Positioned.fill(
            child: FadeTransition(
              opacity: _opacityAnimation!,
              child: Container(
                color:
                    widget.highlightColor ?? Theme.of(context).highlightColor,
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}
