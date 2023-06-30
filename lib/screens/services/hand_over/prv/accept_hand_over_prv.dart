import 'package:app_cudan/models/workarising.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/services/api_hand_over.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/file_upload.dart';
import '../../../../models/hand_over.dart';
import '../../../../services/api_rules.dart';
import '../../../../utils/utils.dart';
import '../hand_over_screen.dart';
import '../widget/asset_item.dart';

class AcceptHandOverPrv extends ChangeNotifier {
  AcceptHandOverPrv(this.handOver) {
    handOver = handOver;
    handOverCopy = handOver.copyWith();
    if (handOver.real_acreage != null) {
      realAreaController.text = (handOver.real_acreage ?? '0').toString();
    }
    if (handOver.real_floor_area != null) {
      realFloorController.text = (handOver.real_floor_area ?? '0').toString();
    }
    var handDate = DateTime.tryParse(handOverCopy.date ?? "") != null
        ? DateTime.parse(handOverCopy.date!)
        : null;
    if (handDate != null) {
      handOverDateController.text =
          Utils.dateFormat(handDate.toIso8601String(), 0);
    }
    if (handOver.hour != null) {
      handOverHourController.text = handOver.hour ?? "";
    }

    makeList();
    if (handOver.status == 'COMPLETE') {
      complete = true;
    }
    getWorkArisingHandOver();
    print(materialList);
    print(assetList);
  }

  final formKeyReason = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  String? validateReason;
  String? validateReasonNote;
  String? valueReason;

  late Map<String, List<Materials>> materialList;
  late Map<String, List<AddAsset>> assetList;
  late HandOver handOver;
  late HandOver handOverCopy;
  List<FileUploadModel> ruleFiles = [];
  List<Defect> defectList = [];
  bool isLoading = false;
  bool isLoadingComplete = false;
  bool complete = false;
  WorkArising? workArising;

  bool generalInfoExpand = false;
  bool assetListExpand = false;
  bool materialListExpand = false;
  bool expandNotPass = false;
  List notPassList = [];
  GlobalKey infoKey = GlobalKey();
  final infoKeyStep = GlobalKey<FormState>();

  final TextEditingController handOverDateController = TextEditingController();
  final TextEditingController handOverHourController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  final TextEditingController realAreaController = TextEditingController();
  final TextEditingController realFloorController = TextEditingController();

  String? validaterRealArea;
  String? validateRealFloor;

  DateTime? handOverDate;
  TimeOfDay? handOverTime;

  bool isSendLoading = false;
  final PageController pageController = PageController();
  int activeStep = 0;
  bool isDisableCroll = true;
  String? validateHandOverHour;
  String? validateHandOverDate;

  pickHandOverDate(BuildContext context) {
    var handDate = handOverCopy.date != null
        ? DateTime.parse(handOverCopy.date!)
        : DateTime.now();
    Utils.showDatePickers(
      context,
      initDate: handDate,
      startDate: DateTime(DateTime.now().year - 10, 1, 1),
      endDate: DateTime(DateTime.now().year + 10, 1, 1),
    ).then((v) {
      if (v != null) {
        handOverDateController.text =
            Utils.dateFormat(handDate.toIso8601String(), 0);
        validateHandOverDate = null;
        notifyListeners();
      } else {
        handOverDateController.text = "";
        validateHandOverDate = S.of(context).not_blank;
      }

      notifyListeners();
    });
  }

  pickHandOverHour(BuildContext context) {
    var hourString = handOverCopy.hour?.split(':')[0] ?? '';
    var minuteString = handOverCopy.hour?.split(':')[1] ?? '';
    var handOverHour = TimeOfDay(
      hour: int.tryParse(hourString) != null ? int.parse(hourString) : 0,
      minute: int.tryParse(minuteString) != null ? int.parse(minuteString) : 0,
    );
    showTimePicker(
      context: context,
      initialTime: handOverHour,
    ).then((v) {
      if (v != null) {
        validateHandOverHour = null;
        handOverHourController.text = v.format(context);
        notifyListeners();
      } else {
        handOverHourController.text = "";
        validateHandOverHour = S.of(context).not_blank;
      }
      notifyListeners();
    });
  }

  String? validateAreaForm(String? v) {
    if (v!.isEmpty) {
      return '';
    } else if (double.tryParse(v) != null && double.parse(v) > 9999) {
      return '';
    }
    return null;
  }

  genAreaValidate() {
    if (realAreaController.text.trim().isEmpty) {
      validaterRealArea = S.current.not_blank;
    } else if (double.tryParse(realAreaController.text.trim()) != null &&
        double.parse(realAreaController.text.trim()) > 9999) {
      validaterRealArea = S.current.not_larger('9999');
    } else {
      validaterRealArea = null;
    }

    if (realFloorController.text.trim().isEmpty) {
      validateRealFloor = S.current.not_blank;
    } else if (double.tryParse(realFloorController.text.trim()) != null &&
        double.parse(realFloorController.text.trim()) > 9999) {
      validateRealFloor = S.current.not_larger('9999');
    } else {
      validateRealFloor = null;
    }

    if (handOverDateController.text.trim().isEmpty) {
      validateHandOverDate = S.current.not_blank;
    } else {
      validateHandOverDate = null;
    }
    if (handOverHourController.text.trim().isEmpty) {
      validateHandOverHour = S.current.not_blank;
    } else {
      validateHandOverHour = null;
    }

    print(validateRealFloor);
    print(validaterRealArea);
    notifyListeners();
  }

  clearAreaValidate() {
    validaterRealArea = null;
    validateRealFloor = null;
    validateHandOverDate = null;
    validateHandOverHour = null;
    notifyListeners();
  }

  onChangeFormInfoStep() {
    if (infoKeyStep.currentState!.validate()) {
      clearAreaValidate();
    } else {
      genAreaValidate();
    }
    notifyListeners();
  }

  infoStep2Next() {
    if (infoKeyStep.currentState!.validate()) {
      handOverCopy.date = handOverDateController.text.trim();
      handOverCopy.hour = handOverHourController.text.trim();
      clearAreaValidate();
      pageController.animateToPage(
        ++activeStep,
        duration: const Duration(milliseconds: 250),
        curve: Curves.bounceInOut,
      );
    } else {
      genAreaValidate();
    }
  }

  saveCheckItem(
    bool value,
    String key,
    int indexItem,
    DetailType type,
    String reason,
    List<FileUploadModel> list,
  ) async {
    selectItemPass(value, key, indexItem, type, list, reason);
    if (type == DetailType.MATERIAL) {
      print(handOverCopy);
    } else {}
// await APIHandOver.saveHandOverUncontrol(handOverCopy.toMap());
  }

  getWorkArisingHandOver() async {
    APIHandOver.getResultsWorkByVirtualId(handOver.id ?? '', null).then((v) {
      if (v != null) {
        workArising = WorkArising.fromMap(v);
      }
      notifyListeners();
    });
  }

  checkHandOver(BuildContext context) async {
    try {
      if ((handOverCopy.material_list ?? <Materials>[])
              .any((e) => (e.achieve == null && e.not_achieve == null)) ||
          (handOverCopy.list_assets_additional ?? <AddAsset>[])
              .any((e) => (e.achieve == null && e.not_achieve == null))) {
        throw (S.of(context).not_complete_check);
      }
      var count = 0;
      for (var i in handOverCopy.material_list ?? <Materials>[]) {
        if (i.not_achieve == true ||
            (i.not_achieve == null && i.achieve != true)) {
          ++count;
        }
      }
      for (var i in handOverCopy.list_assets_additional ?? <AddAsset>[]) {
        if (i.not_achieve == true ||
            (i.not_achieve == null && i.achieve != true)) {
          ++count;
        }
      }
      var data = handOverCopy.toMap();
      // data["status"] = 'WAIT';
      if (count > 0) {
        Utils.showConfirmMessage(
          context: context,
          title: S.of(context).accept_hand_over,
          content: S.of(context).count_err_handover(count),
          onConfirm: () async {
            isLoading = true;
            notifyListeners();

            await APIHandOver.checkComplete(data).then((v) async {
              return await getHandOverById();
            }).then((v) {
              isLoading = false;
              complete = true;
              notifyListeners();
              Navigator.pop(context);
              Utils.showSuccessMessage(
                context: context,
                e: S.of(context).complete_handover(handOver.label ?? ''),
                onClose: () {
                  if (activeStep == 1) {
                    // Navigator.pop(context);
                    backScreen(context);
                  } else if (activeStep == 2) {
                    backScreen(context);
                    backScreen(context);
                    // Navigator.pop(context);
                  }
                },
              );
            }).catchError((e) {
              isLoading = false;
              notifyListeners();
              Navigator.pop(context);
              Utils.showErrorMessage(context, e);
            });
          },
        );
      } else {
        await APIHandOver.checkComplete(data).then((v) async {
          await getHandOverById();
          if (activeStep == 1) {
            // Navigator.pop(context);
            backScreen(context);
          } else if (activeStep == 2) {
            backScreen(context);
            backScreen(context);
            // Navigator.pop(context);
          }
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      }
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }

  completeHandover(BuildContext context) async {
    isLoadingComplete = true;
    notifyListeners();
    handOverCopy.status = 'COMPLETE';
    handOverCopy.status_error = 'COMPLETE';
    var data = handOverCopy.toMap();
    await APIHandOver.saveHandOver(data).then((v) {
      isLoadingComplete = false;
      notifyListeners();
      Utils.showSuccessMessage(
        context: context,
        e: S.of(context).success_handover(handOverCopy.label ?? ""),
        onClose: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HandOverScreen.routeName,
            (route) => route.isFirst,
            arguments: {
              'init': 1,
            },
          );
        },
      );
    }).catchError((e) {
      isLoadingComplete = false;
      notifyListeners();
      Utils.showSuccessMessage(
        context: context,
        e: e,
      );
    });
  }

  finishCheck(context) async {
    backScreen(context);
  }

  makeList() {
    materialList = {};
    for (var i in handOverCopy.material_list ?? <Materials>[]) {
      if (materialList[i.assetPositionId] == null) {
        materialList[i.assetPositionId!] = <Materials>[];
        materialList[i.assetPositionId]!.add(i);
      } else {
        materialList[i.assetPositionId]!.add(i);
      }
    }

    // asset
    assetList = {};
    for (var i in handOverCopy.list_assets_additional ?? <AddAsset>[]) {
      if (assetList[i.assetPositionId_additional] == null) {
        assetList[i.assetPositionId_additional!] = <AddAsset>[];
        assetList[i.assetPositionId_additional]!.add(i);
      } else {
        assetList[i.assetPositionId_additional]!.add(i);
      }
    }
    valueReason = handOver.cancel_reason;
  }

  getHandOverById() async {
    await APIHandOver.getHandOverById(handOver.id).then((v) {
      if (v != null) {
        handOver = HandOver.fromMap(v);
        handOverCopy = HandOver.fromMap(v);
        makeList();
      }
      notifyListeners();
    });
  }

  onPageChanged(v) {
    activeStep = v;
    notifyListeners();
  }

  backScreen(BuildContext context) async {
    FocusScope.of(context).unfocus();

    isDisableCroll = false;
    notifyListeners();
    pageController
        .animateToPage(
      --activeStep,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceInOut,
    )
        .then((v) {
      isDisableCroll = true;
      notifyListeners();
    });
  }

  Future getRuleFiles() async {
    await APIRule.getListRulesFiles("handover").then((v) {
      if (v != null) {
        ruleFiles.clear();
        for (var i in v) {
          ruleFiles.add(FileUploadModel.fromMap(i));
        }
        ruleFiles.sort(
          (a, b) => a.id!.compareTo(b.id!),
        );
      }
    });
  }

  toggleExpandNotPass() {
    expandNotPass = !expandNotPass;
    notifyListeners();
  }

  selectItemPass(
    bool value,
    String key,
    int indexItem,
    DetailType type,
    List<FileUploadModel> list,
    String reason,
  ) {
    if (type == DetailType.ASSET) {
      assetList[key]![indexItem].achieve = value;
      assetList[key]![indexItem].not_achieve = !value;
      assetList[key]![indexItem].file_reason_archive = list;
      assetList[key]![indexItem].reason_not_archive = value ? null : reason;
    }
    if (type == DetailType.MATERIAL) {
      materialList[key]![indexItem].achieve = value;
      materialList[key]![indexItem].not_achieve = !value;
      materialList[key]![indexItem].file_reason_archive = list;
      materialList[key]![indexItem].reason_not_archive = value ? null : reason;
    }

    notifyListeners();
  }

  toggleGeneralInfo() {
    generalInfoExpand = !generalInfoExpand;
    notifyListeners();
  }

  toggleAssetList() {
    assetListExpand = !assetListExpand;
    notifyListeners();
  }

  toggleMaterialList() {
    materialListExpand = !materialListExpand;
    notifyListeners();
  }

  genReasonValidateString() {
    if (valueReason == null) {
      validateReason = S.current.not_blank;
    } else {
      validateReason = null;
    }
    if (reasonController.text.isEmpty) {
      validateReasonNote = S.current.not_blank;
    } else {
      validateReasonNote = null;
    }
    notifyListeners();
  }

  clearReasonValidateString() {
    validateReason = null;
    validateReasonNote = null;
    notifyListeners();
  }

  onChangeValue(v) {
    if (v != null) {
      valueReason = v;
      validateReason = null;
    }
    notifyListeners();
  }

  checkHandleHandOver(
    BuildContext context,
  ) async {
    pageController.animateToPage(
      ++activeStep,
      duration: const Duration(milliseconds: 250),
      curve: Curves.bounceInOut,
    );
    var data = handOver.copyWith().toMap();

    // data['isMobile'] = true;
    // await APIHandOver.check_handle_handover(data).then((v) async {
    //   var now = DateTime.now().subtract(Duration(hours: 7));
    //   handOverCopy.status = 'HANDING';
    //   var data = handOverCopy.toMap();
    //   data['date'] = now.toIso8601String();
    //   data['hour'] = "${now.hour}:${now.minute}";
    //   // await APIHandOver.saveHandOver(data);
    // }).then((v) {
    //   getHandOverById();
    //   pageController.animateToPage(
    //     ++activeStep,
    //     duration: const Duration(milliseconds: 250),
    //     curve: Curves.bounceInOut,
    //   );
    // }).catchError((e) {
    //   Utils.showErrorMessage(context, e);
    // });
  }

  submitError(BuildContext context) async {
    if (formKeyReason.currentState!.validate()) {
      clearReasonValidateString();
      Navigator.pop(context);
      await APIHandOver.errorReport(
        handOver.toMap(),
        valueReason!,
        reasonController.text.trim(),
      ).then((value) {
        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).success_report_handover,
          onClose: () {
            // Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              HandOverScreen.routeName,
              (route) => route.isFirst,
              arguments: {
                'init': 1,
              },
            );
          },
        );
      }).catchError((e) {
        Utils.showErrorMessage(
          context,
          e,
        );
      });
    } else {
      genReasonValidateString();
    }
  }

  reportError(BuildContext context) async {
    try {
      var data = handOver.copyWith().toMap();
      data['isMobile'] = true;
      await APIHandOver.checkReport(data, true);
      await Utils.showDialog(
        context: context,
        dialog: PrimaryDialog.custom(
          content: StatefulBuilder(
            builder: (context, setState) {
              return FutureBuilder(
                future: () async {
                  await APIHandOver.getDefect().then((v) {
                    defectList.clear();
                    if (v != null) {
                      for (var i in v) {
                        defectList.add(Defect.fromMap(i));
                      }
                    }
                  });
                }(),
                builder: (snap, builder) {
                  var defectChoicesList = defectList
                      .map(
                        (d) => DropdownMenuItem(
                          value: d.code,
                          child: Text(d.name ?? ""),
                        ),
                      )
                      .toList();
                  return Form(
                    key: formKeyReason,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: () {
                      if (formKeyReason.currentState!.validate()) {
                        clearReasonValidateString();
                        setState(() {});
                      } else {
                        genReasonValidateString();
                        setState(() {});
                      }
                    },
                    child: Column(
                      children: [
                        vpad(12),
                        PrimaryDropDown(
                          isDense: false,
                          hint: S.of(context).err_reason,
                          onChange: onChangeValue,
                          selectList: defectChoicesList,
                          validateString: validateReason,
                          value: valueReason,
                          label: S.of(context).err_reason,
                          validator: Utils.emptyValidatorDropdown,
                          isRequired: true,
                        ),
                        vpad(12),
                        PrimaryTextField(
                          isRequired: true,
                          validateString: validateReasonNote,
                          label: S.of(context).note,
                          maxLines: 3,
                          controller: reasonController,
                          maxLength: 550,
                          validator: Utils.emptyValidator,
                        ),
                        vpad(20),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                text: S.of(context).cancel,
                                buttonSize: ButtonSize.small,
                                buttonType: ButtonType.red,
                                onTap: () {
                                  clearReasonValidateString();
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            hpad(10),
                            Expanded(
                              child: PrimaryButton(
                                text: S.of(context).save,
                                buttonSize: ButtonSize.small,
                                buttonType: ButtonType.primary,
                                onTap: () async {
                                  setState(
                                    () {},
                                  );
                                  await submitError(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        vpad(12),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }
}
