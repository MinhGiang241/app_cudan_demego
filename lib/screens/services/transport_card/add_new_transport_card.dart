import 'package:app_cudan/screens/services/transport_card/prv/add_new_transport_card_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/dash_button.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/select_media_widget.dart';
import 'transport_card_screen.dart.dart';

class AddNewTransportCardScreen extends StatefulWidget {
  const AddNewTransportCardScreen({super.key});
  static const routeName = '/add_transportcard';

  @override
  State<AddNewTransportCardScreen> createState() =>
      _AddNewTransportCardScreenState();
}

class _AddNewTransportCardScreenState extends State<AddNewTransportCardScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddNewTransportCardPrv(),
      builder: (context, snapshot) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: context.read<AddNewTransportCardPrv>().activeStep == 0
                ? S.of(context).reg_transport_card
                : S.of(context).add_new_transport,
            leading: BackButton(
              onPressed: () {
                context.read<AddNewTransportCardPrv>().activeStep == 0
                    ? Navigator.pushReplacementNamed(
                        context,
                        TransportCardScreen.routeName,
                        // arguments: true,
                      )
                    : context.read<AddNewTransportCardPrv>().backStepScreen();
              },
            ),
          ),
          body: SafeArea(
            child: FutureBuilder(
              future:
                  context.read<AddNewTransportCardPrv>().getInitData(context),
              builder: (context, snapshot) {
                var vehicleTypeList =
                    context.read<AddNewTransportCardPrv>().transTypeList;
                var shelfLifeList =
                    context.read<AddNewTransportCardPrv>().shelfLifeList;
                var vehicleTypeListChoices = vehicleTypeList.map((e) {
                  return DropdownMenuItem(
                    value: e.code,
                    child: Text(e.name ?? e.id!),
                  );
                }).toList();

                var shelfLifeListChoices = shelfLifeList.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text('${e.use_time} ${e.type_time}'),
                  );
                }).toList();
                return PageView(
                  controller:
                      context.read<AddNewTransportCardPrv>().pageController,
                  onPageChanged:
                      context.read<AddNewTransportCardPrv>().onPageChanged,
                  physics:
                      context.watch<AddNewTransportCardPrv>().isDisableCroll
                          ? const NeverScrollableScrollPhysics()
                          : null,
                  children: [
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              vpad(12),
                              Row(
                                children: [
                                  DashButton(
                                    text: S.of(context).add_transport,
                                    lable: S.of(context).transport_list,
                                    isRequired: true,
                                    icon: const PrimaryIcon(
                                      icons: PrimaryIcons.add_to_queue,
                                    ),
                                    onTap: () {
                                      return context
                                          .read<AddNewTransportCardPrv>()
                                          .addTransport();
                                    },
                                  ),
                                ],
                              ),
                              vpad(12),
                              ...context
                                  .watch<AddNewTransportCardPrv>()
                                  .transportList
                                  .asMap()
                                  .entries
                                  .map(
                                (e) {
                                  var trans = vehicleTypeList.firstWhere(
                                      (i) => i.id == e.value.vehicleTypeId);
                                  var expired = shelfLifeList.firstWhere(
                                    (i) => i.id == e.value.shelfLifeId,
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Dismissible(
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        color: secondaryColorBase,
                                        child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                      onDismissed: (direction) {
                                        context
                                            .read<AddNewTransportCardPrv>()
                                            .removeItemTrans(e.key);
                                      },
                                      key: UniqueKey(),
                                      child: PrimaryCard(
                                        onTap: () {
                                          // context
                                          //     .read<AddNewTransportCardPrv>()
                                          //     .addPackage(context, e);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                            horizontal: 16,
                                          ),
                                          child: Row(
                                            children: [
                                              PrimaryIcon(
                                                icons: genTransIcon(trans.code),
                                                style:
                                                    PrimaryIconStyle.gradient,
                                                gradients:
                                                    PrimaryIconGradient.yellow,
                                                size: 32,
                                                padding:
                                                    const EdgeInsets.all(12),
                                                color: Colors.white,
                                              ),
                                              hpad(16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${S.of(context).transport}: ${trans.name}',
                                                      style: txtLinkSmall(),
                                                    ),
                                                    vpad(2),
                                                    if (trans.code != "BICYCLE")
                                                      Text(
                                                        '${S.of(context).licene_plate}: ${e.value.number_plate}',
                                                        style:
                                                            txtBodyXSmallRegular(),
                                                      ),
                                                    if (trans.code != "BICYCLE")
                                                      vpad(2),
                                                    if (trans.code != "BICYCLE")
                                                      Text(
                                                        "${S.of(context).reg_num}: ${e.value.registration_number ?? ""}",
                                                        style:
                                                            txtBodyXSmallRegular(),
                                                      ),
                                                    if (trans.code != "BICYCLE")
                                                      vpad(2),
                                                    Text(
                                                      "${S.of(context).num_seat}: ${e.value.seats ?? ""}",
                                                      style:
                                                          txtBodyXSmallRegular(),
                                                    ),
                                                    vpad(2),
                                                    Text(
                                                      "${S.of(context).used_expired_date}: ${expired.use_time} ${expired.type_time}",
                                                      style:
                                                          txtBodyXSmallRegular(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              vpad(30),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      activeColor: primaryColorBase,
                                      value: context
                                          .watch<AddNewTransportCardPrv>()
                                          .isIntergate,
                                      onChanged: context
                                          .read<AddNewTransportCardPrv>()
                                          .toggleIntergate,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => context
                                        .read<AddNewTransportCardPrv>()
                                        .toggleIntergate(true),
                                    child: Text(
                                      S
                                          .of(context)
                                          .intergrate_existed_resident_card,
                                      style: txtRegular(14, grayScaleColorBase),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              vpad(12),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      activeColor: primaryColorBase,
                                      value: context
                                          .watch<AddNewTransportCardPrv>()
                                          .isObey,
                                      onChanged: context
                                          .read<AddNewTransportCardPrv>()
                                          .toggleObey,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => context
                                        .read<AddNewTransportCardPrv>()
                                        .toggleObey(true),
                                    child: Text(
                                      S.of(context).confirm_obey_regulation,
                                      style: txtRegular(14, grayScaleColorBase),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              vpad(12),
                              Text(
                                S.of(context).building_regulation.toUpperCase(),
                                style: txtBold(
                                  14,
                                  primaryColorBase,
                                ),
                              ),
                              vpad(30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  PrimaryButton(
                                    isLoading: context
                                        .watch<AddNewTransportCardPrv>()
                                        .isAddNewLoading,
                                    buttonSize: ButtonSize.medium,
                                    text:
                                        // isEdit
                                        //     ? S.of(context).update
                                        // :
                                        S.of(context).add_new,
                                    onTap: () => context
                                        .read<AddNewTransportCardPrv>()
                                        .onSendSubmit(context, false),
                                  ),
                                  PrimaryButton(
                                    isLoading: context
                                        .watch<AddNewTransportCardPrv>()
                                        .isSendApproveLoading,
                                    buttonType: ButtonType.green,
                                    buttonSize: ButtonSize.medium,
                                    text: S.of(context).send_request,
                                    onTap: () => context
                                        .read<AddNewTransportCardPrv>()
                                        .onSendSubmit(context, true),
                                  ),
                                ],
                              ),
                              vpad(30),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Form(
                        autovalidateMode:
                            context.watch<AddNewTransportCardPrv>().autoValid
                                ? AutovalidateMode.onUserInteraction
                                : null,
                        key: context.read<AddNewTransportCardPrv>().formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              vpad(12),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  S.of(context).transport_info,
                                  style: txtBodySmallBold(
                                    color: grayScaleColorBase,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              vpad(12),
                              PrimaryDropDown(
                                value: context
                                    .read<AddNewTransportCardPrv>()
                                    .transTypeValue,
                                onChange: context
                                    .read<AddNewTransportCardPrv>()
                                    .onChangeVehicleType,
                                selectList: vehicleTypeListChoices,
                                validator: Utils.emptyValidatorDropdown,
                                validateString: context
                                    .watch<AddNewTransportCardPrv>()
                                    .validateTrans,
                                label: S.of(context).transport,
                                isRequired: true,
                              ),
                              vpad(12),
                              PrimaryTextField(
                                controller: context
                                    .read<AddNewTransportCardPrv>()
                                    .seatNumController,
                                validator: Utils.emptyValidator,
                                validateString: context
                                    .watch<AddNewTransportCardPrv>()
                                    .validateSeat,
                                label: S.of(context).num_seat,
                                isRequired: true,
                                keyboardType: TextInputType.number,
                                onlyNum: true,
                              ),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                vpad(12),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                PrimaryTextField(
                                  controller: context
                                      .read<AddNewTransportCardPrv>()
                                      .liceneController,
                                  validator: Utils.emptyValidator,
                                  validateString: context
                                      .watch<AddNewTransportCardPrv>()
                                      .validateLicene,
                                  label: S.of(context).licene_plate,
                                  isRequired: context
                                      .watch<AddNewTransportCardPrv>()
                                      .isShowLicense,
                                ),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                vpad(12),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                PrimaryTextField(
                                  controller: context
                                      .read<AddNewTransportCardPrv>()
                                      .regNumController,
                                  validator: Utils.emptyValidator,
                                  validateString: context
                                      .watch<AddNewTransportCardPrv>()
                                      .validateReg,
                                  label: S.of(context).trans_reg_num,
                                  isRequired: true,
                                ),
                              vpad(12),
                              PrimaryDropDown(
                                selectList: shelfLifeListChoices,
                                value: context
                                    .read<AddNewTransportCardPrv>()
                                    .expiredValue,
                                label: S.of(context).used_expired_date,
                                isRequired: true,
                                validator: Utils.emptyValidatorDropdown,
                                onChange: context
                                    .read<AddNewTransportCardPrv>()
                                    .onChangeExpire,
                              ),
                              vpad(12),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  S.of(context).photos,
                                  style: txtBodySmallBold(
                                    color: grayScaleColorBase,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                vpad(12),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    S.of(context).reg_trans_photos,
                                    style: txtBodySmallBold(
                                      color: grayScaleColorBase,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                vpad(12),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                SelectMediaWidget(
                                  isRequired: true,
                                  existImages: context
                                      .watch<AddNewTransportCardPrv>()
                                      .frontExistedImages,
                                  images: context
                                      .watch<AddNewTransportCardPrv>()
                                      .imageFileFront,
                                  title: S.of(context).photo_front_side,
                                  onRemove: context
                                      .read<AddNewTransportCardPrv>()
                                      .onRemoveFront,
                                  onRemoveExist: context
                                      .read<AddNewTransportCardPrv>()
                                      .onRemoveExistFront,
                                  onSelect: () {
                                    context
                                        .read<AddNewTransportCardPrv>()
                                        .onSelectFrontPhoto(context);
                                  },
                                ),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                vpad(12),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                SelectMediaWidget(
                                  existImages: context
                                      .watch<AddNewTransportCardPrv>()
                                      .backExistedImages,
                                  isRequired: true,
                                  onRemoveExist: context
                                      .read<AddNewTransportCardPrv>()
                                      .onRemoveExistBack,
                                  images: context
                                      .watch<AddNewTransportCardPrv>()
                                      .imageFileBack,
                                  title: S.of(context).photo_back_side,
                                  onRemove: context
                                      .read<AddNewTransportCardPrv>()
                                      .onRemoveBack,
                                  onSelect: () {
                                    context
                                        .read<AddNewTransportCardPrv>()
                                        .onSelectBackPhoto(context);
                                  },
                                ),
                              vpad(12),
                              SelectMediaWidget(
                                isRequired: true,
                                existImages: context
                                    .watch<AddNewTransportCardPrv>()
                                    .otherExistedImages,
                                onRemoveExist: context
                                    .read<AddNewTransportCardPrv>()
                                    .onRemoveExistOther,
                                images: context
                                    .watch<AddNewTransportCardPrv>()
                                    .otherImages,
                                title: S.of(context).trans_images,
                                onRemove: context
                                    .read<AddNewTransportCardPrv>()
                                    .onRemoveOther,
                                onSelect: () {
                                  context
                                      .read<AddNewTransportCardPrv>()
                                      .onSelectOtherPhoto(context);
                                },
                              ),
                              vpad(30),
                              PrimaryButton(
                                width: double.infinity,
                                isLoading: context
                                    .watch<AddNewTransportCardPrv>()
                                    .isAddTransLoading,
                                text: S.of(context).add_new,
                                onTap: () => context
                                    .read<AddNewTransportCardPrv>()
                                    .onAddTransport(context),
                              ),
                              vpad(30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

PrimaryIcons genTransIcon(String? code) {
  switch (code) {
    case "BICYCLE":
      return PrimaryIcons.bicycle;
    case "ELECTRIC_BIKE":
      return PrimaryIcons.bike;
    case "BIKE":
      return PrimaryIcons.bike;
    case "ELECTRIC_MOTO_BIKE":
      return PrimaryIcons.bike;
    case "CAR":
      return PrimaryIcons.car;
    default:
      return PrimaryIcons.car;
  }
}
