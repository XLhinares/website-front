import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import '../../text/preset_styles.dart';
import "../../text/preset_text.dart";
import "contact_field.dart";

/// The content of the body in the "Projects" mode.
class BodyContact extends StatelessWidget {

  // VARIABLES =================================================================

  final GlobalKey<FormState> _formKey = GlobalKey();

  /// The controller managing the "name" field.
  final TextEditingController _controllerName = TextEditingController();
  final FocusNode _nodeName = FocusNode();

  /// The controller managing the "email" field.
  final TextEditingController _controllerEmail = TextEditingController();
  final FocusNode _nodeEmail = FocusNode();
  /// The controller managing the "subject" field.
  final TextEditingController _controllerSubject = TextEditingController();
  final FocusNode _nodeSubject = FocusNode();
  /// The controller managing the "contents" field.
  final TextEditingController _controllerDetails = TextEditingController();
  final FocusNode _nodeDetails = FocusNode();
  // CONSTRUCTOR ===============================================================

  /// Returns a [BodyContact] matching the given parameters.
  BodyContact({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(XLayout.paddingM),
        shrinkWrap: true,
        children: [

          // PRESENTATION --------------------------------------------------------
          XCard(
            padding: EdgeInsets.all(XLayout.paddingM),
            title: PresetText.headline("Contact form".tr,),
            subtitle: PresetText.body("Contact form explanation".tr,),
          ),

          XLayout.verticalM,

          // FORM ----------------------------------------------------------------
          XContainer(
            padding: EdgeInsets.all(XLayout.paddingM),
            child: FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  ContactField(
                    title: "Name".tr,
                    controller: _controllerName,
                    focusNode: _nodeName,
                  ),

                  XLayout.verticalM,

                  ContactField(
                    title: "Email".tr,
                    controller: _controllerEmail,
                    validator: (value) => GetUtils.isEmail(value ?? "")
                        ? null
                        : "Email validation".tr,
                    focusNode: _nodeEmail,
                  ),

                  XLayout.verticalM,

                  ContactField(
                    title: "Subject".tr,
                    controller: _controllerSubject,
                    focusNode: _nodeSubject,
                  ),

                  XLayout.verticalM,

                  ContactField(
                    title: "Details".tr,
                    maxLines: 10,
                    controller: _controllerDetails,
                    focusNode: _nodeDetails,
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
            ),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================

}
