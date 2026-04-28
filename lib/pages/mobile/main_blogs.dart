import "package:flutter/material.dart";
import "package:flutter_pagewise/flutter_pagewise.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/dataclass/route.dart";
import "../../classes/medias/blog.dart";
import "../../globals.dart";
import "../../widgets/body/tab.dart";
import "../../widgets/medias/media_focus.dart";
import "../../widgets/medias/mobile_content.dart";
import "../../widgets/medias/mobile_header.dart";
import "../../widgets/medias/project_wide_preview.dart";

/// The "project" tab adapted for mobile.
class MobileMainBlogs extends RouteTab {
  // VARIABLES =================================================================

  @override
  final AppRoute route = AppRoute.MAIN_BLOGS;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileMainBlogs] matching the given parameters.
  MobileMainBlogs({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: router,
        builder: (context) {
          return router.blog == null
              ? PagewiseListView<Blog>(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(XLayout.paddingM),
                  pageLoadController: blogLoaderController.controller,
                  itemBuilder: (context, entry, index) =>
                      _blogBuilder(context, entry),
                  itemExtent: XLayout.paddingM * 8,
                )
              : MediaFocus<Blog>(
                  media: app.medias.getBlog(router.blog!),
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
