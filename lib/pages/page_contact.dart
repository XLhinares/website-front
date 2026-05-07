import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../globals.dart";
import "../utils/extensions.dart";
import "../widgets/contact/contact_column.dart";
import "../widgets/layout/scaffold_fit.dart";
import "meta/if_app_is_ready.dart";

/// The
class PageContact extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [PageContact] matching the given parameters.
  const PageContact({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ScaffoldFit(
      frameRatio: frameRatioMobile,
      padding: EdgeInsets.symmetric(horizontal: XLayout.paddingL),
      // overlay: ButtonsOverlay(),
      body: IfAppIsReady(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
            children: [
              // TITLE --------------------------------------------------------
              XCard.text(
                title: "contact_form_title".tr,
                content: "contact_form_description".tr,
                leading: GestureDetector(
                  onTap: router.goBack,
                  child: Icon(
                    Icons.arrow_back,
                    size: XLayout.paddingL * 1.5,
                    color: context.colors.secondary,
                  ),
                ),
              ),

              XLayout.verticalL,
              // CONTENTS -----------------------------------------------------
              XContainer(child: ContactColumn()),
            ],
          ),
        ),
      ),
    );
  }
}
