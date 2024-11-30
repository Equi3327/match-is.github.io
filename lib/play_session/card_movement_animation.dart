import 'package:flutter/material.dart';

class CardMovementAnimation extends StatefulWidget {
  final Widget cardWidget;
  final Offset startPosition;
  final Offset endPosition;
  final VoidCallback onAnimationComplete;

  const CardMovementAnimation({
    super.key,
    required this.cardWidget,
    required this.startPosition,
    required this.endPosition,
    required this.onAnimationComplete,
  });

  @override
   _CardMovementAnimationState createState() => _CardMovementAnimationState();
}

class _CardMovementAnimationState extends State<CardMovementAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _positionAnimation = Tween<Offset>(
      begin: widget.startPosition,
      end: widget.endPosition,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _positionAnimation,
      builder: (context, child) {
        return Positioned(
          left: _positionAnimation.value.dx,
          top: _positionAnimation.value.dy,
          child: widget.cardWidget,
        );
      },
    );
  }
}
