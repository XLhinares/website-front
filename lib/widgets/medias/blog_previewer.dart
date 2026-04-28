import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/blog.dart";
import "../images/covering_network_image.dart";
import "../images/xeppelin_logo.dart";
import "../text/auto_color_text.dart";

/// A preview of a blog.
class BlogPreviewer extends StatelessWidget {
  // VARIABLES =================================================================

  /// The blog being previewed.
  final Blog blog;

  /// The behavior when the box is tapped.
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BlogPreviewer] matching the given parameters.
  const BlogPreviewer({
    super.key,
    required this.blog,
    this.onTap,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XButton(
      height: Get.height * 0.25,
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: XLayout.brcXS,
        child: Stack(
          children: [
            // IMAGE -------------------------------------------------------------
            Positioned.fill(
              child: CoveringNetworkImage(
                blog.preview,
                errorBuilder: (context, object, trace) => const XeppelinLogo(),
              ),
            ),

            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color:
                        context.theme.colorScheme.surface.withValues(alpha: .5),
                    padding: EdgeInsets.all(XLayout.paddingM),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // NAME ------------------------------------------------------
                        Text(
                          blog.name,
                          style: context.textTheme.titleMedium,
                        ),

                        XLayout.verticalXS,
                        const Divider(),
                        XLayout.verticalXS,

                        // SUMMARY ---------------------------------------------------
                        AutoColorText(
                          blog.summary,
                          style: context.textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                  // .asGlass(tintColor: context.theme.colorScheme.background,)
                  ,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
