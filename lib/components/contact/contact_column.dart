// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/widgets.dart";
import "contact_field.dart";

/// The traversable column which contains all the contact fields.
class ContactColumn extends StatelessWidget {

  // VARIABLES =================================================================

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
  ContactColumn({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
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
            validator: (value) => GetUtils.isEmail(value ?? "")
                ? null
                : "Email validation".tr,
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
            onTap: () {
              XSnackbar.text(
                title: "Sorry, it doesn't work just yet.",
                message: "This should be working by Oct. 1st, so be sure to come back :)",
                titleStyle: PresetStyle.headline.getStyle(context),
                messageStyle: PresetStyle.body.getStyle(context),
              ).show();
            },
            color: context.theme.colorScheme.secondary,
            child: const Text("Send"),
          ),

        ],
      ),
    );
  }

  // METHODS ===================================================================

}
