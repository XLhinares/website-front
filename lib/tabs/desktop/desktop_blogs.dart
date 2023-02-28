import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../components/components.dart";
import "../../utils/utils.dart";
import "../../widgets/medias/medias.dart";

/// The content of the body in the "BlogPreviews" mode.
class DesktopBlogs extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopBlogs] matching the given parameters.
  const DesktopBlogs({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: router,
      builder: (context) => AnimatedSwitcher(
        duration: animDurationShort,
        child: router.blog == null
            ? PagewiseListView<Blog>(
                padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
                pageLoadController: blogLoaderController.controller,
                itemExtent: XLayout.paddingM * 8,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, entry, index) =>
                    _blogBuilder(context, entry),
              )
            : MediaFocus<Blog>(
                media: user.getBlog(router.blog!),
                headerBuilder: (media, scrollController) =>
                    MediaDesktopHeader<Blog>(
                  media: media,
                  scrollController: scrollController,
                ),
                partsBuilder: (content) =>
                    MediaDesktopContent(content: content),
                listViewVerticalPadding: XLayout.paddingL,
                onBack: () => router.selectBlog(null),
              ),
      ),
    );
  }

  // METHODS ===================================================================

  Widget _blogBuilder(BuildContext context, Blog blog) => MediaWidePreview(
        media: blog,
        onTap: () => router.selectBlog(blog.id),
        // margin: EdgeInsets.only(bottom: XLayout.paddingL),
      );
}
