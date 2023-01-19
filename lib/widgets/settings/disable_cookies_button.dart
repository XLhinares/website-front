import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/utils.dart";

/// A button allowing the user to delete and disable the cookies.
class DisableCookiesButton extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [DisableCookiesButton] matching the given parameters.
  const DisableCookiesButton({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XInkContainer(
      padding: EdgeInsets.all(XLayout.paddingS),
      color: context.theme.colorScheme.secondary,
      enableShadow: false,
      onTap: () {
        settings.cookies.value = false;
        XSnackbar.text(
          maxWidth: maxSnackbarLength,
          title: "Done.".tr,
          content: "Your cookies were deleted and disabled.".tr,
        ).show(context);
      },
      child: Text(
        "Disable cookies".tr,
        style: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

// WIDGETS ===================================================================

}
