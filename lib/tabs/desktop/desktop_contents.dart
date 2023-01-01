import "package:flutter/material.dart";
import "package:get/get.dart";

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
    switch (router.mode) {
      case AppMode.home:
        return const DesktopHome();
      case AppMode.projects:
        return const DesktopProjects();
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
            init: router,
            builder: (_) => _contents,
          ),
        ),

        // ANIMATION ---------------------------------------------------------
        Positioned.fill(
          child: AnimatedCover(
            animation: router.animation,
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
