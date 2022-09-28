// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:x_containers/x_containers.dart";

// Project dependencies
import "../../../utils/globals.dart";

/// A card that can be configured to test different behaviors.
///
/// It is not meant to stay in the final app.
class TestCard extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [TestCard] matching the given parameters.
  const TestCard({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      padding: EdgeInsets.all(XLayout.paddingM),
      title: const Text("Click to run the test."),
      onTap: () => api.test(context),
    );
  }

  // METHODS ===================================================================

}
