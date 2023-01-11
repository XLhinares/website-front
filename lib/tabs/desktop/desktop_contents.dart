import "dart:async";

import "package:flutter/material.dart";

import "../../../utils/utils.dart";
import "desktop.dart";
import "desktop_settings.dart";

/// What's inside the body. It depends on the current mode.
class BodyContents extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BodyContents] matching the given parameters.
  const BodyContents({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    Timer.run(() => router.animateTo(index: router.modeIndex));
    return PageView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      controller: router.pageController,
      children: _tabs(context),
    );
  }

  // METHODS ===================================================================

  List<Widget> _tabs(BuildContext context) => const [
        DesktopHome(),
        DesktopProjects(),
        DesktopContact(),
        DesktopSettings(),
      ];
}
