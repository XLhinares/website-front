import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/exports.dart";
import "../interactables/x_flat_button.dart";

/// A button allowing the user to delete and disable the cookies.
class DisableCookiesButton extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [DisableCookiesButton] matching the given parameters.
  const DisableCookiesButton({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XFlatButton.text(
      padding: EdgeInsets.all(XLayout.paddingS),
      onTap: () {
        cookies.cookies.value = false;
        XSnackbar.text(
          maxWidth: maxSnackbarLength,
          title: "settings_disable_cookie_snackbar_title".tr,
          content: "settings_disable_cookie_snackbar_content".tr,
        ).show(context);
      },
      text: "settings_disable_cookies".tr,
      // textStyle: context.textTheme.labelMedium?.copyWith(
      //   fontWeight: FontWeight.w500,
      // ),
    );
  }

// WIDGETS ===================================================================
}
