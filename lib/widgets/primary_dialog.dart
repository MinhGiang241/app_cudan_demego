import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../generated/l10n.dart';
import 'primary_button.dart';
import 'primary_icon.dart';

enum DialogType { success, error, alert, custom }

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.title = '',
    this.msg,
    this.code,
    this.content,
    this.useBackground = false,
    this.onClose,
    this.customIcons,
    this.type = DialogType.custom,
  });

  final String? title;
  final String? msg;
  final int? code;
  final Widget? content;
  final PrimaryIcon? customIcons;
  final DialogType type;
  final bool useBackground;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 0,
        insetAnimationCurve: Curves.bounceInOut,
        insetPadding: const EdgeInsets.all(40),
        child: Container(
          decoration: BoxDecoration(
            color:
                useBackground ? backgroundColor : Colors.white.withOpacity(0.9),
            border: Border.all(color: Colors.white54, width: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  vpad(24),
                  if (type == DialogType.custom && customIcons != null)
                    customIcons!,
                  if (type != DialogType.custom)
                    PrimaryIcon(
                      icons: type == DialogType.success
                          ? PrimaryIcons.check
                          : PrimaryIcons.error,
                      color: Colors.white,
                      style: PrimaryIconStyle.gradient,
                      gradients: type == DialogType.success
                          ? PrimaryIconGradient.green
                          : PrimaryIconGradient.red,
                      size: 32,
                      padding: const EdgeInsets.all(12),
                    ),
                  if (type != DialogType.custom) vpad(16),
                  if (type == DialogType.custom && customIcons != null)
                    vpad(16),
                  if (title != null)
                    Text(
                      _title(),
                      style: txtDisplayMedium(),
                      textAlign: TextAlign.center,
                    ),
                  if (title != null) vpad(16),
                  if (type != DialogType.custom)
                    code == null
                        ? Text(
                            msg ?? "",
                            style: txtBodySmallRegular(),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            errorCodeToString(context, code),
                            style: txtBodySmallRegular(),
                            textAlign: TextAlign.center,
                          ),
                  if (type != DialogType.custom) vpad(20),
                  if (type != DialogType.custom)
                    PrimaryButton(
                      text: S.of(context).close,
                      buttonSize: ButtonSize.medium,
                      onTap: () {
                        Navigator.pop(context);

                        if (onClose != null) {
                          onClose!();
                        }

                        // Navigator.pop(context);
                      },
                    ),
                  if (content != null) content!,
                  vpad(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _title() {
    switch (type) {
      case DialogType.success:
        return S.current.success;
      case DialogType.error:
        return S.current.failure;
      default:
        return title ?? '';
    }
  }

  String errorCodeToString(BuildContext context, int? code) {
    switch (code) {
      // case 1:
      //   return S.of(context).reg_success;
      // case 2:
      //   return S.of(context).missing;
      // case 3:
      //   return S.of(context).not_match;
      // case 4:
      //   return S.of(context).val_pass;
      // case 5:
      //   return S.of(context).account_existed;
      // case 7:
      //   return S.of(context).account_not_avaiable;
      // case 8:
      //   return S.of(context).invalid_code;
      // case 9:
      //   return S.of(context).systeme_error;
      // case 10:
      //   return S.of(context).card_exist;
      default:
        return "[Code : $code]";
    }
  }
}

class PrimaryDialog extends CustomDialog {
  const PrimaryDialog.success({Key? key, String? msg, Function()? onClose})
      : super(type: DialogType.success, msg: msg, key: key, onClose: onClose);
  const PrimaryDialog.error({Key? key, String? msg, Function()? onClose})
      : super(type: DialogType.error, msg: msg, key: key, onClose: onClose);
  const PrimaryDialog.errorCode({Key? key, int? code})
      : super(type: DialogType.error, code: code, key: key);
  const PrimaryDialog.custom({
    Key? key,
    String? title,
    Widget? content,
    PrimaryIcon? customIcons,
    bool useBackground = false,
  }) : super(
          customIcons: customIcons,
          type: DialogType.custom,
          key: key,
          title: title,
          useBackground: useBackground,
          content: content,
        );
}
