import "package:get/get.dart";

/// A custom controller for animations.
///
/// It extends [GetxController] so that animated widget can be triggered by
/// rebuilding a [GetBuilder].
class GetAnimationController extends GetxController {
  // VARIABLES =================================================================
  /// A custom tag to identify the controller via [Get.find()].
  final String? tag;

  /// The progress of the animation.
  late final RxDouble _progress;

  /// Whether the last animation was triggered in the forward direction.
  late final RxBool _lastDirectionForward;

  /// The amount [_progress] is increased or decreased each time the animation plays.
  final double step;

  /// Whether the animation should change direction each time it is played.
  final bool alternateDirection;

  // GETTERS ===================================================================

  /// An access to the controller via [Get.find].
  ///
  /// todo: test if it can be removed.
  GetAnimationController get to => Get.find(tag: tag);

  /// The progress of the animation.
  double get value => _progress.value;

  int get _forward => _lastDirectionForward.value ? 1 : -1;
  int get _alternateDirection => alternateDirection ? -1 : 1;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [GetAnimationController] matching the given parameters.
  GetAnimationController({
    this.tag,
    double startingValue = 0,
    this.step = 1,
    this.alternateDirection = false,
  }) {
    _progress = RxDouble(startingValue);
    _lastDirectionForward = RxBool(false);
  }

  // METHODS ===================================================================

  /// Plays the animation in the direction matching [alternateDirection].
  void play() {
    printInfo(info: "Controller [$tag] is playing.");
    _progress.value += _alternateDirection * _forward * step;
    _lastDirectionForward.value = _alternateDirection * _forward > 0;
    update(tag != null ? [tag!] : null);
  }

  /// Increase the progress of the animation by [step].
  void forward() {
    _progress.value += step;
    _lastDirectionForward.value = true;
    update(tag != null ? [tag!] : null);
  }

  /// Decrease the progress of the animation by [step].
  void backwards() {
    _progress.value -= step;
    _lastDirectionForward.value = false;
    update(tag != null ? [tag!] : null);
  }
}
