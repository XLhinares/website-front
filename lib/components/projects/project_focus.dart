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

  /// The vertical padding of the [ListView].
  final double listViewVerticalPadding;

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
    this.listViewVerticalPadding = 0,
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
        padding: EdgeInsets.symmetric(vertical: listViewVerticalPadding),
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        children: [
          // Header
          headerBuilder(project, _controller),

          // If the parts are loading or loaded and not empty, there is a spacer.
          // However, if they are empty, then there is no space and the user cannot scroll.
          GetBuilder(
            init: user,
            builder: (_) => AnimatedSize(
              duration: animDurationShort,
              child: !user.hasParts(project.id) ||
                      user.getParts(project.id)!.isNotEmpty
                  ? XLayout.verticalL
                  : const SizedBox(),
            ),
          ),

          // Parts
          GetBuilder(
            init: user,
            builder: (_) {
              return parts == null
                  ? _loadingWidget(context)
                  : partsBuilder(parts!);
            },
          ),
        ],
      ),
    );
  }

  // METHODS ===================================================================

  Widget _loadingWidget(BuildContext context) {
    user.loadMediaParts(project.id);
    return LinearProgressIndicator(
      color: context.theme.colorScheme.secondary,
    );
  }
}
