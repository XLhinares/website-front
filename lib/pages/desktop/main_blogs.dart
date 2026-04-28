import "package:flutter/material.dart";

import "../../classes/dataclass/route.dart";
import "../../widgets/body/tab.dart";

/// The "project" tab adapted for desktop.
class DesktopMainBlogs extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.MAIN_BLOGS;

  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopMainBlogs] matching the given parameters.
  DesktopMainBlogs({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
