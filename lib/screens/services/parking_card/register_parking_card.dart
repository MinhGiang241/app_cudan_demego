import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/transportation_card.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/select_media_widget.dart';
import 'providers/register_transportation_card_prv.dart';

class RegisterTransportationCard extends StatefulWidget {
  const RegisterTransportationCard({Key? key}) : super(key: key);
  static const routeName = '/transportation-card/register';

  @override
  State<RegisterTransportationCard> createState() =>
      _RegisterTransportationCardState();
}

class _RegisterTransportationCardState
    extends State<RegisterTransportationCard> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    var isEdit = arg['isEdit'];
    TransportationCard card = TransportationCard();
    if (isEdit) {
      card = arg['data'];
    }

    return ChangeNotifierProvider(
      create: (context) => RegisterTransportationCardPrv(
          vehicleType: card.vehicleTypeId,
          id: card.id,
          imageUrlFront: card.registration_image_front,
          imageUrlBack: card.registration_image_back,
          otherExistedImages: card.other_image,
          residentId: context.read<ResidentInfoPrv>().residentId,
          apartmentId:
              context.read<ResidentInfoPrv>().selectedApartment?.apartmentId),
      builder: (context, state) {
        if (isEdit) {
          context.read<RegisterTransportationCardPrv>().liceneController.text =
              card.number_plate ?? '';
          context.read<RegisterTransportationCardPrv>().regNumController.text =
              card.registration_number ?? '';
        }
        return PrimaryScreen(
          appBar: PrimaryAppbar(
              title: isEdit
                  ? S.of(context).edit_trans_card
                  : S.of(context).register_trans_card),
          body: SafeArea(
            child: FutureBuilder(
                future: context
                    .read<RegisterTransportationCardPrv>()
                    .getTransportationType(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: PrimaryLoading());
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return PrimaryErrorWidget(
                        code: snapshot.hasError ? "err" : "1",
                        message: snapshot.data.toString(),
                        onRetry: () async {
                          setState(() {});
                        });
                  }

                  var listApartmentChoice =
                      context.read<ResidentInfoPrv>().listOwn.map((e) {
                    return DropdownMenuItem(
                      value: e.apartmentId,
                      child: Text(e.apartment?.name! != null
                          ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
                          : e.apartmentId!),
                    );
                  }).toList();

                  var vehicleTypeList = context
                      .read<RegisterTransportationCardPrv>()
                      .transTypeList
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name ?? e.id!),
                    );
                  }).toList();

                  return Form(
                    key: context.watch<RegisterTransportationCardPrv>().formKey,
                    child: ListView(
                      children: [
                        vpad(20),
                        Text(
                          S.of(context).resident_info,
                          style: txtBodySmallRegular(color: grayScaleColorBase),
                        ),
                        vpad(16),
                        PrimaryDropDown(
                          validateString: context
                              .read<RegisterTransportationCardPrv>()
                              .validateApartment,
                          onChange: (v) {
                            context
                                .read<RegisterTransportationCardPrv>()
                                .apartmentId = v;
                          },
                          label: S.of(context).apartment,
                          selectList: listApartmentChoice,
                          isRequired: true,
                          value: context
                              .read<ResidentInfoPrv>()
                              .selectedApartment
                              ?.apartmentId,
                        ),
                        vpad(16),
                        Text(
                          S.of(context).trans_info,
                          style: txtBodySmallRegular(color: grayScaleColorBase),
                        ),
                        vpad(16),
                        PrimaryDropDown(
                          value: context
                              .read<RegisterTransportationCardPrv>()
                              .vehicleType,
                          validateString: context
                              .read<RegisterTransportationCardPrv>()
                              .validateVehicleType,
                          onChange: (v) {
                            context
                                .read<RegisterTransportationCardPrv>()
                                .vehicleType = v;
                          },
                          label: S.of(context).trans_type,
                          selectList: vehicleTypeList,
                          isRequired: true,
                        ),
                        vpad(16),
                        PrimaryTextField(
                          validateString: context
                              .watch<RegisterTransportationCardPrv>()
                              .validateLiceneNum,
                          validator: ((v) {
                            if (v!.isEmpty) {
                              return '';
                            }
                            return null;
                          }),
                          controller: context
                              .read<RegisterTransportationCardPrv>()
                              .liceneController,
                          label: S.of(context).licene_plate,
                          hint:
                              '${S.of(context).enter} ${S.of(context).licene_plate.toLowerCase()}',
                          isRequired: true,
                        ),
                        vpad(16),
                        PrimaryTextField(
                          validateString: context
                              .watch<RegisterTransportationCardPrv>()
                              .validateRegNum,
                          validator: ((v) {
                            if (v!.isEmpty) {
                              return '';
                            }
                            return null;
                          }),
                          keyboardType: TextInputType.number,
                          controller: context
                              .read<RegisterTransportationCardPrv>()
                              .regNumController,
                          label: S.of(context).reg_num,
                          hint:
                              '${S.of(context).enter} ${S.of(context).reg_num.toLowerCase()}',
                          isRequired: true,
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
                              S.of(context).trans_cer,
                              style:
                                  txtBodySmallBold(color: grayScaleColorBase),
                            ),
                            Text(
                              "*",
                              style: txtBodySmallBold(color: redColorBase),
                            ),
                          ],
                        ),
                        vpad(16),
                        if (isEdit &&
                            context
                                    .watch<RegisterTransportationCardPrv>()
                                    .imageUrlFront !=
                                null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).photo_front_side,
                                style: txtBodySmallRegular(
                                    color: grayScaleColorBase),
                              ),
                              vpad(12),
                              SizedBox(
                                height: 116,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                  '${ApiConstants.uploadURL}/?load=${context.watch<RegisterTransportationCardPrv>().imageUrlFront!}')),
                                          Positioned(
                                            top: 2,
                                            right: 2,
                                            child: PrimaryIcon(
                                              icons: PrimaryIcons.close,
                                              style: PrimaryIconStyle.gradient,
                                              gradients:
                                                  PrimaryIconGradient.red,
                                              color: Colors.white,
                                              padding: const EdgeInsets.all(4),
                                              onTap: () {
                                                context
                                                    .read<
                                                        RegisterTransportationCardPrv>()
                                                    .removeImageTwoSide(
                                                        context, true);
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
                                        .watch<RegisterTransportationCardPrv>()
                                        .imageUrlFront ==
                                    null))
                          SelectMediaWidget(
                            isDash: context
                                    .watch<RegisterTransportationCardPrv>()
                                    .imageFileFront
                                    .isNotEmpty
                                ? false
                                : true,
                            images: context
                                .watch<RegisterTransportationCardPrv>()
                                .imageFileFront,
                            title: S.of(context).photo_front_side,
                            onRemove: context
                                .read<RegisterTransportationCardPrv>()
                                .onRemoveFront,
                            onSelect: () {
                              context
                                  .read<RegisterTransportationCardPrv>()
                                  .onSelectFrontPhoto(context);
                            },
                          ),
                        vpad(16),
                        if (isEdit &&
                            context
                                    .watch<RegisterTransportationCardPrv>()
                                    .imageUrlBack !=
                                null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).photo_back_side,
                                style: txtBodySmallRegular(
                                    color: grayScaleColorBase),
                              ),
                              vpad(12),
                              SizedBox(
                                height: 116,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 14.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                  '${ApiConstants.uploadURL}/?load=${context.watch<RegisterTransportationCardPrv>().imageUrlBack!}')),
                                          Positioned(
                                            top: 2,
                                            right: 2,
                                            child: PrimaryIcon(
                                              icons: PrimaryIcons.close,
                                              style: PrimaryIconStyle.gradient,
                                              gradients:
                                                  PrimaryIconGradient.red,
                                              color: Colors.white,
                                              padding: const EdgeInsets.all(4),
                                              onTap: () {
                                                context
                                                    .read<
                                                        RegisterTransportationCardPrv>()
                                                    .removeImageTwoSide(
                                                        context, false);
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
                                        .watch<RegisterTransportationCardPrv>()
                                        .imageUrlBack ==
                                    null))
                          SelectMediaWidget(
                            isDash: context
                                    .watch<RegisterTransportationCardPrv>()
                                    .imageFileBack
                                    .isNotEmpty
                                ? false
                                : true,
                            images: context
                                .watch<RegisterTransportationCardPrv>()
                                .imageFileBack,
                            title: S.of(context).photo_back_side,
                            onRemove: context
                                .read<RegisterTransportationCardPrv>()
                                .onRemoveBack,
                            onSelect: () {
                              context
                                  .read<RegisterTransportationCardPrv>()
                                  .onSelectBackPhoto(context);
                            },
                          ),
                        // SelectMediaWidget(
                        //   isDash: context
                        //               .read<RegisterTransportationCardPrv>()
                        //               .imagesVehicle
                        //               .length <
                        //           2
                        //       ? true
                        //       : false,
                        //   images: context
                        //       .watch<RegisterTransportationCardPrv>()
                        //       .imagesVehicle,
                        //   title: S.of(context).reg_trans_photos,
                        //   onRemove: context
                        //       .read<RegisterTransportationCardPrv>()
                        //       .onRemoveImageV,
                        //   onSelect: () {
                        //     if (context
                        //             .read<RegisterTransportationCardPrv>()
                        //             .imagesVehicle
                        //             .length <
                        //         2) {
                        //       context
                        //           .read<RegisterTransportationCardPrv>()
                        //           .onSelectImageVehicle(context);
                        //     }
                        //   },
                        // ),
                        vpad(16),
                        SelectMediaWidget(
                          // isDash: context
                          //             .read<RegisterTransportationCardPrv>()
                          //             .imagesVehicle
                          //             .length <
                          //         2
                          //     ? true
                          //     : false,
                          existImages: context
                                  .watch<RegisterTransportationCardPrv>()
                                  .otherExistedImages ??
                              [],
                          onRemoveExist: context
                              .read<RegisterTransportationCardPrv>()
                              .onRemoveExist,
                          images: context
                              .watch<RegisterTransportationCardPrv>()
                              .imagesRelated,
                          title: S.of(context).related_photo,
                          onRemove: context
                              .read<RegisterTransportationCardPrv>()
                              .onRemoveImageR,
                          onSelect: () {
                            context
                                .read<RegisterTransportationCardPrv>()
                                .onSelectImageRelated(context);
                          },
                        ),
                        vpad(36),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PrimaryButton(
                              isLoading: context
                                  .watch<RegisterTransportationCardPrv>()
                                  .isLoading,
                              buttonSize: ButtonSize.medium,
                              text: isEdit
                                  ? S.of(context).update
                                  : S.of(context).add_new,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                context
                                    .read<RegisterTransportationCardPrv>()
                                    .onAddNewTransCard(context, false);
                              },
                            ),
                            PrimaryButton(
                              isLoading: context
                                  .watch<RegisterTransportationCardPrv>()
                                  .isLoading,
                              buttonSize: ButtonSize.medium,
                              buttonType: ButtonType.green,
                              text: S.of(context).send_request,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                context
                                    .read<RegisterTransportationCardPrv>()
                                    .onAddNewTransCard(context, true);
                              },
                            ),
                          ],
                        ),
                        vpad(MediaQuery.of(context).padding.bottom + 24)
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
