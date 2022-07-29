// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// An animated cover widget which slides across the screen in a snail fashion.
class AnimatedCover extends AnimatedWidget {

  // VARIABLES =================================================================

  /// The animation controlling the widget.
  final Animation animation;

  /// The percentage of animation time active at the beginning and at the end.
  ///
  /// Any value over 0.5 will prevent the full coverage of the image.
  final double activeFrame;

  /// The precision of the animation.
  ///
  /// Since [Flex] can only be integers, the smooth animation value is emulated
  /// via big numbers.
  final int precision;

  // GETTERS ===================================================================

  /// A size which grows from 0 to 1000 linearly during the last [activeFrame].
  int get _leftMargin => animation.value < (1 - activeFrame)
      ? 0
      : precision * (animation.value - (1 - activeFrame)) ~/ activeFrame;

  /// A size which grows from 0 to 1000 linearly during the first [activeFrame].
  int get _rightMargin => animation.value > activeFrame
      ? 0
      : precision * (activeFrame - animation.value) ~/ activeFrame;

  /// A size which added to left and right margins should always be [precision].
  int get _middleSize => precision - _leftMargin - _rightMargin;

  /// An invisible block of no height.
  ///
  /// It is used to push the [Flex] since it ignores empty regular containers.
  Widget get _emptyBlock => const XContainer(
    padding: EdgeInsets.zero,
    enableShadow: false,
    color: Colors.transparent,
    height: 0,
  );


  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [AnimatedCover] matching the given parameters.
  const AnimatedCover({
    super.key,
    required this.animation,
    this.activeFrame = 0.4,
    this.precision = 10000,
  }) : super(listenable: animation);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {

    // print("L: ${_leftMargin.toString().padLeft(4)} "
    //     "| M: ${_middleSize.toString().padLeft(4)} "
    //     "| R: ${_rightMargin.toString().padLeft(4)}");

    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        // The first sized box tries to reach max width while it's playing
        // then goes back to no width.
        Flexible(
          flex: _leftMargin,
          child: _emptyBlock,
        ),

        Flexible(
          flex: _middleSize,
          child: XContainer(
            padding: EdgeInsets.zero,
            enableShadow: false,
            color: context.theme.shadowColor,
          ),
        ),

        // The first sized box tries to reach max width while it's playing
        // then goes back to no width.
        Flexible(
          flex: _rightMargin,
          child: _emptyBlock,
        ),
      ],
    );
  }

  // METHODS ===================================================================

}
