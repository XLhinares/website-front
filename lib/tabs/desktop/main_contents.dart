import "package:flutter/material.dart";

import "../../../utils/exports.dart";
import "main_settings.dart";
import "exports.dart";

/// What's inside the body. It depends on the current mode.
class DesktopMainContents extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [DesktopMainContents] matching the given parameters.
  const DesktopMainContents({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    // Timer.run(() => router.animateTo(index: router.routeIndex));
    return PageView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      controller: router.newPageController,
      children: _tabs(context),
    );
  }

  // METHODS ===================================================================

  List<Widget> _tabs(BuildContext context) => const [
        DesktopMainHome(),
        // DesktopBlogs(),
        DesktopMainProjects(),
        DesktopMainContact(),
        DesktopMainSettings(),
      ];
}
