import "package:flutter/material.dart";

import "../../classes/dataclass/app_route.dart";

/// An common mother-class for all tabs in the app.
///
/// It contains the route leading there in order to be able to
abstract class RouteTab extends StatelessWidget {
  // VARIABLES =================================================================

  /// The mode matching this tab.
  abstract final AppRoute route;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [RouteTab] matching the given parameters.
  const RouteTab({
    super.key,
  });

  // BUILD =====================================================================

  // METHODS ===================================================================
}
