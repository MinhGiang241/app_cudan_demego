// ignore_for_file: require_trailing_commas

import 'package:app_cudan/constants/regex_text.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_auth.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import 'otp_add_email_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);
  static const routeName = '/info';

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var userInfo = context.watch<ResidentInfoPrv>().userInfo!;
    List<InfoContentView> listInfoView = [
      InfoContentView(
          isHorizontal: true,
          title: S.current.full_name,
          content: userInfo.account?.fullName ?? userInfo.info_name ?? "",
          contentStyle: userInfo.account?.fullName != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : const TextStyle(
                  fontFamily: family,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          isHorizontal: true,
          title: S.current.phone_num,
          content: userInfo.account?.phone_number ?? "",
          contentStyle: userInfo.account?.phone_number != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : const TextStyle(
                  fontFamily: family,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),

      InfoContentView(
          isHorizontal: true,
          title: S.current.email,
          widget: userInfo.account?.email == null
              ? InkWell(
                  onTap: () {
                    Utils.showDialog(
                        context: context,
                        dialog: PrimaryDialog.custom(
                          title: S.of(context).add_email,
                          content: Column(children: [
                            PrimaryTextField(
                              controller: emailcontroller,
                              isRequired: true,
                              label: S.of(context).email,
                              hint: S.of(context).email,
                            ),
                            vpad(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PrimaryButton(
                                  text: S.of(context).close,
                                  buttonSize: ButtonSize.medium,
                                  buttonType: ButtonType.secondary,
                                  secondaryBackgroundColor: redColor4,
                                  textColor: redColorBase,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                PrimaryButton(
                                  buttonSize: ButtonSize.medium,
                                  text: S.of(context).add_new,
                                  onTap: () async {
                                    if (emailcontroller.text.trim().isEmpty) {
                                      Utils.showErrorMessage(
                                        context,
                                        S.of(context).email_not_empty,
                                      );
                                    } else if (!RegexText.isEmail(
                                      emailcontroller.text.trim(),
                                    )) {
                                      Utils.showErrorMessage(
                                        context,
                                        S.of(context).not_email,
                                      );
                                    } else {
                                      Navigator.pop(context);
                                      await APIAuth.sendOtpAddMoreEmail(
                                              emailcontroller.text.trim(),
                                              true,
                                              context
                                                      .read<ResidentInfoPrv>()
                                                      .userInfo
                                                      ?.account
                                                      ?.id ??
                                                  "")
                                          .then((v) {
                                        Utils.showBottomSheet(
                                          context: context,
                                          child: Container(
                                            color: (backgroundColor),
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: OtpAddEmailScreen(
                                              acc: userInfo.account!,
                                              email: emailcontroller,
                                              isAddNew:
                                                  userInfo.account?.email ==
                                                          null
                                                      ? true
                                                      : false,
                                            ),
                                          ),
                                        );
                                      }).catchError((e) {
                                        Utils.showErrorMessage(context, e);
                                      });
                                    }
                                  },
                                ),
                              ],
                            )
                          ]),
                        ));
                  },
                  child: Text(
                    S.current.add,
                    style: const TextStyle(
                        fontFamily: family,
                        color: primaryColorBase,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ))
              : Row(children: [
                  Expanded(
                    child: Text(
                      userInfo.account?.email ?? "",
                      style: const TextStyle(
                          fontFamily: family,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  hpad(5),
                  InkWell(
                    onTap: () {
                      Utils.showDialog(
                          context: context,
                          dialog: PrimaryDialog.custom(
                            title: S.of(context).edit,
                            content: Column(children: [
                              PrimaryTextField(
                                controller: emailcontroller,
                                isRequired: true,
                                label: S.of(context).email,
                                hint: S.of(context).email,
                              ),
                              vpad(16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  PrimaryButton(
                                    text: S.of(context).close,
                                    buttonSize: ButtonSize.medium,
                                    buttonType: ButtonType.secondary,
                                    secondaryBackgroundColor: redColor4,
                                    textColor: redColorBase,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  PrimaryButton(
                                    buttonSize: ButtonSize.medium,
                                    text: userInfo.account?.email == null
                                        ? S.of(context).add_new
                                        : S.of(context).update,
                                    onTap: () async {
                                      if (emailcontroller.text.trim().isEmpty) {
                                        Utils.showErrorMessage(
                                          context,
                                          S.of(context).email_not_empty,
                                        );
                                      } else if (!RegexText.isEmail(
                                        emailcontroller.text.trim(),
                                      )) {
                                        Utils.showErrorMessage(
                                          context,
                                          S.of(context).not_email,
                                        );
                                      } else if (emailcontroller.text.trim() ==
                                          context
                                              .read<ResidentInfoPrv>()
                                              .userInfo
                                              ?.account
                                              ?.email) {
                                        Utils.showErrorMessage(
                                          context,
                                          S.of(context).email_not_same,
                                        );
                                      } else {
                                        Navigator.pop(context);
                                        Utils.showSnackBar(context,
                                            S.of(context).send_email_wait);
                                        await APIAuth.sendOtpAddMoreEmail(
                                                emailcontroller.text.trim(),
                                                false,
                                                context
                                                        .read<ResidentInfoPrv>()
                                                        .userInfo
                                                        ?.account
                                                        ?.id ??
                                                    "")
                                            .then((v) {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          Utils.showBottomSheet(
                                            context: context,
                                            child: Container(
                                              color: backgroundColor,
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: OtpAddEmailScreen(
                                                acc: userInfo.account!,
                                                email: emailcontroller,
                                                isAddNew:
                                                    userInfo.account?.email ==
                                                            null
                                                        ? true
                                                        : false,
                                              ),
                                            ),
                                          );
                                        }).catchError((e) {
                                          Utils.showErrorMessage(context, e);
                                        });
                                      }
                                    },
                                  ),
                                ],
                              )
                            ]),
                          ));
                    },
                    child: userInfo.account?.email == null
                        ? Text(
                            userInfo.account?.email == null
                                ? S.current.add
                                : S.current.edit,
                            style: const TextStyle(
                                fontFamily: family,
                                color: primaryColorBase,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )
                        : const Icon(
                            Icons.edit,
                            color: primaryColorBase,
                          ),
                  )
                ]),
          content: userInfo.account?.email ?? "",
          contentStyle: userInfo.account?.email != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
      InfoContentView(
          isHorizontal: true,
          title: S.current.possessed_apartment,
          content: context.read<ResidentInfoPrv>().listOwn.isNotEmpty
              ? context
                  .read<ResidentInfoPrv>()
                  .listOwn
                  .where((c) => c.type == "BUY")
                  .length
                  .toString()
              : "0",
          contentStyle: userInfo.account?.phone_number != null
              ? const TextStyle(
                  fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
              : TextStyle(
                  fontFamily: family,
                  color: Colors.black.withOpacity(0.3),
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),

      // InfoContentView(
      //     title: " S.current.gender",
      //     content: _genderString(context, userInfo?.sex),
      //     contentStyle: userInfo?.sex != null
      //         ? const TextStyle(
      //             fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
      //         : TextStyle(
      //             fontFamily: family,
      //             color: Colors.black.withOpacity(0.3),
      //             fontSize: 14,
      //             fontWeight: FontWeight.w600)),
      // InfoContentView(
      //     title: "S.current.country",
      //     content: userInfo?.national ?? "S.of(context).not_update",
      //     contentStyle: userInfo?.national != null
      //         ? const TextStyle(
      //             fontFamily: family, fontSize: 14, fontWeight: FontWeight.w600)
      //         : TextStyle(
      //             fontFamily: family,
      //             color: Colors.black.withOpacity(0.3),
      //             fontSize: 14,
      //             fontWeight: FontWeight.w600),

      //             ),
    ];
    return PrimaryScreen(
      appBar: PrimaryAppbar(title: S.of(context).personal_info),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PrimaryInfoWidget(
                    listInfoView: listInfoView,
                    label: S.of(context).info,
                  )),
              vpad(100)
            ],
          ),
        ],
      ),
    );
  }

  String _genderString(BuildContext context, String? gen) {
    if (gen == "Male") {
      return S.of(context).male;
    }
    if (gen == "Female") {
      return S.of(context).female;
    }
    if (gen == "Other") {
      return S.of(context).other_gender;
    }
    return "S.of(context).not_update";
  }
}
