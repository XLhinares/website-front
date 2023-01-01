import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../classes/dataclass/project_metadata.dart";
import "../../utils/utils.dart";
import "../../widgets/widgets.dart";

/// A detailed view of a project.
class ProjectFocus extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project in question.
  final String name;

  /// The behavior when the "back" button is tapped.
  final void Function()? onBack;

  // GETTERS ===================================================================

  /// The project being displayed.
  ProjectMetadata? get project => user.getProject(name);

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectFocus] matching the given parameters.
  const ProjectFocus({super.key, required this.name, this.onBack});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: user,
        builder: (_) {
          return project == null
              ? _loadingWidget(context)
              : Column(
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
                              child: Text(
                                project!.name,
                                style: context.textTheme.titleMedium,
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
                      child: AspectRatio(
                        aspectRatio: 4,
                        child: CoveringNetworkImage(
                          project!.preview,
                          fit: BoxFit.fitHeight,
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
                              child: CoveringNetworkImage(
                                project!.preview,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          XLayout.horizontalM,
                          Flexible(
                            flex: 3,
                            child: XContainer(
                              padding: EdgeInsets.all(XLayout.paddingL),
                              child: Text(
                                project!.summary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
