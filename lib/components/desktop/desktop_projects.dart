import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:responsive_framework/responsive_framework.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/project_preview.dart";
import "../projects/project_loader.dart";
import "../projects/projects.dart";

/// The content of the body in the "ProjectPreviews" mode.
class DesktopProjects extends StatelessWidget {

  // VARIABLES =================================================================

  final Rx<ProjectPreview?> _selectedProjectPreview = Rx<ProjectPreview?>(null);

  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopProjects] matching the given parameters.
  DesktopProjects({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(() => _selectedProjectPreview.value == null
        ?  ProjectLoader(
          renderingStrategy: (list) => ResponsiveGridView.builder(
            gridDelegate: ResponsiveGridDelegate(
              mainAxisSpacing: XLayout.paddingL,
              crossAxisSpacing: XLayout.paddingL,
              crossAxisExtent: Get.height * 0.3,
              childAspectRatio: 3/4
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(XLayout.paddingM),
            itemCount: list.length,
            itemBuilder: (context, index) => ProjectPreviewer(
                project: list[index],
                onTap: () => _selectedProjectPreview.value = list[index]
            ),
          ),
        )
        : ProjectFocus(
        project: _selectedProjectPreview.value!,
      onBack: () => _selectedProjectPreview.value = null,
    )
    );
  }

// METHODS ===================================================================

}
