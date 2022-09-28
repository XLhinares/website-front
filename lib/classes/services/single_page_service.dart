// Framework dependencies
import "dart:async";
import "package:flutter/animation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

// Project dependencies
import "../dataclass/app_mode.dart";
import "../../utils/globals.dart";

/// A service managing the state of the app.
class SinglePageService extends GetxController with GetTickerProviderStateMixin {

  // VARIABLES =================================================================

  /// The current mode of the app.
  late AppMode _mode;

  // ANIMATION =================================================================

  late final AnimationController _controller = AnimationController(
    duration: animDurationLong,
    reverseDuration: const Duration(seconds: 0),
    vsync: this,
  );

  /// An animation controlled by [_controller] that goes from 0 to 1.
  late final Animation<double> animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

  // GETTERS ===================================================================

  /// The current mode of the app.
  AppMode get mode => _mode;

  /// Whether the app is at home.
  bool get atHome => _mode == AppMode.home;

  // CONSTRUCTOR ===============================================================

  /// The private instance of SinglePageService.
  ///
  /// It insures that the class is instantiated only once at the beginning.
  static final SinglePageService _instance = SinglePageService._internal();

  /// Re_turns the unique SinglePageService instance.
  factory SinglePageService() => _instance;

  /// The real constructor of the class.
  ///
  /// It is called exactly once and contains the instantiation logic.
  SinglePageService._internal() {
    // INITIAL VALUES ----------------------------------------------------------
    _mode = AppMode.home;
  }

  // METHODS ===================================================================

  /// Goes to the given mode and reloads the controller.
  void goTo (AppMode mode) {
    _controller.forward().then((value) => _controller.reset());

    Timer(Duration(milliseconds: animDurationLong.inMilliseconds ~/ 2), () {
      _mode = mode;
      update();
    });
  }

}