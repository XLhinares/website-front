import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../components/components.dart";
import "../../utils/utils.dart";
import "../../widgets/medias/medias.dart";

/// The "project" tab adapted for mobile.
class MobileBlogs extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileBlogs] matching the given parameters.
  const MobileBlogs({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: router,
        builder: (context) {
          return router.project == null
              ? PagewiseListView<Blog>(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(XLayout.paddingM),
                  pageLoadController: blogLoaderController.controller,
                  itemBuilder: (context, entry, index) =>
                      _blogBuilder(context, entry),
                  itemExtent: XLayout.paddingM * 8,
                )
              : MediaFocus<Blog>(
                  media: user.getBlog(router.blog!),
                  headerBuilder: (media, scrollController) =>
                      MediaMobileHeader<Blog>(
                    media: media,
                    scrollController: scrollController,
                  ),
                  partsBuilder: (content) =>
                      MediaMobileContent(content: content),
                );
        });
  }

  // METHODS ===================================================================

  Widget _blogBuilder(BuildContext context, Blog blog) => MediaWidePreview(
        media: blog,
        onTap: () => router.selectBlog(blog.id),
      );
}
