import 'package:app_cudan/models/hand_over.dart';
import 'package:app_cudan/models/response_resident_own.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_hand_over.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_icon.dart';
import '../hand_over_screen.dart';
import '../send_otp_hand_over.dart';

class BookingPrv extends ChangeNotifier {
  BookingPrv({this.schedule}) {
    if (schedule != null) {
      handOverDate = DateTime.tryParse(schedule?.date ?? "") != null
          ? DateTime.parse(schedule?.date ?? "")
          : null;
      handOverTime = schedule!.hour != null
          ? TimeOfDay(
              hour: int.parse(schedule!.hour!.split(":")[0]),
              minute: int.parse(schedule!.hour!.split(":")[1]),
            )
          : null;
      handOverDateController.text = Utils.dateFormat(schedule?.date ?? "", 1);
      handOverTimeController.text = schedule?.time ?? "";
      // customer = schedule?.c;
      apartmentValue = schedule?.apartmentId;
    }
  }

  AppointmentSchedule? schedule;

  final TextEditingController handOverDateController = TextEditingController();
  final TextEditingController handOverTimeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  String? apartmentValue;

  String? validateHandOverDate;
  String? validateHandOverTime;
  String? validateApartment;
  String? validateReason;

  DateTime? handOverDate;
  TimeOfDay? handOverTime;

  bool isSendLoading = false;
  // Customer? customer;
  List<Apartment> apartmentList = [];

  final formKey = GlobalKey<FormState>();
  final formKeyReason = GlobalKey<FormState>();
  bool autoValid = false;

  genReasonValidateString() {
    if (reasonController.text.trim().isEmpty) {
      validateReason = S.current.not_blank;
    } else {
      validateReason = null;
    }
  }

  cancel(BuildContext context, String? status) {
    if (status == "WAIT" || status == 'APPROVEDFIRST') {
      Utils.showConfirmMessage(
        context: context,
        title: S.of(context).can_schedule,
        content: S.of(context).confirm_can_schedule(
              "${schedule?.a?.name}-${schedule?.a?.f?.name}-${schedule?.a?.b?.name}",
            ),
        onConfirm: () {
          Navigator.pop(context);
          APIHandOver.saveApointmentScheduleList(
            schedule!
                .copyWith(
                  cancel_reason: "NGUOIDUNGHUY",
                  status: "CANCEL",
                  // cancel_note: reasonController.text,
                )
                .toMap(),
          ).then((v) {
            Utils.showSuccessMessage(
              context: context,
              e: S.of(context).success_can_schedule(
                    "${schedule?.a?.name}-${schedule?.a?.f?.name}-${schedule?.a?.b?.name}",
                  ),
              onClose: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  HandOverScreen.routeName,
                  (route) => route.isFirst,
                  arguments: {
                    "init": 0,
                  },
                );
              },
            );
          }).catchError((e) {
            Utils.showErrorMessage(context, e);
          });
        },
      );
    }
    if (status == 'APPROVEDSECOND') {
      // Utils.showConfirmMessage(
      //   context: context,
      //   title: S.of(context).can_schedule,
      //   content: S.of(context).confirm_can_schedule(
      //         "${schedule?.a?.name}-${schedule?.a?.f?.name}-${schedule?.a?.b?.name}",
      //       ),
      //   onConfirm: () {
      //     Navigator.pop(context);
      Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.custom(
          content: StatefulBuilder(
            builder: (context, setState) => Form(
              key: formKeyReason,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: () {
                if (formKeyReason.currentState!.validate()) {
                  genReasonValidateString();
                  setState(() {});
                } else {
                  genReasonValidateString();
                  setState(() {});
                }
              },
              child: Column(
                children: [
                  PrimaryTextField(
                    label: S.of(context).cancel_reason,
                    isRequired: true,
                    controller: reasonController,
                    validateString: validateReason,
                    validator: Utils.emptyValidator,
                    maxLines: 3,
                  ),
                  vpad(12),
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: PrimaryButton(
                          buttonSize: ButtonSize.medium,
                          buttonType: ButtonType.red,
                          text: S.of(context).cancel,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(flex: 1, child: hpad(0)),
                      Expanded(
                        flex: 10,
                        child: PrimaryButton(
                          text: S.of(context).confirm,
                          onTap: () {
                            if (formKeyReason.currentState != null &&
                                formKeyReason.currentState!.validate()) {
                              // Navigator.pop(context);
                              APIHandOver.saveApointmentScheduleList(
                                schedule!
                                    .copyWith(
                                      cancel_reason: "NGUOIDUNGHUY",
                                      status: "CANCEL",
                                      cancel_note: reasonController.text,
                                    )
                                    .toMap(),
                              ).then((v) {
                                Utils.showSuccessMessage(
                                  context: context,
                                  e: S.of(context).success_can_schedule(
                                        "${schedule?.a?.name}-${schedule?.a?.f?.name}-${schedule?.a?.b?.name}",
                                      ),
                                  onClose: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      HandOverScreen.routeName,
                                      (route) => route.isFirst,
                                      arguments: {
                                        "init": 0,
                                      },
                                    );
                                  },
                                );
                              }).catchError((e) {
                                Utils.showErrorMessage(context, e);
                              });
                            }
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
      //   },
      // );
    }
  }

  reBook(BuildContext context) {
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).change_schedule,
      content: S.of(context).confirm_change_schedule(
            "${schedule?.a?.name}-${schedule?.a?.f?.name}-${schedule?.a?.b?.name}",
          ),
      onConfirm: () {
        Navigator.pop(context);
        Utils.showDialog(
          context: context,
          dialog: PrimaryDialog.custom(
            content: Column(
              children: [
                Text(
                  S.of(context).new_schedule,
                  style: txtBold(18),
                ),
                vpad(12),
                PrimaryTextField(
                  label: S.of(context).hand_date,
                  validator: Utils.emptyValidator,
                  isRequired: true,
                  isReadOnly: true,
                  hint: "dd/mm/yyyy",
                  onTap: () => pickHandOverDate(context),
                  suffixIcon: const PrimaryIcon(icons: PrimaryIcons.calendar),
                  controller: handOverDateController,
                  validateString: validateHandOverDate,
                ),
                vpad(12),
                PrimaryTextField(
                  label: S.of(context).hand_time,
                  validator: Utils.emptyValidator,
                  isReadOnly: true,
                  isRequired: true,
                  onTap: () => pickHandOverTime(context),
                  suffixIcon: const PrimaryIcon(icons: PrimaryIcons.clock),
                  hint: "hh/mm",
                  controller: handOverTimeController,
                  validateString: validateHandOverTime,
                ),
                vpad(12),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: PrimaryButton(
                        buttonSize: ButtonSize.small,
                        buttonType: ButtonType.red,
                        text: S.of(context).cancel,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: hpad(0),
                    ),
                    Expanded(
                      flex: 10,
                      child: PrimaryButton(
                        buttonSize: ButtonSize.small,
                        text: S.of(context).confirm,
                        onTap: () async {
                          Navigator.pop(context);

                          APIHandOver.reBookScheduleList(
                            schedule!
                                .copyWith(
                                  date: handOverDate!
                                      .subtract(const Duration(hours: 7))
                                      .toIso8601String(),
                                  time: handOverTimeController.text,
                                  hour: handOverTimeController.text,
                                )
                                .toMap(),
                          ).then((v) {
                            Utils.showSuccessMessage(
                              context: context,
                              e: S.of(context).success_book_schedule(
                                    "${schedule?.a?.name}-${schedule?.a?.f?.name}-${schedule?.a?.b?.name}",
                                  ),
                              onClose: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  HandOverScreen.routeName,
                                  (route) => route.isFirst,
                                  arguments: {
                                    "init": 0,
                                  },
                                );
                              },
                            );
                          }).catchError((e) {
                            Utils.showErrorMessage(context, e);
                            handOverDate =
                                DateTime.tryParse(schedule?.date ?? "") != null
                                    ? DateTime.parse(schedule?.date ?? "")
                                    : null;
                            handOverTime = schedule!.hour != null
                                ? TimeOfDay(
                                    hour: int.parse(
                                      schedule!.hour!.split(":")[0],
                                    ),
                                    minute: int.parse(
                                      schedule!.hour!.split(":")[1],
                                    ),
                                  )
                                : null;
                            handOverDateController.text =
                                Utils.dateFormat(schedule?.date ?? "", 1);
                            handOverTimeController.text = schedule?.time ?? "";
                            notifyListeners();
                          });
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  send(BuildContext context) {
    autoValid = true;
    isSendLoading = true;
    notifyListeners();
    if (validate(context)) {
      var resPhone = context.read<ResidentInfoPrv>().userInfo?.phone_required;
      var residentId = context.read<ResidentInfoPrv>().residentId;
      var apartment =
          apartmentList.firstWhere((element) => element.id == apartmentValue);
      APIHandOver.veryfyExistScheduleAndSendOTP(
        // customer?.phone_required,
        residentId,
        apartmentValue,
      ).then((v) {
        isSendLoading = false;
        notifyListeners();
        Navigator.pushNamed(
          context,
          OtpBookingScreen.routeName,
          arguments: {
            "apart":
                "${apartment.name}-${apartment.f?.name}-${apartment.b?.name}",
            "data": AppointmentSchedule(
              apartmentId: apartmentValue,
              apartmentTypeId: apartment.apartmentTypeId,
              apartment_type: apartment.apartment_type,
              date: handOverDate!
                  // .subtract(const Duration(hours: 7))
                  .toIso8601String(),
              time: handOverTimeController.text,
              customersId:
                  context.read<ResidentInfoPrv>().residentId, //customer?.id,
              email: context
                  .read<ResidentInfoPrv>()
                  .userInfo
                  ?.email, //customer?.email,
              hour: handOverTimeController.text,
              resident_phone: resPhone,
              status: "WAIT",
            )
          },
        );
      }).catchError((e) {
        isSendLoading = false;
        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
    }
  }

  bool validate(BuildContext context) {
    if (formKey.currentState!.validate()) {
      clearValidString();
      return true;
    } else {
      isSendLoading = false;
      genValidString();
      return false;
    }
  }

  clearValidString() {
    validateApartment = null;
    validateHandOverDate = null;
    validateHandOverTime = null;
    notifyListeners();
  }

  genValidString() {
    if (apartmentValue == null) {
      validateApartment = S.current.not_blank;
    } else {
      validateApartment = null;
    }

    if (handOverDateController.text.trim().isEmpty) {
      validateHandOverDate = S.current.not_blank;
    } else {
      validateHandOverDate = null;
    }

    if (handOverTimeController.text.trim().isEmpty) {
      validateHandOverTime = S.current.not_blank;
    } else {
      validateHandOverTime = null;
    }

    notifyListeners();
  }

  onChangeApartment(v) {
    if (v != null) {
      apartmentValue = v;
      validateApartment = null;
    }
    notifyListeners();
  }

  Future getApartmentListContract(BuildContext context) async {
    var phone = context.read<ResidentInfoPrv>().userInfo?.account?.phone_number;
    var residentId = context.read<ResidentInfoPrv>().residentId;
    await APIHandOver.getApartmentContract(residentId).then((v) {
      if (v != null && v['list'] != null) {
        apartmentList.clear();
        // customer = Customer.fromMap(v['customer']);
        for (var i in v['list']) {
          apartmentList.add(Apartment.fromJson(i));
        }
      }
      apartmentValue = schedule?.apartmentId;
    });
    notifyListeners();
  }

  pickHandOverDate(BuildContext context) async {
    await Utils.showDatePickers(
      context,
      initDate: handOverDate ?? DateTime.now(),
      startDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        handOverDate = v;
        handOverDateController.text = Utils.dateFormat(v.toIso8601String(), 0);

        notifyListeners();
      }
    });
  }

  pickHandOverTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: handOverTime ?? const TimeOfDay(hour: 0, minute: 0),
    ).then((v) {
      if (v != null) {
        handOverTimeController.text = v.format(context);
        handOverTime = v;
      }
    });
  }
}
