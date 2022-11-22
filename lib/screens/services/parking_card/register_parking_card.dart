import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_error_widget.dart';
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
    return ChangeNotifierProvider(
      create: (context) => RegisterTransportationCardPrv(
          apartmentId:
              context.read<ResidentInfoPrv>().selectedApartment?.apartmentId),
      builder: (context, state) {
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
                          validator: ((v) {
                            if (v!.isEmpty) {
                              return '';
                            }
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
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: context
                        //           .watch<RegisterTransportationCardPrv>()
                        //           .isOwner,
                        //       side: const BorderSide(
                        //           color: secondaryColor3, width: 2),
                        //       onChanged: context
                        //           .read<RegisterTransportationCardPrv>()
                        //           .onChangeOwnerOfV,
                        //       activeColor: secondaryColor2,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(4)),
                        //     ),
                        //     hpad(8),
                        //     Text('S.of(context).owner_of_vehicle',
                        //         style: txtBodySmallBold(color: grayScaleColor2))
                        //   ],
                        // ),
                        vpad(16),
                        // PrimaryTextField(
                        //   controller: context
                        //       .read<RegisterTransportationCardPrv>()
                        //       .noteController,
                        //   label: 'S.of(context).note',
                        //   hint: 'S.of(context).enter_note',
                        //   maxLines: 4,
                        // ),
                        // vpad(16),

                        SelectMediaWidget(
                          isDash: context
                                      .read<RegisterTransportationCardPrv>()
                                      .imagesVehicle
                                      .length <
                                  2
                              ? true
                              : false,
                          images: context
                              .watch<RegisterTransportationCardPrv>()
                              .imagesVehicle,
                          title: S.of(context).reg_trans_photos,
                          onRemove: context
                              .read<RegisterTransportationCardPrv>()
                              .onRemoveImageV,
                          onSelect: () {
                            if (context
                                    .read<RegisterTransportationCardPrv>()
                                    .imagesVehicle
                                    .length <
                                2) {
                              context
                                  .read<RegisterTransportationCardPrv>()
                                  .onSelectImageVehicle(context);
                            }
                          },
                        ),
                        vpad(16),
                        SelectMediaWidget(
                          // isDash: context
                          //             .read<RegisterTransportationCardPrv>()
                          //             .imagesVehicle
                          //             .length <
                          //         2
                          //     ? true
                          //     : false,
                          images: context
                              .watch<RegisterTransportationCardPrv>()
                              .imagesRelated,
                          title: S.of(context).related_photo,
                          onRemove: context
                              .read<RegisterTransportationCardPrv>()
                              .onRemoveImageR,
                          onSelect: () {
                            if (context
                                    .read<RegisterTransportationCardPrv>()
                                    .imagesVehicle
                                    .length <
                                2) {
                              context
                                  .read<RegisterTransportationCardPrv>()
                                  .onSelectImageRelated(context);
                            }
                          },
                        ),
                        vpad(36),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PrimaryButton(
                              buttonSize: ButtonSize.medium,
                              text: S.of(context).add_new,
                              onTap: () {
                                // context
                                //     .read<RegisterTransportationCardPrv>()
                                //     .uploadVehicleImage(context);
                                context
                                    .read<RegisterTransportationCardPrv>()
                                    .onSubmitCreate(context);
                              },
                            ),
                            PrimaryButton(
                              buttonSize: ButtonSize.medium,
                              buttonType: ButtonType.green,
                              text: S.of(context).send_request,
                              onTap: () {
                                context
                                    .read<RegisterTransportationCardPrv>()
                                    .uploadVehicleImage(context);
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
