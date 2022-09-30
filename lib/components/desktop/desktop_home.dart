import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/widgets.dart";

/// The content of the body in the "Home" mode.
class BodyContentsHome extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [BodyContentsHome] matching the given parameters.
  const BodyContentsHome({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        // FIRST BLOCK ---------------------------------------------------------
        Expanded(
          child: XContainer(
            padding: EdgeInsets.all(3 * XLayout.paddingL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                XequicheLogo(
                  size: 8 * XLayout.paddingL,
                ),
              ],
            ),
          ),
        ),

        XLayout.horizontalM,

        // SECOND BLOCK --------------------------------------------------------
        // todo: occuper l'espace en haut à droite avec qqch.
        Expanded(
          child: XContainer(
            margin: EdgeInsets.only(top: Get.height * 0.3),
            padding: EdgeInsets.all(XLayout.paddingL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoColorText("Home description 1".tr,
                  defaultStyle: PresetStyle.headline.getStyle(context),
                ),
                // XLayout.verticalM,
                // AutoColorText("I also make %bc art%.".tr,
                //   defaultStyle: context.textTheme.titleMedium,
                // ),
              ],
            ),
          ),
        ),

      ],
    );
  }

// METHODS ===================================================================

}
