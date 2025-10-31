import "package:flutter/material.dart";
import "package:get/utils.dart";
import "package:gpt_markdown/gpt_markdown.dart";
import "package:x_containers/x_containers.dart";

import "../../classes/medias/medias.dart";
import "../../classes/services/theme_service.dart";
import "../../utils/exports.dart";
import "../exports.dart";

/// A widget displaying the parts of the given media on desktop.
class MediaDesktopContent extends StatelessWidget {
  // VARIABLES =================================================================

  /// The parts of the media.
  final MediaContent content;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MediaDesktopContent] matching the given parameters.
  const MediaDesktopContent({
    super.key,
    required this.content,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: content.entries.length,
      itemBuilder: (context, index) => _entryWidget(content.entries[index]),
      separatorBuilder: (context, index) => XLayout.verticalL,
    );
  }

  // WIDGETS ===================================================================

  Widget _entryWidget(MediaEntry entry) {
    switch (entry.type) {
      // Text entry
      case MediaContentType.text:
        return XContainer(
          padding: EdgeInsets.all(XLayout.paddingM),
          child: GptMarkdown(entry.content),
        );

      // Image entry
      case MediaContentType.image:
        return CoveringNetworkImage(entry.content);

      // Github entry
      case MediaContentType.github:
        return XContainer(
          padding: EdgeInsets.all(XLayout.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GptMarkdown(
                  "From the project's github [README.md](${entry.content}):"),
              XLayout.verticalM,
              FutureBuilder<String>(
                future: api.fetchFile(
                  Uri.parse(entry.content),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("media_content_github_error".tr);
                  }
                  if (!snapshot.hasData) {
                    return Text("media_content_github_no_data".tr);
                  }
                  return XContainer(
                    color: context.theme.canvasColor,
                    enableShadow: false,
                    padding: EdgeInsets.all(XLayout.paddingM),
                    child: GptMarkdownTheme(
                      gptThemeData: GptMarkdownThemeData(
                        brightness: context.theme.brightness,
                      ),
                      child: GptMarkdown(
                        snapshot.data!,
                        style: context.textTheme.bodyMedium!.copyWith(
                            fontFamily: ThemeService.codeFontFamily,
                            fontSize:
                                context.textTheme.bodyMedium!.fontSize! - 2),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );

      // Default entry (empty)
      default:
        return const SizedBox();
    }
  }
}
