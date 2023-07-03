import 'dart:math';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/asset_Item_view_model.dart';
import '../../../models/file_upload.dart';
import '../../../models/hand_over.dart';
import 'prv/accept_hand_over_prv.dart';
import 'widget/asset_item.dart';

class HandOverCheckScreen extends StatefulWidget {
  const HandOverCheckScreen({super.key});
  static const routeName = '/handover/check';

  @override
  State<HandOverCheckScreen> createState() => _HandOverCheckScreenState();
}

class _HandOverCheckScreenState extends State<HandOverCheckScreen>
    with TickerProviderStateMixin {
  late AnimationController animationAssetController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late AnimationController animationMaterialController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late Animation<double> rotateAssetAnimation;
  late Animation<double> rotateMaterialAnimation;
  @override
  void initState() {
    super.initState();
    rotateAssetAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationAssetController);
    rotateMaterialAnimation =
        Tween<double>(begin: 0, end: pi).animate(animationMaterialController);
  }

  @override
  void dispose() {
    animationAssetController.dispose();
    animationMaterialController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isShowAsset = context.watch<AcceptHandOverPrv>().assetListExpand;
    bool isShowMaterial = context.watch<AcceptHandOverPrv>().materialListExpand;
    HandOver handOver = context.watch<AcceptHandOverPrv>().handOver;
    Animation<double> animationAssetDrop = CurvedAnimation(
      parent: animationAssetController,
      curve: Curves.easeInOut,
    );
    Animation<double> animationMaterialDrop = CurvedAnimation(
      parent: animationMaterialController,
      curve: Curves.easeInOut,
    );

    var assetList = {...context.watch<AcceptHandOverPrv>().assetList};
    var materialList = {...context.watch<AcceptHandOverPrv>().materialList};

    return ListView(
      children: [
        vpad(20),
        InkWell(
          onTap: () {
            if (isShowMaterial) {
              isShowMaterial = false;
              animationMaterialController.reverse();
            } else {
              isShowMaterial = true;
              animationMaterialController.forward();
            }

            context.read<AcceptHandOverPrv>().toggleMaterialList();
          },
          child: Row(
            children: [
              const Icon(Icons.home_outlined),
              hpad(20),
              Expanded(
                child: Text(
                  S.of(context).material_list,
                  style: txtBoldUnderline(14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              hpad(20),
              SizedBox(
                height: 15.0,
                width: 15.0,
                child: AnimatedBuilder(
                  animation: animationMaterialController,
                  builder: (context, child) => Transform.rotate(
                    origin: const Offset(4, 4),
                    angle: rotateMaterialAnimation.value,
                    child: child,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ),
              hpad(10),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: animationMaterialDrop,
          child: SingleChildScrollView(
            child: Column(
              children: [
                vpad(16),
                ...materialList.entries.map((e) {
                  return AssetItem(
                    complete: true,
                    functionSave:
                        context.read<AcceptHandOverPrv>().saveCheckItem,
                    vote: true,
                    type: DetailType.MATERIAL,
                    region: e.value[0].assetposition?.asset_postision ?? "",
                    selectPass:
                        context.watch<AcceptHandOverPrv>().selectItemPass,
                    data: AssetItemViewModel(
                      handOverId: handOver.id!,
                      type: 'material',
                      title: e.value[0].assetposition?.asset_postision,
                      list: e.value.map(
                        (e) {
                          List<FileUploadModel> photosError = [];
                          List<FileUploadModel> photos = [];

                          for (var i in (e.file_reason_archive ?? [])) {
                            photosError
                                .add(FileUploadModel(id: i.id, name: i.name));
                          }
                          for (var i in (e.img ?? [])) {
                            photos.add(FileUploadModel(id: i.id, name: i.name));
                          }
                          return ItemViewModel(
                            photosError: photosError,
                            error_notpass: e.reason_not_archive,
                            virtualId: e.virtualId,
                            photos: photos,
                            brand: e.trademark,
                            material_specification: e.material_specification,
                            note: e.note,
                            id: e.id,
                            code: e.code,
                            name: e.materiallist?.material_list,
                            achieve: e.achieve ?? false,
                            not_achieve: e.not_achieve ?? false,
                          );
                        },
                      ).toList(),
                    ),
                    keyMap: e.key,
                  );
                }),
                vpad(3),
              ],
            ),
          ),
        ),
        vpad(30),
        InkWell(
          onTap: () {
            if (isShowAsset) {
              isShowAsset = false;
              animationAssetController.reverse();
            } else {
              isShowAsset = true;
              animationAssetController.forward();
            }

            context.read<AcceptHandOverPrv>().toggleAssetList();
          },
          child: Row(
            children: [
              const Icon(Icons.house_siding_rounded),
              hpad(20),
              Expanded(
                child: Text(
                  S.of(context).asset_list,
                  style: txtBoldUnderline(14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              hpad(20),
              SizedBox(
                height: 15.0,
                width: 15.0,
                child: AnimatedBuilder(
                  animation: animationAssetController,
                  builder: (context, child) => Transform.rotate(
                    origin: const Offset(4, 4),
                    angle: rotateAssetAnimation.value,
                    child: child,
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                  ),
                ),
              ),
              hpad(10),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: animationAssetDrop,
          child: SingleChildScrollView(
            child: Column(
              children: [
                vpad(16),
                ...assetList.entries.map((e) {
                  return AssetItem(
                    complete: true,
                    functionSave:
                        context.read<AcceptHandOverPrv>().saveCheckItem,
                    vote: true,
                    type: DetailType.ASSET,
                    region: e.value[0].assetposition?.asset_postision ?? "",
                    selectPass:
                        context.read<AcceptHandOverPrv>().selectItemPass,
                    data: AssetItemViewModel(
                      handOverId: handOver.id!,
                      type: 'asset',
                      title: e.value[0].assetposition?.asset_postision,
                      list: e.value.map(
                        (e) {
                          List<FileUploadModel> photosError = [];
                          List<FileUploadModel> photos = [];

                          for (var i in (e.file_reason_archive ?? [])) {
                            photosError
                                .add(FileUploadModel(id: i.id, name: i.name));
                          }
                          for (var i in (e.img_additional ?? [])) {
                            photos.add(FileUploadModel(id: i.id, name: i.name));
                          }
                          return ItemViewModel(
                            error_notpass: e.reason_not_archive,
                            photosError: photosError,
                            virtualId: e.virtualId,
                            photos: photos,
                            material_specification: e.material_additional,
                            brand: e.trademark_additional,
                            amount: e.quantity_additional,
                            unit: e.unit?.name,
                            note: e.note_additional,
                            id: e.id,
                            code: e.id,
                            name: e.name_additional,
                            achieve: e.achieve ?? false,
                            not_achieve: e.not_achieve ?? false,
                          );
                        },
                      ).toList(),
                    ),
                    keyMap: e.key,
                  );
                }),
                vpad(3),
              ],
            ),
          ),
        ),
        vpad(30),
        PrimaryButton(
          isLoading: context.watch<AcceptHandOverPrv>().isLoading,
          text: S.of(context).complete,
          onTap: () {
            context.read<AcceptHandOverPrv>().checkHandOver(context);
          },
        ),
        vpad(30),
      ],
    );
  }
}
