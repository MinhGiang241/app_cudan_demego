import 'dart:io';

import 'package:app_cudan/models/file_upload.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/asset_Item_view_model.dart';
import '../../../../services/api_auth.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/primary_text_field.dart';
import '../../../../widgets/select_media_widget.dart';
import 'asset_item.dart';

class ReasonDailog extends StatefulWidget {
  const ReasonDailog({
    super.key,
    this.function,
    required this.functionSave,
    required this.type,
    required this.data,
    required this.index,
    required this.keyMap,
  });
  final function;
  final Function functionSave;
  final DetailType type;
  final AssetItemViewModel data;
  final int index;
  final String keyMap;

  @override
  State<ReasonDailog> createState() => _ReasonDailogState();
}

class _ReasonDailogState extends State<ReasonDailog> {
  bool loading = false;
  List<File> imageResons = [];
  List<FileUploadModel> uploadedImageResons = [];
  List<FileUploadModel> existededImageResons = [];
  final formKeyReason = GlobalKey<FormState>();
  String? validateReason;

  TextEditingController rController = TextEditingController();
  onRemoveFile(
    int index,
  ) {
    setState(() {
      imageResons.removeAt(index);
    });
  }

  onRemoveExistedFile(
    int index,
  ) {
    setState(() {
      existededImageResons.removeAt(index);
    });
  }

  genReasonValidateString() {
    if (rController.text.trim().isEmpty) {
      return S.current.not_blank;
    } else {
      return null;
    }
  }

  clearReasonValidateString() {
    validateReason = null;
  }

  onSelectPhoto(
    BuildContext context,
  ) async {
    await Utils.selectImage(context, false).then((value) {
      if (value != null) {
        final list = value.map<File>((e) => File(e.path)).toList();
        setState(() {
          imageResons.addAll(list);
        });
      }
    });
  }

  Future uploadPhotos(BuildContext context) async {
    await APIAuth.uploadSingleFile(files: imageResons, context: context)
        .then((v) {
      if (v.isNotEmpty) {
        for (var e in v) {
          uploadedImageResons.add(
            FileUploadModel(id: e.data, name: e.name),
          );
        }
      }
    }).catchError((e) {
      throw (e);
    });
  }

  @override
  void initState() {
    existededImageResons = widget.data.list[widget.index].photosError;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyReason,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () {
        if (formKeyReason.currentState!.validate()) {
          clearReasonValidateString();
          setState(() {});
        } else {
          var v = genReasonValidateString();
          setState(() {
            validateReason = v;
          });
        }
        print(validateReason);
      },
      child: Column(
        children: [
          PrimaryTextField(
            maxLength: 550,
            controller: rController,
            maxLines: 2,
            label: S.of(context).not_pass_reason,
            isRequired: true,
            validateString: validateReason,
            validator: Utils.emptyValidator,
          ),
          vpad(12),
          SelectMediaWidget(
            existImages: existededImageResons,
            onRemoveExist: onRemoveExistedFile,
            onSelect: () {
              onSelectPhoto(context);
            },
            onRemove: onRemoveFile,
            images: imageResons,
            title: S.of(context).photos,
          ),
          vpad(16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: S.of(context).cancel,
                  buttonType: ButtonType.red,
                  buttonSize: ButtonSize.small,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              hpad(5),
              Expanded(
                child: PrimaryButton(
                  isLoading: loading,
                  text: S.of(context).save,
                  buttonSize: ButtonSize.small,
                  onTap: () async {
                    try {
                      if (formKeyReason.currentState!.validate()) {
                        clearReasonValidateString();
                        setState(() {
                          loading = true;
                        });
                        await uploadPhotos(context);
                        await widget.functionSave(
                          false,
                          widget.keyMap,
                          widget.index,
                          widget.type,
                          rController.text.trim(),
                          existededImageResons + uploadedImageResons,
                        );

                        setState(() {
                          loading = false;
                        });
                        Navigator.pop(context);
                      } else {
                        var v = genReasonValidateString();
                        setState(() {
                          validateReason = v;
                        });
                      }
                    } catch (e) {
                      Utils.showErrorMessage(context, e.toString());
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
