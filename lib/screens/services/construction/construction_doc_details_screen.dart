import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/widgets/primary_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/api_constant.dart';
import '../../../constants/constants.dart';
import '../../../constants/regulation.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../services/api_construction.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/timeline_view.dart';
import '../../payment/widget/payment_item.dart';
import 'tab/construction_history_tab.dart';

class ConstructionDocumentDetailsScreen extends StatefulWidget {
  const ConstructionDocumentDetailsScreen({super.key});
  static const routeName = '/construction/doc-details';

  @override
  State<ConstructionDocumentDetailsScreen> createState() =>
      _ConstructionDocumentDetailsState();
}

class _ConstructionDocumentDetailsState
    extends State<ConstructionDocumentDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  var isShowRecorg = false;
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ConstructionDocument reg = ConstructionDocument();
    if (arg['cons'] != null) {
      reg = arg['cons'];
    }
    var apartment = context.read<ResidentInfoPrv>().selectedApartment;
    var surface = '';
    if (apartment != null) {
      surface =
          "${apartment.apartment!.name}, ${apartment.floor!.name}, ${apartment.building!.name}";
    }
    var draws = [...reg.current_draw!, ...reg.renovation_draw!];
    return PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).cons_file_details,
          tabController: tabController,
          isTabScrollabel: false,
          tabs: [
            Tab(text: S.of(context).details),
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
                          left: 8, right: 8, top: 16, bottom: 16),
                      child: Text(
                        surface,
                        style: txtMedium(14, grayScaleColor2),
                      ),
                    )),
                vpad(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PrimaryInfoWidget(
                    label: S.of(context).file_info,
                    listInfoView: [
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).cons_type,
                        content: reg.constructionType!.name ?? "",
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).cons_code,
                        content: reg.c!.code ?? "",
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).reg_date,
                        content: Utils.dateTimeFormat(reg.reg_date ?? "", 1),
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).approved_date,
                        content: Utils.dateTimeFormat(reg.createdTime ?? "", 1),
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).file_code,
                        content: reg.code,
                        contentStyle: txtBold(14, grayScaleColorBase),
                      ),
                      InfoContentView(
                        isHorizontal: true,
                        title: S.of(context).file_status,
                        content: reg.s!.name ?? "",
                        contentStyle:
                            txtBold(14, genStatusColor(reg.status ?? "")),
                      ),
                      // InfoContentView(
                      //   isHorizontal: true,
                      //   title: S.of(context).cancel_reason,
                      //   content: reg.ca ?? "",
                      //   contentStyle: txtBold(14, grayScaleColorBase),
                      // ),
                    ],
                  ),
                ),
                vpad(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    S.of(context).cons_drawing,
                    style: txtMedium(14, grayScaleColor2),
                  ),
                ),
                vpad(12),
                ...draws.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () async {
                        await launchUrl(
                          Uri.parse("${ApiConstants.uploadURL}?load=${e.id}"),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          e.name ?? "",
                          textAlign: TextAlign.left,
                          style: txtMedium(
                            14,
                            primaryColor6,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                vpad(16),
                if (reg.status == "COMPLETE" && reg.v!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(children: [
                      Text("${S.of(context).violation_record}:",
                          style: txtMedium(14, grayScaleColor2)),
                      hpad(30),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isShowRecorg = !isShowRecorg;
                            });
                          },
                          child: Text(S.of(context).view_record))
                    ]),
                  ),

                vpad(12),
                if (reg.v!.isNotEmpty && isShowRecorg)
                  ...reg.v![0].image!.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: InkWell(
                        onTap: () async {
                          await launchUrl(
                            Uri.parse("${ApiConstants.uploadURL}?load=${e.id}"),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            e.name ?? "",
                            textAlign: TextAlign.left,
                            style: txtMedium(
                              14,
                              primaryColor6,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 22.0,
                //       height: 22.0,
                //       child: Checkbox(
                //         fillColor: MaterialStateProperty.all(primaryColorBase),
                //         value: reg.confirm,
                //         onChanged: (v) {},
                //       ),
                //     ),
                //     hpad(12),
                //     Expanded(
                //       child: RichText(
                //         text: TextSpan(
                //             style: txtMedium(16, grayScaleColor2),
                //             children: [
                //               TextSpan(text: S.of(context).i_confirm),
                //               TextSpan(
                //                 text: " ${S.of(context).here}",
                //                 style: txtMedium(16, primaryColor6),
                //                 recognizer: TapGestureRecognizer()
                //                   ..onTap = () {
                //                     showModalBottomSheet(
                //                       isScrollControlled: true,
                //                       context: context,
                //                       builder: ((context) => ListView(
                //                             children: [
                //                               vpad(40),
                //                               Row(
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment
                //                                         .spaceBetween,
                //                                 children: [
                //                                   BackButton(onPressed: () {
                //                                     Navigator.pop(context);
                //                                   }),
                //                                   Text(
                //                                     S
                //                                         .of(context)
                //                                         .cons_regulation,
                //                                     style: txtBodyLargeBold(
                //                                         color:
                //                                             grayScaleColorBase),
                //                                     textAlign: TextAlign.center,
                //                                   ),
                //                                   hpad(50)
                //                                 ],
                //                               ),
                //                               Padding(
                //                                 padding:
                //                                     const EdgeInsets.symmetric(
                //                                         horizontal: 24),
                //                                 child: HtmlWidget(
                //                                   consRe,
                //                                   buildAsync: false,
                //                                   onTapUrl: (url) {
                //                                     return false;
                //                                   },
                //                                   textStyle:
                //                                       txtBodyMediumRegular(),
                //                                 ),
                //                               ),
                //                               vpad(40),
                //                             ],
                //                           )),
                //                     );
                //                   },
                //               ),
                //             ]),
                //       ),
                //     ),
                //   ],
                // ),
                vpad(40),
              ],
            ),
            ConstructionHistoryTab(
              constructionregistrationId: reg.constructionRegistrationId ?? "",
            )
          ],
        ));
  }
}
