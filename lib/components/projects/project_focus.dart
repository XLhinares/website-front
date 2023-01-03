import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/dataclass.dart";
import "../../utils/utils.dart";

/// A detailed view of a project.
class ProjectFocus extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project in question.
  final Project project;

  /// The building strategy to display the header.
  final Widget Function(Media, ScrollController) headerBuilder;

  /// The building strategy to display the parts.
  final Widget Function(MediaParts) partsBuilder;

  /// The behavior when the "back" button is tapped.
  final void Function()? onBack;

  late final ScrollController _controller;

  // GETTERS ===================================================================

  /// The project being displayed.
  MediaParts? get parts => user.getParts(project.id);

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ProjectFocus] matching the given parameters.
  ProjectFocus({
    super.key,
    required this.project,
    required this.headerBuilder,
    required this.partsBuilder,
    this.onBack,
  }) {
    _controller = ScrollController();
  }

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        children: [
          // Header
          headerBuilder(project, _controller),

          XLayout.verticalL,

          // Parts
          GetBuilder(
              init: user,
              builder: (_) {
                return parts == null
                    ? _loadingWidget(context)
                    : partsBuilder(parts!);
              }),
        ],
      ),
    );
  }

  // METHODS ===================================================================

  Widget _loadingWidget(BuildContext context) {
    user.loadMediaParts(project.id);
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
