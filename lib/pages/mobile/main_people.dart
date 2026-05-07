import "package:flutter/material.dart";

import "../../classes/dataclass/app_route.dart";
import "../../widgets/body/mobile_tab.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/people/people_overview_page.dart";

/// The content of the body in the "Contact" mode.
class MobileMainPeople extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.MAIN_PEOPLE;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileMainPeople] matching the given parameters.
  MobileMainPeople({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return MobileTab(
      route: route,
      child: PeopleOverviewPage(),
    );
  }

// METHODS ===================================================================
}
