import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/blog.dart";
import "../../globals.dart";
import "../../widgets/medias/desktop_content.dart";
import "../../widgets/medias/desktop_header.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/medias/project_wide_preview.dart";

/// The content of the body in the "BlogPreviews" mode.
class DesktopMainBlogs extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopMainBlogs] matching the given parameters.
  const DesktopMainBlogs({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (context) => AnimatedSwitcher(
        duration: animDurationShort,
        child: router.project == null
            ? PagewiseListView<Blog>(
                padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
                pageLoadController: blogLoaderController.controller,
                itemExtent: XLayout.paddingM * 10,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, entry, index) =>
                    _blogBuilder(context, entry),
              )
            : MediaFocus<Blog>(
                media: app.medias.getBlog(router.project!),
                headerBuilder: (media, scrollController) =>
                    MediaDesktopHeader<Blog>(
                  media: media,
                  scrollController: scrollController,
                ),
                partsBuilder: (content) =>
                    MediaDesktopContent(content: content),
                listViewVerticalPadding: XLayout.paddingL,
                onBack: () => router.selectProject(null),
              ),
      ),
    );
  }

  // METHODS ===================================================================

  Widget _blogBuilder(BuildContext context, Blog blog) => MediaWidePreview(
        media: blog,
        onTap: () => router.selectProject(blog.id),
        // margin: EdgeInsets.only(bottom: XLayout.paddingL),
      );
}
