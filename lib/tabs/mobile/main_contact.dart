import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../components/contact/contact_column_expanded.dart";
import "../../widgets/body/mobile_tab.dart";
import "../../widgets/body/tab.dart";

/// The content of the body in the "Contact" mode.
class MobileMainContact extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.MAIN_CONTACT;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileMainContact] matching the given parameters.
  MobileMainContact({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return MobileTab(
      route: route,
      child: XContainer(
        padding: EdgeInsets.all(XLayout.paddingM),
        child: ContactColumnExpanded(),
      ),
    );
  }

// METHODS ===================================================================
}
