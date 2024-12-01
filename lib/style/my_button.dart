import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:match_is/blocs/board_bloc/board_bloc.dart';

import 'palette.dart';

class MyButton extends StatefulWidget {
  final Widget child;

  final VoidCallback? onPressed;

  final bool? unFocusNode;

  const MyButton({super.key, required this.child, this.onPressed, this.unFocusNode});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.unFocusNode == true) {
      _focusNode.unfocus();
    }
    return MouseRegion(
      onEnter: (event) {
        _controller.repeat();
      },
      onExit: (event) {
        _controller.stop(canceled: false);
      },
      child: RotationTransition(
        turns: _controller.drive(const _MySineTween(0.005)),
        child: KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: (keyEvent){
            if(keyEvent is KeyDownEvent){
              widget.onPressed!();
            }
          },
          child: ElevatedButton(
            onPressed: widget.onPressed,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _MySineTween extends Animatable<double> {
  final double maxExtent;

  const _MySineTween(this.maxExtent);

  @override
  double transform(double t) {
    return sin(t * 2 * pi) * maxExtent;
  }
}
