// ignore_for_file: depend_on_referenced_packages

import 'dart:isolate';
import 'dart:ui';

import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/transport_card/prv/add_new_transport_card_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/transportation_card.dart';
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
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      // String id = data[0];
      int status = data[1];
      // int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Download complete");
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  final ReceivePort _port = ReceivePort();

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    var isResident =
        // context.read<ResidentInfoPrv>().residentId != null &&
        context.read<ResidentInfoPrv>().selectedApartment != null;
    var isEdit = arg != null ? arg['isEdit'] : false;
    TransportCard card = TransportCard();
    if (isEdit) {
      card = arg['data'];
    }
    return ChangeNotifierProvider(
      create: (_) => AddNewTransportCardPrv(existedTransport: card),
      builder: (context, snapshot) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: context.watch<AddNewTransportCardPrv>().activeStep == 0
                ? isEdit
                    ? S.of(context).edit_reg_transport
                    : S.of(context).reg_transport_card
                : context.read<AddNewTransportCardPrv>().itemEdit != null
                    ? S.of(context).edit_transport
                    : S.of(context).add_new_transport,
            leading: BackButton(
              onPressed: () {
                context.read<AddNewTransportCardPrv>().activeStep == 0
                    ? Navigator.pushReplacementNamed(
                        context,
                        TransportCardScreen.routeName,
                        arguments: 1,
                      )
                    : context
                        .read<AddNewTransportCardPrv>()
                        .backStepScreen(context);
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
                    value: e.id,
                    child: Text(e.name ?? e.id!),
                  );
                }).toList();
                var vendorListChoice = context
                    .watch<AddNewTransportCardPrv>()
                    .vendorList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name ?? e.id!),
                      ),
                    )
                    .toList();
                var modelListChoice = context
                    .watch<AddNewTransportCardPrv>()
                    .modelList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.name ?? e.id!),
                      ),
                    )
                    .toList();
                var ruleFiles =
                    context.watch<AddNewTransportCardPrv>().rulesFiles;

                var shelfLifeListChoices = shelfLifeList.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child:
                        Text('${e.use_time} ${genShelifeString(e.type_time)}'),
                  );
                }).toList();

                return PageView(
                  controller:
                      context.watch<AddNewTransportCardPrv>().pageController,
                  onPageChanged:
                      context.read<AddNewTransportCardPrv>().onPageChanged,
                  physics:
                      context.watch<AddNewTransportCardPrv>().isDisableCroll
                          ? const NeverScrollableScrollPhysics()
                          : null,
                  children: [
                    Form(
                      onChanged: context
                              .watch<AddNewTransportCardPrv>()
                              .autoValidCustomer
                          ? context
                              .read<AddNewTransportCardPrv>()
                              .formValidationCustomer
                          : null,
                      autovalidateMode: context
                              .watch<AddNewTransportCardPrv>()
                              .autoValidCustomer
                          ? AutovalidateMode.onUserInteraction
                          : null,
                      key: context
                          .read<AddNewTransportCardPrv>()
                          .formKeyCustomer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (!isResident) vpad(12),
                              if (!isResident)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    S.of(context).register_info,
                                    style: txtBodySmallBold(
                                      color: grayScaleColorBase,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              if (!isResident) vpad(12),
                              if (!isResident)
                                PrimaryTextField(
                                  maxLength: 255,
                                  controller: context
                                      .read<AddNewTransportCardPrv>()
                                      .cAddressController,
                                  label: S.of(context).address,
                                  hint: S.of(context).address,
                                  isRequired: true,
                                  validator: Utils.emptyValidator,
                                  validateString: context
                                      .watch<AddNewTransportCardPrv>()
                                      .cValidateAddress,
                                ),
                              if (!isResident) vpad(12),
                              if (!isResident)
                                PrimaryTextField(
                                  onChanged: context
                                      .read<AddNewTransportCardPrv>()
                                      .onChangedIdentity,
                                  blockSpace: true,
                                  maxLength: 12,
                                  onlyText: true,
                                  controller: context
                                      .read<AddNewTransportCardPrv>()
                                      .cIdentityController,
                                  label: S.of(context).cmnd,
                                  hint: S.of(context).cmnd,
                                  isRequired: true,
                                  validator: (v) {
                                    if (v!.trim().isEmpty) {
                                      return '';
                                    } else if (v.trim().length < 9) {
                                      return '';
                                    }
                                    return null;
                                  },
                                  validateString: context
                                      .watch<AddNewTransportCardPrv>()
                                      .cValidateIdentity,
                                ),
                              if (!isResident) vpad(12),
                              if (!isResident)
                                PrimaryTextField(
                                  enable: false,
                                  initialValue: context
                                          .read<ResidentInfoPrv>()
                                          .userInfo
                                          ?.account
                                          ?.phone ??
                                      context
                                          .read<ResidentInfoPrv>()
                                          .userInfo
                                          ?.account
                                          ?.userName,
                                  maxLength: 10,
                                  // controller: context
                                  //     .read<AddNewTransportCardPrv>()
                                  //     .cPhoneController,
                                  label: S.of(context).phone_num,
                                  hint: S.of(context).phone_num,
                                  isRequired: true,
                                  keyboardType: TextInputType.number,
                                  onlyNum: true,
                                  validator: Utils.emptyValidator,
                                  // validateString: context
                                  //     .watch<AddNewTransportCardPrv>()
                                  //     .cValidatePhone,
                                ),
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
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .transportList
                                  .isNotEmpty)
                                vpad(12),
                              ...context
                                  .watch<AddNewTransportCardPrv>()
                                  .transportList
                                  .asMap()
                                  .entries
                                  .map(
                                (e) {
                                  var trans = vehicleTypeList.firstWhereOrNull(
                                    (i) => i.id == e.value.vehicleTypeId,
                                  );
                                  var expired = shelfLifeList.firstWhereOrNull(
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
                                          context
                                              .read<AddNewTransportCardPrv>()
                                              .onTapEditTransport(
                                                e.value,
                                                e.key,
                                              );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                            horizontal: 16,
                                          ),
                                          child: Row(
                                            children: [
                                              PrimaryIcon(
                                                icons:
                                                    genTransIcon(trans?.code),
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
                                                      '${S.of(context).transport}: ${trans?.name}',
                                                      style: txtLinkSmall(),
                                                    ),
                                                    vpad(2),
                                                    if (trans?.code !=
                                                        "BICYCLE")
                                                      Text(
                                                        '${S.of(context).licene_plate}: ${e.value.number_plate}',
                                                        style:
                                                            txtBodyXSmallRegular(),
                                                      ),
                                                    if (trans?.code !=
                                                        "BICYCLE")
                                                      vpad(2),
                                                    if (trans?.code !=
                                                        "BICYCLE")
                                                      Text(
                                                        "${S.of(context).reg_num}: ${e.value.registration_number ?? ""}",
                                                        style:
                                                            txtBodyXSmallRegular(),
                                                      ),
                                                    if (trans?.code !=
                                                        "BICYCLE")
                                                      vpad(2),
                                                    if (trans?.code !=
                                                        "BICYCLE")
                                                      Text(
                                                        "${S.of(context).num_seat}: ${e.value.seats ?? ""}",
                                                        style:
                                                            txtBodyXSmallRegular(),
                                                      ),
                                                    vpad(2),
                                                    Text(
                                                      "${S.of(context).shelflife_money}: ${expired?.use_time} ${genShelifeString(expired?.type_time)}",
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
                              if (isResident)
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
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => context
                                            .read<AddNewTransportCardPrv>()
                                            .toggleIntergate(true),
                                        child: Text(
                                          S
                                              .of(context)
                                              .intergrate_existed_resident_card,
                                          style: txtRegular(
                                              14, grayScaleColorBase),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if (isResident) vpad(12),
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
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => context
                                          .read<AddNewTransportCardPrv>()
                                          .toggleObey(true),
                                      child: Text(
                                        S.of(context).confirm_obey_regulation,
                                        style:
                                            txtRegular(14, grayScaleColorBase),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              vpad(12),
                              Text(
                                S
                                    .of(context)
                                    .building_regulation_trans
                                    .toUpperCase(),
                                style: txtBold(
                                  14,
                                  primaryColorBase,
                                ),
                              ),
                              if (ruleFiles.isNotEmpty) vpad(12),
                              ...ruleFiles.map(
                                (v) => Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () {
                                      Utils.downloadFile(
                                        context: context,
                                        id: v.id,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        v.name ?? "",
                                        style: txtRegular(13, primaryColorBase),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              vpad(30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: PrimaryButton(
                                      isLoading: context
                                          .watch<AddNewTransportCardPrv>()
                                          .isAddNewLoading,
                                      buttonSize: ButtonSize.medium,
                                      text: isEdit
                                          ? S.of(context).update
                                          : S.of(context).add_new,
                                      onTap: () => context
                                          .read<AddNewTransportCardPrv>()
                                          .onSendSubmit(context, false, isEdit),
                                    ),
                                  ),
                                  hpad(10),
                                  Expanded(
                                    flex: 1,
                                    child: PrimaryButton(
                                      isLoading: context
                                          .watch<AddNewTransportCardPrv>()
                                          .isSendApproveLoading,
                                      buttonType: ButtonType.green,
                                      buttonSize: ButtonSize.medium,
                                      text: S.of(context).send_request,
                                      onTap: () => context
                                          .read<AddNewTransportCardPrv>()
                                          .onSendSubmit(context, true, isEdit),
                                    ),
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
                        onChanged:
                            context.watch<AddNewTransportCardPrv>().autoValid
                                ? context
                                    .read<AddNewTransportCardPrv>()
                                    .formValidation
                                : null,
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
                                hint: S.of(context).select_transport,
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
                              PrimaryDropDown(
                                value: context
                                    .watch<AddNewTransportCardPrv>()
                                    .vendorValue,
                                selectList: vendorListChoice,
                                label: S.of(context).branch_vehicle,
                                hint: S.of(context).branch_vehicle,
                                onChange: context
                                    .read<AddNewTransportCardPrv>()
                                    .onSelectVendor,
                              ),
                              vpad(12),
                              PrimaryDropDown(
                                value: context
                                    .watch<AddNewTransportCardPrv>()
                                    .modelValue,
                                selectList: modelListChoice,
                                label: S.of(context).type_vehicle,
                                hint: S.of(context).type_vehicle,
                                onChange: context
                                    .read<AddNewTransportCardPrv>()
                                    .onSelectModel,
                              ),
                              vpad(12),
                              PrimaryTextField(
                                maxLength: 225,
                                label: S.of(context).color,
                                hint: S.of(context).color,
                                controller: context
                                    .read<AddNewTransportCardPrv>()
                                    .colorController,
                              ),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                vpad(12),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                PrimaryTextField(
                                  hint: S.of(context).select_seat_num,
                                  controller: context
                                      .watch<AddNewTransportCardPrv>()
                                      .seatNumController,
                                  validator: context
                                      .watch<AddNewTransportCardPrv>()
                                      .numSeatValidate,
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
                                  blockSpace: true,
                                  filter: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9a-zA-Z-]'),
                                    ),
                                  ],
                                  onChanged: context
                                      .read<AddNewTransportCardPrv>()
                                      .onChangedLicenseNum,
                                  maxLength: 9,
                                  hint: S.of(context).enter_license_num,
                                  controller: context
                                      .watch<AddNewTransportCardPrv>()
                                      .liceneController,
                                  // validator: Utils.emptyValidator,
                                  validateString: context
                                      .watch<AddNewTransportCardPrv>()
                                      .validateLicene,
                                  label: S.of(context).licene_plate,
                                  // isRequired: context
                                  //     .watch<AddNewTransportCardPrv>()
                                  //     .isShowLicense,
                                ),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                vpad(12),
                              if (context
                                  .watch<AddNewTransportCardPrv>()
                                  .isShowLicense)
                                PrimaryTextField(
                                  blockSpace: true,
                                  onlyNum: true,
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  hint: S.of(context).enter_reg_num,
                                  controller: context
                                      .watch<AddNewTransportCardPrv>()
                                      .regNumController,
                                  // validator: context
                                  //     .read<AddNewTransportCardPrv>()
                                  //     .regValidate,
                                  validateString: context
                                      .watch<AddNewTransportCardPrv>()
                                      .validateReg,
                                  label: S.of(context).trans_reg_num,
                                  // isRequired: true,
                                ),
                              vpad(12),
                              PrimaryDropDown(
                                hint: S.of(context).select_expire,
                                validateString: context
                                    .watch<AddNewTransportCardPrv>()
                                    .validateExpire,
                                selectList: shelfLifeListChoices,
                                value: context
                                    .read<AddNewTransportCardPrv>()
                                    .expiredValue,
                                label: S.of(context).shelflife_money,
                                isRequired: true,
                                validator: Utils.emptyValidatorDropdown,
                                onChange: context
                                    .read<AddNewTransportCardPrv>()
                                    .onChangeExpire,
                              ),
                              vpad(12),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: S.of(context).photos,
                                        style: txtBold(12, grayScaleColorBase),
                                      ),
                                      TextSpan(
                                        text: " *",
                                        style: txtBold(12, redColorBase),
                                      ),
                                    ],
                                  ),
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
                                    S.of(context).transport_reg,
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
                                  // isRequired: true,
                                  existImages: context
                                      .watch<AddNewTransportCardPrv>()
                                      .resExistedImages,
                                  images: context
                                      .watch<AddNewTransportCardPrv>()
                                      .imageFileRes,
                                  title: S.of(context).reg_trans_photos,
                                  onRemove: context
                                      .read<AddNewTransportCardPrv>()
                                      .onRemoveResImage,
                                  onRemoveExist: context
                                      .read<AddNewTransportCardPrv>()
                                      .onRemoveExistRes,
                                  onSelect: () {
                                    context
                                        .read<AddNewTransportCardPrv>()
                                        .onSelectResPhoto(context);
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
                              if (!isResident) vpad(12),
                              if (!isResident)
                                SelectMediaWidget(
                                  isRequired: true,
                                  existImages: context
                                      .watch<AddNewTransportCardPrv>()
                                      .cusExistedIdentity,
                                  onRemoveExist: context
                                      .read<AddNewTransportCardPrv>()
                                      .onRemoveExistedCusIdentity,
                                  images: context
                                      .watch<AddNewTransportCardPrv>()
                                      .cusIdentity,
                                  title: S.of(context).cmnd_images,
                                  onRemove: context
                                      .read<AddNewTransportCardPrv>()
                                      .onRemoveCusIdentity,
                                  onSelect: () {
                                    context
                                        .read<AddNewTransportCardPrv>()
                                        .onSelectCusIdentityPhoto(context);
                                  },
                                ),
                              vpad(30),
                              PrimaryButton(
                                width: double.infinity,
                                isLoading: context
                                    .watch<AddNewTransportCardPrv>()
                                    .isAddTransLoading,
                                text: context
                                            .watch<AddNewTransportCardPrv>()
                                            .itemEdit !=
                                        null
                                    ? S.of(context).update
                                    : S.of(context).add_new,
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
