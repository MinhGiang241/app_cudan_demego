import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/construction/tab/construction_history_tab.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:app_cudan/widgets/select_file_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../constants/regulation.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../payment/widget/payment_item.dart';
import 'tab/construction_bill_tab.dart';

class ConstructionRegistrationDetailsScreen extends StatefulWidget {
  const ConstructionRegistrationDetailsScreen({super.key});
  static const routeName = '/construction/reg-details';

  @override
  State<ConstructionRegistrationDetailsScreen> createState() =>
      _ConstructionRegistrationDetailsScreenState();
}

class _ConstructionRegistrationDetailsScreenState
    extends State<ConstructionRegistrationDetailsScreen>
    with TickerProviderStateMixin {
  ReceivePort port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
      port.sendPort,
      'downloader_send_port',
    );
    port.listen((dynamic data) {
      // String id = data[0];
      DownloadTaskStatus status = data[1];
      // int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Download complete");
        log(data);
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
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

  late TabController tabController = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ConstructionRegistration reg = ConstructionRegistration();
    if (arg['cons'] != null) {
      reg = arg['cons'];
    }
    var listApart = context.read<ResidentInfoPrv>().listOwn;
    var apartment = listApart
        .firstWhere((element) => element.apartmentId == reg.apartmentId);
    var surface = '';
    // ignore: unnecessary_null_comparison
    if (apartment != null) {
      surface =
          "${apartment.apartment!.name}, ${apartment.floor!.name}, ${apartment.building!.name}";
    }
    var draws = [...reg.current_draw!, ...reg.renovation_draw!];
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).cons_reg_detail,
        tabController: tabController,
        isTabScrollabel: false,
        tabs: [
          Tab(text: S.of(context).details),
          Tab(text: S.of(context).bill),
          Tab(text: S.of(context).history),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ListView(
            children: [
              vpad(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  S.of(context).surface,
                  style: txtMedium(14, grayScaleColor2),
                ),
              ),
              vpad(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PrimaryCard(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 16,
                    bottom: 16,
                  ),
                  child: Text(
                    surface,
                    style: txtMedium(14, grayScaleColor2),
                  ),
                ),
              ),
              vpad(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PrimaryInfoWidget(
                  label: S.of(context).file_info,
                  listInfoView: [
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).cons_type,
                      content: reg.constructionType!.name ?? '',
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).reg_code,
                      content: reg.code,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).reg_date,
                      content: Utils.dateTimeFormat(reg.createdTime ?? "", 1),
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title:
                          '${S.of(context).start_time}- ${S.of(context).end}',
                      content:
                          '${Utils.dateFormat(reg.time_start ?? "", 1)} - ${Utils.dateFormat(reg.time_end ?? "", 1)}',
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    if (reg.construction_cost != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).cons_fee,
                        content: formatCurrency.format(reg.construction_cost),
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                    if (reg.deposit_fee != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).deposit,
                        content: formatCurrency.format(reg.deposit_fee),
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).cons_day,
                      content: reg.working_day.toString(),
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).off_day,
                      content: reg.off_day.toString(),
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    if (reg.description != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).work_description,
                        content: reg.description,
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).letter_status,
                      content: (reg.status == "WAIT_TECHNICAL" ||
                              reg.status == "WAIT_MANAGER")
                          ? S.of(context).wait_approve
                          : (reg.s!.name ?? ""),
                      contentStyle: txtBold(
                        14,
                        (reg.status == "WAIT_TECHNICAL" ||
                                reg.status == "WAIT_MANAGER")
                            ? greenColor9
                            : genStatusColor(reg.status ?? ""),
                      ),
                    ),
                    if (reg.r != null)
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).cancel_reason,
                        content: reg.r!.name ?? "",
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                    // if (reg.reason_description != null)
                    //   InfoContentView(
                    //     isHorizontal: true,
                    //     title: S.of(context).note,
                    //     content: reg.reason_description ?? "",
                    //     contentStyle: txtBold(14, grayScaleColorBase),
                    //   ),
                    if (reg.file_cancel != null && reg.file_cancel!.isNotEmpty)
                      InfoContentView(
                        // isHorizontal: true,
                        title: S.of(context).additional_file,
                        files: reg.file_cancel,

                        // contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                  ],
                ),
              ),
              vpad(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PrimaryInfoWidget(
                  label: S.of(context).cons_unit_info,
                  listInfoView: [
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).cons_unit,
                      content: reg.construction_unit,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).address,
                      content: reg.construction_add,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).email,
                      content: reg.construction_email,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).deputy,
                      content: reg.deputy,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).deputy_phone,
                      content: reg.deputy_phone,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).cmnd,
                      content: reg.deputy_identity,
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                    InfoContentView(
                      isHorizontal: true,
                      title: S.of(context).worker_num,
                      content: (reg.worker_num ?? '').toString(),
                      contentStyle: txtBold(14, grayScaleColorBase),
                    ),
                  ],
                ),
              ),
              if (reg.current_draw != null && reg.current_draw!.isNotEmpty)
                vpad(16),
              if (reg.current_draw != null && reg.current_draw!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    S.of(context).exist_drawing,
                    style: txtMedium(14, grayScaleColor2),
                  ),
                ),
              if (reg.current_draw != null && reg.current_draw!.isNotEmpty)
                SelectFileWidget(
                  enable: false,
                  existFiles: reg.current_draw ?? [],
                ),
              // ...draws.map(
              if (reg.renovation_draw != null &&
                  reg.renovation_draw!.isNotEmpty)
                vpad(16),
              if (reg.renovation_draw != null &&
                  reg.renovation_draw!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    S.of(context).cons_drawing,
                    style: txtMedium(14, grayScaleColor2),
                  ),
                ),
              if (reg.renovation_draw != null &&
                  reg.renovation_draw!.isNotEmpty)
                SelectFileWidget(
                  enable: false,
                  existFiles: reg.renovation_draw ?? [],
                ),
              //   (e) => Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     child: InkWell(
              //       onTap: () async {
              //         Utils.downloadFile(
              //           context: context,
              //           id: e.id,
              //         );
              //       },
              //       child: Align(
              //         alignment: Alignment.centerLeft,
              //         child: Text(
              //           e.name ?? "",
              //           textAlign: TextAlign.left,
              //           style: txtMedium(
              //             14,
              //             primaryColor6,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              vpad(16),
              Row(
                children: [
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Checkbox(
                      fillColor: MaterialStateProperty.all(primaryColorBase),
                      value: reg.confirm,
                      onChanged: (v) {},
                    ),
                  ),
                  hpad(12),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: txtMedium(16, grayScaleColor2),
                        children: [
                          TextSpan(text: S.of(context).i_confirm),
                          TextSpan(
                            text: " ${S.of(context).here}",
                            style: txtMedium(16, primaryColor6),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: ((context) => ListView(
                                        children: [
                                          vpad(40),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BackButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              Text(
                                                S.of(context).cons_regulation,
                                                style: txtBodyLargeBold(
                                                  color: grayScaleColorBase,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              hpad(50)
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                            ),
                                            child: HtmlWidget(
                                              consRe,
                                              buildAsync: false,
                                              onTapUrl: (url) {
                                                return false;
                                              },
                                              textStyle: txtBodyMediumRegular(),
                                            ),
                                          ),
                                          vpad(40),
                                        ],
                                      )),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              vpad(40),
            ],
          ),
          ConstructionBillTab(
            constructionregistrationId: reg.id ?? "",
            isPay: reg.status == "WAIT_PAY",
          ),
          ConstructionHistoryTab(
            constructionregistrationId: reg.id ?? "",
          )
        ],
      ),
    );
  }
}
