import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../utils/exports.dart";
import "get_animation_controller.dart";

/// An icon which rotates when the given [observed] is updated.
class RotatingIcon extends StatelessWidget {
  // VARIABLES =================================================================

  late final GetAnimationController _controller;

  /// The logic to build the child.
  ///
  /// It is a function rather than a widget in order to be able to adapt to
  /// changes of the "child". For instance the [TrackableSearchCycleButton]
  /// changes its icon while it's rotating.
  final Widget Function(BuildContext) builder;

  /// The [Rx] being observed for changes.
  ///
  /// The animation plays when it is updated.
  final Rx observed;

  /// The number of turn the icon should rotate each time the animation is played.
  final double step;

  /// Whether the rotation should change direction each time.
  final bool alternateRotation;

  /// The time it takes the animation to complete.
  final Duration duration;

  /// A unique string to synchronize or differentiate several [RotatingIcon] instances.
  final String? tag;

  // CONSTRUCTOR ===============================================================

  /// Returns a [RotatingIcon] matching the given parameters.
  ///
  /// Parameters:
  /// * [builder] is the logic to display the child.
  /// * [observed] is a variable which triggers the animation when it is updated.
  /// * [step] is a amount of turns per rotation (a step of 1 means the child will do one full turn every time the animation plays.
  /// * [alternateRotation] decides whether the rotation should change direction each time.
  /// * [duration] is the time it takes the animation to complete.
  /// * [tag] is a unique string to synchronize or differentiate several [RotatingIcon] instances.
  RotatingIcon({
    super.key,
    required this.builder,
    required this.observed,
    this.step = 1,
    this.alternateRotation = false,
    this.duration = animDurationShort,
    this.tag,
  }) {
    // Instantiation of the animation controller.
    _controller = GetAnimationController(
      step: step,
      alternateDirection: alternateRotation,
      tag: tag,
    );

    // Add a worker to trigger the animation each time [observed] is updated.
    ever(observed, (callback) => _controller.play());
  }

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => _controller,
      tag: tag,
    );

    return Obx(
      () => AnimatedRotation(
        duration: duration,
        turns: _controller.to.value,
        child: builder(context),
      ),
    );
  }
}
