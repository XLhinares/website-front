import "package:flutter/material.dart";

import "../../classes/dataclass/route.dart";
import "../../widgets/body/mobile_tab.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/projects/overview_list.dart";

/// The "project" tab adapted for mobile.
class MobileMainProjects extends RouteTab {
  // VARIABLES =================================================================

  @override
  AppRoute get route => AppRoute.MAIN_PROJECTS;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileMainProjects] matching the given parameters.
  const MobileMainProjects({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return MobileTab(
      route: route,
      child: LayoutBuilder(
        builder: (context, constraints) => ProjectsListView(
          maxHeight: constraints.maxHeight,
        ),
      ),
    );
  }
}
