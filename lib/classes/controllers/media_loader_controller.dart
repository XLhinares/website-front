import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";

import "../../globals.dart";
import "../../utils/tools_api.dart";
import "../medias/medias.dart";

/// A controller that handles loading projects from the API.
abstract class MediaLoaderController<T extends Media> extends GetxController {
  // VARIABLES =================================================================

  /// A controller handling the paginated loading of the projects.
  late final PagewiseLoadController<T> controller;

  /// The selected sorting option for the project loader.
  late APISorter sorter;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaLoaderController]
  MediaLoaderController() {
    sorter = APISorter.relevance;

    controller = PagewiseLoadController<T>(
      pageFuture: (pageIndex) async {
        final res = await app.medias.loadMedias<T>(
          page: pageIndex ?? 0,
          sorter: sorter,
        );

        return List<T>.from(res);
      },
      pageSize: pageSize,
    );
  }
}
