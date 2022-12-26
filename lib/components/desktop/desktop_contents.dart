import "package:flutter/material.dart";
import "package:get/get.dart";

// Project dependencies
import "../../../classes/dataclass/app_mode.dart";
import "../../../utils/globals.dart";
import "../../widgets/widgets.dart";
import "desktop.dart";

/// What's inside the body. It depends on the current mode.
class BodyContents extends StatelessWidget {
  // VARIABLES =================================================================

  // GETTERS ===================================================================

  /// The main content widget inside the body.
  Widget get _contents {
    switch (sps.mode) {
      case AppMode.home:
        return const DesktopHome();
      case AppMode.projects:
        return DesktopProjects();
      case AppMode.contact:
        return const DesktopContact();
      default:
        return Center(
          child: Text("How did we get there?".tr),
        );
    }
  }

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BodyContents] matching the given parameters.
  const BodyContents({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CONTENTS ----------------------------------------------------------
        Positioned.fill(
          child: GetBuilder(
            init: sps,
            builder: (_) => _contents,
          ),
        ),

        // ANIMATION ---------------------------------------------------------
        Positioned.fill(
          child: AnimatedCover(
            animation: sps.animation,
          ),
        ),
      ],
    );
  }

  // METHODS ===================================================================

  // todo: a way to handle scroll
  /// How to behave when the contents are scrolled.
  void onScroll() {}
}
