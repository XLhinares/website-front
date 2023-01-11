import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "package:get/get.dart";
import "package:url_launcher/url_launcher.dart";
import "package:x_containers/x_containers.dart";

import "../../components/components.dart";
import "../../utils/globals.dart";
import "../../widgets/widgets.dart";

/// A template tab to display the required legal mentions of the website.
class TabLegal extends StatelessWidget {
  // VARIABLES =================================================================

  /// The title of the tab.
  final String title;

  /// The text to write in the legal section.
  final String text;

  /// A widget to display at the end of the tab.
  final Widget? appendix;

  // CONSTRUCTOR ===============================================================

  /// Returns a [TabLegal] matching the given parameters.
  const TabLegal({
    super.key,
    required this.title,
    required this.text,
    this.appendix,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ScaffoldFit(
      alignment: Alignment.topCenter,
      background: const AnimatedBackground(
        scale: 0.3,
      ),
      // overlay: ButtonsOverlay(),
      padding: EdgeInsets.symmetric(horizontal: XLayout.paddingL),
      body: IfAppIsReady(
        child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
            children: [
              XContainer(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => router.pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          title,
                          style: context.theme.appBarTheme.titleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              XLayout.verticalL,
              XContainer(
                padding: EdgeInsets.zero,
                child: Markdown(
                  data: text,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(XLayout.paddingL),
                  selectable: true,
                  shrinkWrap: true,
                  softLineBreak: false,
                  styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                  styleSheet: MarkdownStyleSheet(
                    blockSpacing: XLayout.paddingM,
                    h2: context.textTheme.titleLarge,
                  ),
                  onTapLink: (text, href, title) async {
                    if (href == null) return;
                    final link = Uri.parse(href);

                    if (link.host == "xeppelin.org") {
                      // The link matches a route.
                      router.push(path: link.path.replaceAll("/#", ""));
                    } else {
                      // The link redirects to another website.
                      if (await canLaunchUrl(link)) {
                        await launchUrl(link);
                      } else {
                        throw "Could not launch $link";
                      }
                    }
                  },
                ),
              ),
              if (appendix != null)
                Padding(
                  padding: EdgeInsets.only(top: XLayout.paddingM),
                  child: appendix!,
                ),
            ]),
      ),
    );
  }

// WIDGETS ===================================================================

}
