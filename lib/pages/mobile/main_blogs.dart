import "package:flutter/material.dart";

import "../../classes/dataclass/route.dart";
import "../../widgets/body/tab.dart";

/// The "project" tab adapted for mobile.
class MobileMainBlogs extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.MAIN_BLOGS;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileMainBlogs] matching the given parameters.
  MobileMainBlogs({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
