// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:responsive_framework/responsive_framework.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "../../classes/dataclass/project.dart";
import "../../utils/test.dart";
import "projects/project_focus.dart";
import "projects/project_preview.dart";

/// The content of the body in the "Projects" mode.
class DesktopProjects extends StatelessWidget {

  // VARIABLES =================================================================

  final Rx<Project?> _selectedProject = Rx<Project?>(null);

  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopProjects] matching the given parameters.
  DesktopProjects({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(() => _selectedProject.value == null
        ?  ResponsiveGridView.builder(
          gridDelegate: ResponsiveGridDelegate(
            mainAxisSpacing: XLayout.paddingL,
            crossAxisSpacing: XLayout.paddingL,
            crossAxisExtent: Get.height * 0.3,
            childAspectRatio: 3/4
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.all(XLayout.paddingM),
          itemCount: projects.length,
          itemBuilder: (context, index) => ProjectPreview(
              project: projects[index],
              onTap: () => _selectedProject.value = projects[index]
          ),
        )
        : ProjectFocus(
        project: _selectedProject.value!,
      onBack: () => _selectedProject.value = null,
    )
    );
  }

// METHODS ===================================================================

}
