import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../globals.dart";

/// A detailed view of a project.
class MediaFocus<T extends Media> extends StatelessWidget {
  // VARIABLES =================================================================

  /// The project in question.
  final T media;

  /// The building strategy to display the header.
  final Widget Function(T media, ScrollController) headerBuilder;

  /// The building strategy to display the parts.
  final Widget Function(MediaContent content) partsBuilder;

  /// The vertical padding of the [ListView].
  final double listViewVerticalPadding;

  /// The behavior when the "back" button is tapped.
  final void Function()? onBack;

  late final ScrollController _controller;

  // GETTERS ===================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaFocus] matching the given parameters.
  MediaFocus({
    super.key,
    required this.media,
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
          headerBuilder(media, _controller),

          XLayout.verticalL,

          // Parts
          GetBuilder(
            init: app,
            builder: (_) {
              return app.medias.getContent(media.id) == null
                  ? _loadingWidget(context)
                  : partsBuilder(app.medias.getContent(media.id)!);
            },
          ),
        ],
      ),
    );
  }

  // METHODS ===================================================================

  Widget _loadingWidget(BuildContext context) {
    app.medias.loadMediaContent(media.id);
    return LinearProgressIndicator(
      color: context.theme.colorScheme.secondary,
    );
  }
}
