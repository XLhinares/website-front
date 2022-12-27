import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../classes/dataclass/project_preview.dart";
import "../../utils/globals.dart";

/// A widget that loads the projects and display them according to the rendering strategy.
class ProjectLoader extends StatelessWidget {
  // VARIABLES =================================================================

  /// The limit on the number of projects to load.
  final int limit;

  /// A strategy to render the list of projects obtained from the api.
  final Widget Function(List<ProjectPreview>) renderingStrategy;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectLoader] matching the given parameters.
  const ProjectLoader({
    super.key,
    required this.renderingStrategy,
    this.limit = -1,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: user,
      builder: (_) => user.projects.isEmpty
          ? _loadingWidget(context)
          : renderingStrategy(user.projects),
    );
  }

  // WIDGETS ===================================================================

  Widget _loadingWidget(BuildContext context) {
    user.loadProjects();
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
