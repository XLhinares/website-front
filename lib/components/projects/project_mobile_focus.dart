import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/project_metadata.dart";
import "../../utils/utils.dart";
import "../../widgets/projects/projects.dart";

/// A detailed view of a project.
class ProjectMobileFocus extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project in question.
  final String name;

  /// The behavior when the "back" button is tapped.
  final void Function()? onBack;

  // GETTERS ===================================================================

  /// The project being displayed.
  ProjectMetadata? get project => user.getProject(name);

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectMobileFocus] matching the given parameters.
  const ProjectMobileFocus({super.key, required this.name, this.onBack});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: user,
        builder: (_) {
          return project == null
              ? _loadingWidget(context)
              : ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // TITLE ---------------------------------------------------------------
                    ProjectMobileHeader(
                      metadata: project!,
                    ),

                    XLayout.verticalM,
                  ],
                );
        });
  }

  // METHODS ===================================================================

  Widget _loadingWidget(BuildContext context) {
    user.loadProject(name);
    return Center(
      child: SizedBox(
        height: Get.height * 0.2,
        width: Get.height * 0.2,
        child: CircularProgressIndicator(
          color: context.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
