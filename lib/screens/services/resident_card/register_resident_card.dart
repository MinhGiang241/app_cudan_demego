// ignore_for_file: unused_local_variable

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/resident_card.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/select_media_widget.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'prv/register_resident_card_prv.dart';

class RegisterResidentCard extends StatefulWidget {
  static const routeName = '/resident-card/register';
  const RegisterResidentCard({super.key});

  @override
  State<RegisterResidentCard> createState() => _RegisterResidentCardState();
}

class _RegisterResidentCardState extends State<RegisterResidentCard> {
  ReceivePort port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
      port.sendPort,
      'downloader_send_port',
    );
    port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      int progress = data[2];

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

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;

    var isEdit = arg == null ? false : arg['isEdit'];
    ResidentCard card = ResidentCard();
    if (isEdit) {
      card = arg['data'];
    }
    return ChangeNotifierProvider(
      create: (context) => RegisterResidentCardPrv(
        code: card.code,
        id: card.id,
        residentId: context.read<ResidentInfoPrv>().residentId,
        apartmentId: card.apartmentId ??
            context.read<ResidentInfoPrv>().selectedApartment?.apartmentId,
        existCard: card,
      ),
      builder: (context, state) {
        // var listApartmentChoice =
        //     context.read<ResidentInfoPrv>().listOwn.map((e) {
        //   return DropdownMenuItem(
        //     value: e.apartmentId,
        //     child: Text(e.apartment?.name! != null
        //         ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
        //         : e.apartmentId!),
        //   );
        // }).toList();
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: isEdit
                ? S.of(context).edit_res_card
                : S.of(context).register_res_card,
          ),
          body: FutureBuilder(
            future: context.read<RegisterResidentCardPrv>().getRuleFiles(),
            builder: (context, snapshot) {
              var ruleFiles =
                  context.watch<RegisterResidentCardPrv>().rulesFiles;
              return SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    // PrimaryDropDown(
                    //   isDense: false,
                    //   onChange: (v) {
                    //     context.read<RegisterResidentCardPrv>().apartmentId = v;
                    //   },
                    //   label: S.of(context).apartment,
                    //   selectList: listApartmentChoice,
                    //   isRequired: true,
                    //   value: context.read<RegisterResidentCardPrv>().apartmentId,
                    // ),

                    vpad(16),

                    SelectMediaWidget(
                      isRequired: true,
                      existImages: context
                          .watch<RegisterResidentCardPrv>()
                          .identityImageExisted,
                      images: context
                          .watch<RegisterResidentCardPrv>()
                          .identityImageFiles,
                      title: S.of(context).cmnd_photos,
                      onRemove: context
                          .read<RegisterResidentCardPrv>()
                          .onRemoveIdentity,
                      onRemoveExist: context
                          .read<RegisterResidentCardPrv>()
                          .onRemoveExistIdentity,
                      onSelect: () {
                        context
                            .read<RegisterResidentCardPrv>()
                            .onSelectIdentity(context);
                      },
                    ),
                    vpad(16),

                    SelectMediaWidget(
                      images: context
                          .watch<RegisterResidentCardPrv>()
                          .residentImageFiles,
                      existImages: context
                          .watch<RegisterResidentCardPrv>()
                          .residentImageExisted,
                      onRemoveExist: context
                          .read<RegisterResidentCardPrv>()
                          .onRemoveExistRes,
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

                    SelectMediaWidget(
                      existImages: context
                          .watch<RegisterResidentCardPrv>()
                          .otherImageExisted,
                      onRemoveExist: context
                          .read<RegisterResidentCardPrv>()
                          .onRemoveExistOtherImage,
                      images: context
                          .watch<RegisterResidentCardPrv>()
                          .otherImageFiles,
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
                    vpad(16),
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            activeColor: primaryColorBase,
                            value: context
                                .watch<RegisterResidentCardPrv>()
                                .confirm,
                            onChanged: context
                                .read<RegisterResidentCardPrv>()
                                .toggleConfirm,
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => context
                                .read<RegisterResidentCardPrv>()
                                .toggleConfirm(true),
                            child: Text(
                              S.of(context).confirm_obey_regulation,
                              style: txtRegular(14, grayScaleColorBase),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      ],
                    ),
                    vpad(16),
                    Text(
                      S.of(context).building_regulation.toUpperCase(),
                      style: txtBold(
                        14,
                        primaryColorBase,
                      ),
                    ),
                    if (ruleFiles.isNotEmpty) vpad(12),
                    ...ruleFiles.map(
                      (v) => InkWell(
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
                    vpad(36),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            isLoading: context
                                .watch<RegisterResidentCardPrv>()
                                .isAddNewLoading,
                            buttonSize: ButtonSize.medium,
                            text: isEdit
                                ? S.of(context).update
                                : S.of(context).add_new,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              context
                                  .read<RegisterResidentCardPrv>()
                                  .onSubmitCard(context, false);
                            },
                          ),
                        ),
                        hpad(10),
                        Expanded(
                          child: PrimaryButton(
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
                        ),
                      ],
                    ),

                    vpad(MediaQuery.of(context).padding.bottom + 24)
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
