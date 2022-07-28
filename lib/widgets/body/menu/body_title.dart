// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

// Project dependencies
import "package:website_front/utils/globals.dart";
import "package:website_front/widgets/images/xequiche_logo.dart";

/// An animated title for the body.
class BodyTitle extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BodyTitle] matching the given parameters.
  const BodyTitle({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [

        // ANIMATED ICON -------------------------------------------------------
        GetBuilder(
          init: sps,
          builder: (_) => AnimatedSize(
            duration: animationDuration,
            child: AnimatedSwitcher(
              duration: animationDuration,
              child: sps.atHome
                  ? const SizedBox()
                  : Padding(
                padding: EdgeInsets.only(right: XLayout.paddingXS),
                child: XequicheLogo(
                  size: 2 * XLayout.paddingL,
                )
              ),
            ),
          ),
        ),

        // TEXT ----------------------------------------------------------------
        Expanded(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text("Xequiche",
              style: context.theme.appBarTheme.titleTextStyle
            ),
          ),
        ),
      ],
    );
  }

}
