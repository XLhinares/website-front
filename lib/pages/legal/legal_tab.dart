import "package:flutter/material.dart";
import "package:flutter_markdown_plus/flutter_markdown_plus.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../components/misc/if_app_is_ready.dart";
import "../../globals.dart";
import "../../utils/tools.dart";
import "../../widgets/animations/loading_indicator.dart";
import "../../widgets/layout/scaffold_fit.dart";

/// A template tab to display the required legal mentions of the website.
class TabLegal extends StatelessWidget {
  // VARIABLES =================================================================

  /// The title of the tab.
  final String title;

  /// The text to write in the legal section.
  final Future<String> content;

  /// A widget to display at the end of the tab.
  final Widget? appendix;

  // CONSTRUCTOR ===============================================================

  /// Returns a [TabLegal] matching the given parameters.
  const TabLegal({
    super.key,
    required this.title,
    required this.content,
    this.appendix,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ScaffoldFit(
      alignment: Alignment.topCenter,
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
                      onPressed: () => router.goBack(),
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
                padding: EdgeInsets.all(XLayout.paddingM),
                child: FutureBuilder<String>(
                    future: content,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text("legal_content_error".tr);
                      }
                      if (!snapshot.hasData) {
                        return Text("legal_content_error".tr);
                      }

                      return MarkdownBody(
                        data: snapshot.data!.withXeppelinMD,
                        styleSheet: app.themes.markdownStyle,
                      );
                    }),
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
