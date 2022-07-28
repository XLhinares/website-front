// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";

// Project dependencies
import "package:website_front/classes/services/app_mode.dart";
import "package:website_front/utils/globals.dart";
import "package:website_front/widgets/body/contact/content_contact.dart";
import "package:website_front/widgets/body/home/content_home.dart";
import "package:website_front/widgets/body/projects/content_projects.dart";

/// What's inside the body. It depends on the current mode.
class BodyContents extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BodyContents] matching the given parameters.
  const BodyContents({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: sps,
      builder: (_) {
        switch (sps.mode) {
          case AppMode.home:
            return const BodyContentsHome();
          case AppMode.projects:
            return BodyContentsProjects();
          case AppMode.contact:
            return BodyContentsContact();
          default:
            return Center(
              child: Text("How did we get there?".tr),
            );
        }
      },
    );
  }

  // METHODS ===================================================================

  // todo: a way to handle scroll
  /// How to behave when the contents are scrolled.
  void onScroll () {}

}
