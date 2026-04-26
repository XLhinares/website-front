import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/extensions.dart";

/// A detailed view of a project.
class NoProjectSelected extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaFocus] matching the given parameters.
  const NoProjectSelected({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        XContainer(
          padding: XLayout.edgeInsetsAllM,
          child: Column(
            children: [
              Text("no_project_selected_title".tr),
              XLayout.verticalM,
              Text("no_project_selected_content".tr),
            ],
          ),
        ),
        XLayout.verticalS,
        FittedBox(
          child: XButton.text(
            "button_back".tr,
            textStyle: context.bodyMediumOnSecondary,
            color: context.colors.secondary,
            onTap: () => router.goBack(),
          ),
        )
      ],
    );
  }

  // METHODS ===================================================================
}
