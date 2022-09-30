import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../utils/mock_values.dart";
import "../../widgets/widgets.dart";
import "../components.dart";

/// The "project" tab adapted for mobile.
class MobileProjects extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileProjects] matching the given parameters.
  const MobileProjects({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
          children: projects.map<Widget>((p) => Padding(
            padding: EdgeInsets.only(bottom: XLayout.paddingM),
            child: ProjectWidePreview(
              project: p,
              onTap: () => Get.to(() => ScaffoldFit(
                body: ProjectFocus(
                  project: p,
                  onBack: () => Get.back(),
                ),
              ))
            ),
          ),
          ).toList(),
    );
  }

// WIDGETS ===================================================================

}
