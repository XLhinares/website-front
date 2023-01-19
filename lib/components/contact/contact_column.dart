import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/globals.dart";
import "../../utils/tools.dart";
import "contact_field.dart";

/// The traversable column which contains all the contact fields.
class ContactColumn extends StatelessWidget {
  // VARIABLES =================================================================

  final GlobalKey<FormState> _formKey = GlobalKey();

  /// The controller managing the "name" field.
  final TextEditingController _controllerName = TextEditingController();

  /// The controller managing the "email" field.
  final TextEditingController _controllerEmail = TextEditingController();

  /// The controller managing the "subject" field.
  final TextEditingController _controllerSubject = TextEditingController();

  /// The controller managing the "contents" field.
  final TextEditingController _controllerDetails = TextEditingController();

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ContactColumn] matching the given parameters.
  ContactColumn({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ContactField(
              title: "Name".tr,
              controller: _controllerName,
            ),
            XLayout.verticalM,
            ContactField(
              title: "Email".tr,
              controller: _controllerEmail,
              validator: (value) =>
                  GetUtils.isEmail(value ?? "") ? null : "Email validation".tr,
            ),
            XLayout.verticalM,
            ContactField(
              title: "Subject".tr,
              controller: _controllerSubject,
            ),
            XLayout.verticalM,
            ContactField(
              title: "Details".tr,
              maxLines: 10,
              controller: _controllerDetails,
              textInputAction: null,
            ),
            XLayout.verticalM,
            XInkContainer(
              onTap: () => sendEmail(context),
              // onTap: sendEmail,
              color: context.theme.colorScheme.secondary,
              child: Text("Send".tr),
            ),
          ],
        ),
      ),
    );
  }

  // METHODS ===================================================================

  /// Send an email with the given info to the support.
  Future<void> sendEmail(BuildContext context) async => tryWrapper(
        () async {
          // Aborts if all the fields are not valid.
          if (!(_formKey.currentState?.validate() ?? false)) return;

          bool success = await api.sendSupportMail(
            name: _controllerName.text,
            email: _controllerEmail.text,
            subject: _controllerSubject.text,
            details: _controllerDetails.text,
          );

          // if (!context.mounted) return;
          if (success) {
            //ignore: use_build_context_synchronously
            XSnackbar.text(
              title: "Email sent.".tr,
              content: "I'll get back to you as soon as possible :)".tr,
              titleStyle: Get.context?.textTheme.headlineMedium,
              contentStyle: Get.context?.textTheme.bodyMedium,
              maxWidth: 1024,
            ).show(context);
          } else {
            //ignore: use_build_context_synchronously
            XSnackbar.text(
              title: "There was an error.".tr,
              content: "Email error content.".tr,
              titleStyle: Get.context?.textTheme.headlineMedium,
              contentStyle: Get.context?.textTheme.bodyMedium,
              maxWidth: 1024,
            ).show(context);
          }
        },
        errorMessage: "There was an error while sending the mail.",
        then: (success) {
          if (success) return;

          XSnackbar.text(
            title: "Could not send the email.".tr,
            content: "There was an error, please try again later.".tr,
            titleStyle: Get.context?.textTheme.headlineMedium,
            contentStyle: Get.context?.textTheme.bodyMedium,
            maxWidth: 1024,
          ).show(context);
        },
      );
}
