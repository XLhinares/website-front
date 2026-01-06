import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";
import "../../utils/tools.dart";
import "contact_field.dart";

/// The traversable column which contains all the contact fields.
class ContactColumnExpanded extends StatelessWidget {
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

  /// Returns an instance of [ContactColumnExpanded] matching the given parameters.
  ContactColumnExpanded({
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
          children: [
            ContactField(
              title: "contact_name".tr,
              controller: _controllerName,
            ),
            XLayout.verticalM,
            ContactField(
              title: "contact_email".tr,
              controller: _controllerEmail,
              validator: (value) => GetUtils.isEmail(value ?? "")
                  ? null
                  : "contact_email_invalid".tr,
            ),
            XLayout.verticalM,
            ContactField(
              title: "contact_subject".tr,
              controller: _controllerSubject,
            ),
            XLayout.verticalM,
            ContactField(
              title: "contact_details".tr,
              maxLines: 5,
              controller: _controllerDetails,
              textInputAction: null,
            ),
            XLayout.verticalM,
            XButton(
              onTap: () => sendEmail(context),
              // onTap: sendEmail,
              color: context.theme.colorScheme.secondary,
              child: Text("contact_send".tr),
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

          if (!context.mounted) return;
          if (success) {
            //ignore: use_build_context_synchronously
            XSnackbar.text(
              title: "contact_mail_sent_success_title".tr,
              content: "contact_mail_sent_success_content".tr,
              titleStyle: Get.context?.textTheme.headlineMedium,
              contentStyle: Get.context?.textTheme.bodyMedium,
              maxWidth: 1024,
            ).show(context);
          } else {
            //ignore: use_build_context_synchronously
            XSnackbar.text(
              title: "contact_mail_sent_failure_title".tr,
              content: "contact_mail_sent_failure_content".tr,
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
            title: "contact_mail_sent_failure_title".tr,
            content: "contact_mail_sent_failure_content".tr,
            titleStyle: Get.context?.textTheme.headlineMedium,
            contentStyle: Get.context?.textTheme.bodyMedium,
            maxWidth: 1024,
          ).show(context);
        },
      );
}
