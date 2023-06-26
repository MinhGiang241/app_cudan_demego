import 'package:app_cudan/services/api_hand_over.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/file_upload.dart';
import '../../../../models/hand_over.dart';
import '../../../../services/api_rules.dart';
import '../../../../utils/utils.dart';
import '../widget/asset_item.dart';

class AcceptHandOverPrv extends ChangeNotifier {
  AcceptHandOverPrv(this.handOver) {
    handOver = handOver;
    handOverCopy = handOver.copyWith();
    makeList();

    print(materialList);
    print(assetList);
  }

  final formKeyReason = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  String? validateReason;
  String? valueReason;

  late Map<String, List<Materials>> materialList;
  late Map<String, List<AddAsset>> assetList;
  late HandOver handOver;
  late HandOver handOverCopy;
  List<FileUploadModel> ruleFiles = [];
  List<Defect> defectList = [];
  bool isLoading = false;
  bool complete = false;

  bool generalInfoExpand = false;
  bool assetListExpand = false;
  bool materialListExpand = false;
  bool expandNotPass = false;
  List notPassList = [];
  GlobalKey infoKey = GlobalKey();

  final TextEditingController handOverDateController = TextEditingController();
  final TextEditingController handOverTimeController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String? validateHandOverDate;
  String? validateHandOverTime;

  DateTime? handOverDate;
  TimeOfDay? handOverTime;

  bool isSendLoading = false;
  final PageController pageController = PageController();
  int activeStep = 0;
  bool isDisableCroll = true;

  saveCheckItem(
    bool value,
    String key,
    int indexItem,
    DetailType type,
    String reason,
    List<FileUploadModel> list,
  ) async {
    selectItemPass(value, key, indexItem, type, list);
    if (type == DetailType.MATERIAL) {
      print(handOverCopy);
    } else {}
// await APIHandOver.saveHandOverUncontrol(handOverCopy.toMap());
  }

  saveHandOver(BuildContext context) async {
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
    data["status"] = 'COMPLETE';
    if (count > 0) {
      Utils.showConfirmMessage(
        context: context,
        title: S.of(context).accept_hand_over,
        content: S.of(context).count_err_handover(count),
        onConfirm: () async {
          isLoading = true;
          notifyListeners();

          await APIHandOver.saveHandOverUncontrol(data).then((v) async {
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
                } else {
                  // Navigator.pop(context);
                }
              },
            );
          }).catchError((e) {
            isLoading = false;
            notifyListeners();
            Utils.showErrorMessage(context, e);
          });
        },
      );
    } else {
      await APIHandOver.saveHandOverUncontrol(data).then((v) {
        return getHandOverById();
      }).catchError((e) {
        Utils.showErrorMessage(context, e);
      });
    }
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
  ) {
    if (type == DetailType.ASSET) {
      assetList[key]![indexItem].achieve = value;
      assetList[key]![indexItem].not_achieve = !value;
      assetList[key]![indexItem].img_additional = list;
    }
    if (type == DetailType.MATERIAL) {
      materialList[key]![indexItem].achieve = value;
      materialList[key]![indexItem].not_achieve = !value;
      materialList[key]![indexItem].img = list;
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
  }

  clearReasonValidateString() {
    validateReason = null;
  }

  onChangeValue(v) {
    if (v != null) {
      valueReason = v;
      validateReason = null;
    }
  }

  checkHandleHandOver(
    BuildContext context,
  ) async {
    var data = handOver.copyWith().toMap();
    data['isMobile'] = true;
    await APIHandOver.check_handle_handover(data).then((v) {
      pageController.animateToPage(
        ++activeStep,
        duration: const Duration(milliseconds: 250),
        curve: Curves.bounceInOut,
      );
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
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
            Navigator.pop(context);
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
                          label: S.of(context).note,
                          maxLines: 3,
                          controller: reasonController,
                          maxLength: 550,
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
