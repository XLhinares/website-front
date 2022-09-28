import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/project.dart";
import "../../utils/test.dart";
import "projects/project_focus.dart";
import "projects/project_preview.dart";

/// The "project" tab adapted for mobile.
class MobileProjects extends StatelessWidget {

  // VARIABLES =================================================================

  final Rx<Project?> _selectedProject = Rx<Project?>(null);

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileProjects] matching the given parameters.
  MobileProjects({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(() => _selectedProject.value == null
        ?  Padding(
      padding: EdgeInsets.all(XLayout.paddingM),
      child: Wrap(
        spacing: XLayout.paddingL,
        runSpacing: XLayout.paddingL,
        alignment: WrapAlignment.center,
        children: projects.map<Widget>((p) => SizedBox(
          width: Get.height * 0.3,
          height: Get.height * 0.4,
          child: ProjectPreview(
            project: p,
            onTap: () => _selectedProject.value = p,
          ),
        ),
        ).toList(),
      ),
    )
        : ProjectFocus(
      project: _selectedProject.value!,
      onBack: () => _selectedProject.value = null,
    )
    );
  }

// WIDGETS ===================================================================

}
