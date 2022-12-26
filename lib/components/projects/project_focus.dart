import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/project_preview.dart";
import "../../widgets/widgets.dart";

/// A detailed view of a project.
class ProjectFocus extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project in question.
  final ProjectPreview project;

  /// The behavior when the "back" button is tapped.
  final void Function()? onBack;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectFocus] matching the given parameters.
  const ProjectFocus({super.key, required this.project, this.onBack});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TITLE ---------------------------------------------------------------
        XContainer(
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(
                child: Center(
                  child: PresetText.headline(
                    project.name,
                  ),
                ),
              ),
            ],
          ),
        ),

        XLayout.verticalM,

        // IMAGE ---------------------------------------------------------------

        XContainer(
          padding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: XLayout.brcXS,
            child: AspectRatio(
              aspectRatio: 4,
              child: project.preview,
            ),
          ),
        ),

        XLayout.verticalM,

        // DESCRIPTION ---------------------------------------------------------

        // Section technologies
        Expanded(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: XLayout.brcXS,
                    child: project.preview,
                  ),
                ),
              ),
              XLayout.horizontalM,
              Flexible(
                flex: 3,
                child: XContainer(
                  padding: EdgeInsets.all(XLayout.paddingL),
                  child: Text(
                    project.summary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

// METHODS ===================================================================

}
