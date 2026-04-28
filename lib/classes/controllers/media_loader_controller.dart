import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";

import "../../globals.dart";
import "../../utils/tools_api.dart";
import "../medias/media.dart";
import "../medias/media_type.dart";

/// A controller that handles loading projects from the API.
class MediaLoaderController extends GetxController {
  // VARIABLES =================================================================

  /// The type of media that should be handled by this controller.
  final MediaType type;

  /// A controller handling the paginated loading of the projects.
  late final PagewiseLoadController<Media> controller;

  /// The selected sorting option for the project loader.
  late APISorter sorter;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaLoaderController]
  MediaLoaderController({
    required this.type,
  }) {
    sorter = APISorter.relevance;

    controller = PagewiseLoadController<Media>(
      pageFuture: (pageIndex) async => await app.medias.loadMedias(
        type: type,
        page: pageIndex ?? 0,
        sorter: sorter,
      ),
      pageSize: pageSize,
    );
  }
}
