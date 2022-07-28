// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/classes/dataclass/project.dart";
import "package:website_front/utils/test.dart";
import "package:website_front/widgets/body/projects/project_focus.dart";
import "package:website_front/widgets/body/projects/project_preview.dart";

/// The content of the body in the "Projects" mode.
class BodyContentsProjects extends StatelessWidget {

  // VARIABLES =================================================================

  final Rx<Project?> _selectedProject = Rx<Project?>(null);

  // CONSTRUCTOR ===============================================================

  /// Returns a [BodyContentsProjects] matching the given parameters.
  BodyContentsProjects({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() => _selectedProject.value == null
          ?  Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.height * 0.1),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: XLayout.paddingL,
          runSpacing: XLayout.paddingL,
          children: projects.map((p) => SizedBox(
            // We put the preview in a box whose size is proportional to the
            // height on the screen.
            // This way we're sure two rows can fit.
            height: Get.height * 0.4,
            width: Get.height * 0.4 * 0.75,
            child: ProjectPreview(
              project: p,
              onTap: () => _selectedProject.value = p
            ),
          ),).toList(),
        ),
      )
          : ProjectFocus(
          project: _selectedProject.value!,
        onBack: () => _selectedProject.value = null,
      )
      ),
    );
  }

// METHODS ===================================================================

}
