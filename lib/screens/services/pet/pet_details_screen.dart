import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../constants/regulation.dart';
import '../../../generated/l10n.dart';
import '../../../models/info_content_view.dart';
import '../../../models/letter_history.dart';
import '../../../models/pet.dart';
import '../../../models/timeline_model.dart';
import '../../../services/api_history.dart';
import '../../../services/api_service.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_info_widget.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/timeline_view.dart';

class PetDetailsScreen extends StatefulWidget {
  const PetDetailsScreen({super.key});
  static const routeName = '/pet/details';

  @override
  State<PetDetailsScreen> createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  List<LetterHistory> historyList = [];
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Pet;

    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).details,
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
                child: Column(
                  children: [
                    PrimaryInfoWidget(
                      label: S.of(context).reg_pet_info,
                      listInfoView: [
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).pet_name,
                          content: arg.pet_name,
                          contentStyle: txtBold(14, grayScaleColorBase),
                        ),
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).pet_type,
                          content: genType(arg.pet_type ?? ""),
                          contentStyle: txtBold(14, grayScaleColorBase),
                        ),
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).color,
                          content: arg.color,
                          contentStyle: txtBold(14, grayScaleColorBase),
                        ),
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).pet_origin,
                          content: arg.species,
                          contentStyle: txtBold(14, grayScaleColorBase),
                        ),
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).sex,
                          content: genSex(arg.sex ?? ""),
                          contentStyle: txtBold(14, grayScaleColorBase),
                        ),
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).weight,
                          content: "${arg.weight} kg",
                          contentStyle: txtBold(14, grayScaleColorBase),
                        ),
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).reg_code,
                          content: arg.code,
                          contentStyle: txtBold(14, grayScaleColorBase),
                        ),
                        InfoContentView(
                          isHorizontal: true,
                          title: S.of(context).status,
                          content: genStatus(arg.pet_status ?? ""),
                          contentStyle: txtBold(
                            14,
                            genStatusColor(arg.pet_status ?? ""),
                          ),
                        ),
                        if (arg.r != null)
                          InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).cancel_reason,
                            content: arg.r!.name,
                            contentStyle: txtBold(14, grayScaleColorBase),
                          ),
                        if (arg.note != null)
                          InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).note,
                            content: arg.note,
                            contentStyle: txtBold(14, grayScaleColorBase),
                          ),
                        if (arg.describe != null)
                          InfoContentView(
                            isHorizontal: true,
                            title: S.of(context).description,
                            content: arg.describe,
                            contentStyle: txtBold(14, grayScaleColorBase),
                          ),
                        if (arg.avt_pet!.isNotEmpty)
                          InfoContentView(
                            title: S.of(context).photos,
                            images: [
                              ...arg.avt_pet!.map(
                                (e) =>
                                    "${ApiService.shared.uploadURL}/?load=${e.id}&regcode=${ApiService.shared.regCode}",
                              ),
                            ],
                          ),
                      ],
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                S.of(context).cer_vacxin_doc,
                                textAlign: TextAlign.start,
                                style: txtMedium(14, grayScaleColor2),
                              ),
                              Text(
                                " *",
                                style: txtBold(14, redColorBase),
                              ),
                            ],
                          ),
                          vpad(16),
                          ...arg.certificate!.map(
                            (e) => InkWell(
                              onTap: () async {
                                await launchUrl(
                                  Uri.parse(
                                    "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                                  ),
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
                          vpad(16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).minutes,
                              textAlign: TextAlign.start,
                              style: txtMedium(14, grayScaleColor2),
                            ),
                          ),
                          vpad(16),
                          ...arg.report!.map(
                            (e) => InkWell(
                              onTap: () async {
                                await launchUrl(
                                  Uri.parse(
                                    "${ApiService.shared.uploadURL}?load=${e.id}&regcode=${ApiService.shared.regCode}",
                                  ),
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
                          vpad(16),
                          Row(
                            children: [
                              SizedBox(
                                width: 22.0,
                                height: 22.0,
                                child: Checkbox(
                                  activeColor: primaryColorBase,
                                  value: arg.check,
                                  onChanged: (v) {},
                                ),
                              ),
                              hpad(12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: txtMedium(16, grayScaleColor2),
                                    children: [
                                      TextSpan(text: S.of(context).i_agree),
                                      TextSpan(
                                        text: " ${S.of(context).regulations}",
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
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          BackButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                            },
                                                          ),
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .pet_regulation,
                                                            style:
                                                                txtBodyLargeBold(
                                                              color:
                                                                  grayScaleColorBase,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          hpad(50),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 24,
                                                        ),
                                                        child: HtmlWidget(
                                                          petRegulation,
                                                          buildAsync: false,
                                                          onTapUrl: (url) {
                                                            return false;
                                                          },
                                                          textStyle:
                                                              txtBodyMediumRegular(),
                                                        ),
                                                      ),
                                                      vpad(40),
                                                    ],
                                                  )),
                                            );
                                          },
                                      ),
                                      TextSpan(
                                        text:
                                            " ${S.of(context).of_building_management}",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              vpad(bottomSafePad(context) + 24),
            ],
          ),
          FutureBuilder(
            future: () async {
              APIHistory.getHistoryLetter(arg.id, 'pet').then((v) {
                if (v != null) {
                  historyList.clear();
                  for (var i in v) {
                    historyList.add(LetterHistory.fromMap(i));
                  }
                }
                historyList.sort(
                  (a, b) => a.perform_date!.compareTo(b.perform_date ?? ""),
                );
                if (mounted) {
                  setState(() {});
                }
              });
            }(),
            builder: (context, snapshot) {
              return ListView(
                children: [
                  vpad(24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TimeLineView(
                      content: historyList
                          .map(
                            (i) => TimelineModel(
                              date: i.perform_date,
                              title: i.content,
                              subTitle: i.new_status != null
                                  ? '${S.of(context).status}: ${i.ns?.name}'
                                  : null,
                              color: i.new_status != null
                                  ? genStatusColor(i.new_status ?? "")
                                  : null,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

genSex(String sex) {
  switch (sex) {
    case "MALE":
      return S.current.pet_male;
    case "FEMALE":
      return S.current.pet_female;
    default:
      return S.current.other;
  }
}

genType(String sex) {
  switch (sex) {
    case "DOG":
      return S.current.dog;
    case "CAT":
      return S.current.cat;
    case "Other":
      return S.current.other;

    default:
      return S.current.other;
  }
}
