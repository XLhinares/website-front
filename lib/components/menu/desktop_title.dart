import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../../utils/globals.dart";
import "../../widgets/widgets.dart";

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
          init: router,
          builder: (_) => AnimatedSize(
            duration: animDurationShort,
            child: AnimatedSwitcher(
              duration: animDurationShort,
              child: router.atHome
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(right: XLayout.paddingXS),
                      child: XeppelinLogo(
                        size: 2 * XLayout.paddingL,
                      )),
            ),
          ),
        ),

        // TEXT ----------------------------------------------------------------
        Expanded(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              "Xeppelin",
              style: context.textTheme.displayLarge,
            ),
          ),
        ),
      ],
    );
  }
}
