import "package:flutter/material.dart";

import "../../classes/dataclass/project_preview.dart";
import "../../utils/globals.dart";
import "../../widgets/widgets.dart";

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
    return PresetFutureBuilder<List<ProjectPreview>>(
      future: api.getProjects(limit: limit),
      builder: (_, data) => renderingStrategy(data!),
      errorWidget: const Center(
          child: Text("An error occurred while fetching the data.")),
    );
  }
}
