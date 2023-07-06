import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class PushNotificationDialogComponents {
  static Row createActionButtons(
    BuildContext context, {
    required String? url,
    required bool hasAlertType,
    required bool hasDeviceType,
    required bool isAlertDetailsJsonAvailable,
    required void Function() onTapDismiss,
    required Future<bool> Function(String url)
        onTapGoToLink, // async function that takes in url and returns void
    required void Function() onTapMoreDetails,
  }) {
    // go to url button
    final hasGoToUrlButton = url != null && url.isNotEmpty;
    // more details button
    final hasMoreDetailsButton =
        hasAlertType && hasDeviceType && isAlertDetailsJsonAvailable;
    // dismiss dialog button text
    var dismissButtonText = !hasGoToUrlButton && !hasMoreDetailsButton
        ? LocaleUtil.getString(
            context,
            LocaleUtil.DIALOG_ACTION_BUTTON_OK,
          )!
        : LocaleUtil.getString(
            context,
            LocaleUtil.DIALOG_ACTION_BUTTON_DISMISS,
          )!;

    final List<Widget> widgets = [];
    // add button to dismiss dialog
    widgets.add(
      createDismissButton(
        context: context,
        dismissButtonText: dismissButtonText.toUpperCase(),
        onTapDismiss: onTapDismiss,
      ),
    );

    // add button to go to url
    if (hasGoToUrlButton) {
      widgets.add(createGoToLinkButton(
        context: context,
        url: url,
        onTapGoToLink: onTapGoToLink,
      ));
    }

    // add button to go to more details (enhanced push - alert details)
    if (hasMoreDetailsButton) {
      widgets.add(
        createMoreDetailsButton(
          context: context,
          onTapMoreDetails: onTapMoreDetails,
        ),
      );
    }

    return Row(children: [Spacer(), ...widgets]);
  }

  /// Dismiss Button
  static Widget createDismissButton({
    required BuildContext context,
    required String dismissButtonText,
    required void Function() onTapDismiss,
  }) {
    return TextButton(
      child: new Text(
        dismissButtonText,
        style: textStyle_size_14_bold_color_deep_purple(),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        onTapDismiss();
      },
    );
  }

  /// Go Link Button
  static Widget createGoToLinkButton({
    required BuildContext context,
    required String url,
    required Future<void> Function(String url)
        onTapGoToLink, // async function that takes in url and returns void
  }) {
    return TextButton(
      child: new Text(
        LocaleUtil.getString(
                context, LocaleUtil.DIALOG_ACTION_BUTTON_GO_TO_LINK)!
            .toUpperCase(),
        style: textStyle_size_14_bold_color_deep_purple(),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () async {
        await onTapGoToLink(url);
      },
    );
  }

  /// Details Button
  static Widget createMoreDetailsButton({
    required BuildContext context,
    required void Function() onTapMoreDetails,
  }) {
    return TextButton(
      child: new Text(
        LocaleUtil.getString(context, LocaleUtil.DIALOG_ACTION_MORE_DETAILS)!
            .toUpperCase(),
        style: textStyle_size_14_bold_color_deep_purple(),
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () {
        onTapMoreDetails();
      },
    );
  }
}
