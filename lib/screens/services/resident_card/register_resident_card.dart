import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/resident_card.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dropdown.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/select_media_widget.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'prv/register_resident_card_prv.dart';

class RegisterResidentCard extends StatelessWidget {
  static const routeName = '/resident-card/register';
  const RegisterResidentCard({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    var isEdit = arg['isEdit'];
    ResidentCard card = ResidentCard();
    if (isEdit) {
      card = arg['data'];
    }
    return ChangeNotifierProvider(
      create: (context) => RegisterResidentCardPrv(
        code: card.code,
        id: card.id,
        imageUrlFront: card.identity_image_front,
        imageUrlBack: card.identity_image_back,
        otherImage: card.other_image,
        imageUrlResident: card.resident_image,
        residentId: context.read<ResidentInfoPrv>().residentId,
        apartmentId: card.apartmentId ??
            context.read<ResidentInfoPrv>().selectedApartment?.apartmentId,
      ),
      builder: (context, state) {
        var listApartmentChoice =
            context.read<ResidentInfoPrv>().listOwn.map((e) {
          return DropdownMenuItem(
            value: e.apartmentId,
            child: Text(e.apartment?.name! != null
                ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
                : e.apartmentId!),
          );
        }).toList();
        return PrimaryScreen(
          appBar: PrimaryAppbar(
              title: isEdit
                  ? S.of(context).edit_res_card
                  : S.of(context).register_res_card),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                vpad(20),
                PrimaryDropDown(
                  isDense: false,
                  onChange: (v) {
                    context.read<RegisterResidentCardPrv>().apartmentId = v;
                  },
                  label: S.of(context).apartment,
                  selectList: listApartmentChoice,
                  isRequired: true,
                  value: context.read<RegisterResidentCardPrv>().apartmentId,
                ),
                vpad(16),
                Text(
                  S.of(context).photos,
                  style: txtBodySmallRegular(color: grayScaleColorBase),
                ),
                vpad(16),
                Row(
                  children: [
                    Text(
                      S.of(context).identity_photo,
                      style: txtBodySmallRegular(color: grayScaleColorBase),
                    ),
                    Text(
                      " *",
                      style: txtBodySmallRegular(color: redColor1),
                    ),
                  ],
                ),
                vpad(16),
                if (isEdit &&
                    context.watch<RegisterResidentCardPrv>().imageUrlFront !=
                        null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).front_side,
                        style: txtBodySmallRegular(color: grayScaleColorBase),
                      ),
                      vpad(12),
                      SizedBox(
                        height: 116,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                          '${ApiConstants.uploadURL}/?load=${context.watch<RegisterResidentCardPrv>().imageUrlFront!}')),
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: PrimaryIcon(
                                      icons: PrimaryIcons.close,
                                      style: PrimaryIconStyle.gradient,
                                      gradients: PrimaryIconGradient.red,
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(4),
                                      onTap: () {
                                        context
                                            .read<RegisterResidentCardPrv>()
                                            .onRemoveUrlImage(context, 1);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (!isEdit ||
                    (isEdit &&
                        context
                                .watch<RegisterResidentCardPrv>()
                                .imageUrlFront ==
                            null))
                  SelectMediaWidget(
                    isDash: context
                            .watch<RegisterResidentCardPrv>()
                            .imageFileFront
                            .isNotEmpty
                        ? false
                        : true,
                    images:
                        context.watch<RegisterResidentCardPrv>().imageFileFront,
                    title: S.of(context).front_side,
                    onRemove:
                        context.read<RegisterResidentCardPrv>().onRemoveFront,
                    onSelect: () {
                      context
                          .read<RegisterResidentCardPrv>()
                          .onSelectFrontPhoto(context);
                    },
                  ),
                vpad(16),
                if (isEdit &&
                    context.watch<RegisterResidentCardPrv>().imageUrlBack !=
                        null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).back_side,
                        style: txtBodySmallRegular(color: grayScaleColorBase),
                      ),
                      vpad(12),
                      SizedBox(
                        height: 116,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                          '${ApiConstants.uploadURL}/?load=${context.watch<RegisterResidentCardPrv>().imageUrlBack!}')),
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: PrimaryIcon(
                                      icons: PrimaryIcons.close,
                                      style: PrimaryIconStyle.gradient,
                                      gradients: PrimaryIconGradient.red,
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(4),
                                      onTap: () {
                                        context
                                            .read<RegisterResidentCardPrv>()
                                            .onRemoveUrlImage(context, 2);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (!isEdit ||
                    (isEdit &&
                        context.watch<RegisterResidentCardPrv>().imageUrlBack ==
                            null))
                  SelectMediaWidget(
                    isDash: context
                            .watch<RegisterResidentCardPrv>()
                            .imageFileBack
                            .isNotEmpty
                        ? false
                        : true,
                    images:
                        context.watch<RegisterResidentCardPrv>().imageFileBack,
                    title: S.of(context).back_side,
                    onRemove:
                        context.read<RegisterResidentCardPrv>().onRemoveBack,
                    onSelect: () {
                      context
                          .read<RegisterResidentCardPrv>()
                          .onSelectBackPhoto(context);
                    },
                  ),
                vpad(16),
                if (isEdit &&
                    context.watch<RegisterResidentCardPrv>().imageUrlResident !=
                        null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).res_photo,
                        style: txtBodySmallRegular(color: grayScaleColorBase),
                      ),
                      vpad(12),
                      SizedBox(
                        height: 116,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                          '${ApiConstants.uploadURL}/?load=${context.watch<RegisterResidentCardPrv>().imageUrlResident!}')),
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: PrimaryIcon(
                                      icons: PrimaryIcons.close,
                                      style: PrimaryIconStyle.gradient,
                                      gradients: PrimaryIconGradient.red,
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(4),
                                      onTap: () {
                                        context
                                            .read<RegisterResidentCardPrv>()
                                            .onRemoveUrlImage(context, 0);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (!isEdit ||
                    (isEdit &&
                        context
                                .watch<RegisterResidentCardPrv>()
                                .imageUrlResident ==
                            null))
                  SelectMediaWidget(
                    isDash: context
                            .watch<RegisterResidentCardPrv>()
                            .residentImageFile
                            .isNotEmpty
                        ? false
                        : true,
                    images: context
                        .watch<RegisterResidentCardPrv>()
                        .residentImageFile,
                    title: S.of(context).res_photo,
                    onRemove:
                        context.read<RegisterResidentCardPrv>().onRemoveRes,
                    onSelect: () {
                      context
                          .read<RegisterResidentCardPrv>()
                          .onSelectResPhoto(context);
                    },
                  ),
                vpad(16),
                if (isEdit &&
                    context.watch<RegisterResidentCardPrv>().otherImage != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).related_photo,
                        style: txtBodySmallRegular(color: grayScaleColorBase),
                      ),
                      vpad(12),
                      SizedBox(
                        height: 116,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                          '${ApiConstants.uploadURL}/?load=${context.watch<RegisterResidentCardPrv>().otherImage!}')),
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: PrimaryIcon(
                                      icons: PrimaryIcons.close,
                                      style: PrimaryIconStyle.gradient,
                                      gradients: PrimaryIconGradient.red,
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(4),
                                      onTap: () {
                                        context
                                            .read<RegisterResidentCardPrv>()
                                            .onRemoveUrlImage(context, 3);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (!isEdit ||
                    (isEdit &&
                        context.watch<RegisterResidentCardPrv>().otherImage ==
                            null))
                  SelectMediaWidget(
                    isDash: context
                            .watch<RegisterResidentCardPrv>()
                            .otherImageFile
                            .isNotEmpty
                        ? false
                        : true,
                    images:
                        context.watch<RegisterResidentCardPrv>().otherImageFile,
                    title: S.of(context).related_photo,
                    onRemove: context
                        .read<RegisterResidentCardPrv>()
                        .onRemoveOtherImage,
                    onSelect: () {
                      context
                          .read<RegisterResidentCardPrv>()
                          .onSelectOtherImage(context);
                    },
                  ),
                vpad(36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrimaryButton(
                      isLoading: context
                          .watch<RegisterResidentCardPrv>()
                          .isAddNewLoading,
                      buttonSize: ButtonSize.medium,
                      text:
                          isEdit ? S.of(context).update : S.of(context).add_new,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context
                            .read<RegisterResidentCardPrv>()
                            .onSubmitCard(context, false);
                      },
                    ),
                    PrimaryButton(
                      isLoading: context
                          .watch<RegisterResidentCardPrv>()
                          .isSendApproveLoading,
                      buttonSize: ButtonSize.medium,
                      buttonType: ButtonType.green,
                      text: S.of(context).send_request,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context
                            .read<RegisterResidentCardPrv>()
                            .onSubmitCard(context, true);
                      },
                    ),
                  ],
                ),
                vpad(MediaQuery.of(context).padding.bottom + 24)
              ],
            ),
          ),
        );
      },
    );
  }
}
