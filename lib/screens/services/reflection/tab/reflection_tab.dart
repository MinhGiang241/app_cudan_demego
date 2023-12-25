import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/screens/services/reflection/prv/reflection_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/info_content_view.dart';
import '../../../../models/reflection.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/primary_card.dart';
import '../../../../widgets/primary_empty_widget.dart';
import '../../../../widgets/primary_error_widget.dart';
import '../../../../widgets/primary_icon.dart';
import '../../../../widgets/primary_loading.dart';
import '../create_reflection.dart';
import '../reflection_processed_details.dart';

class ReflectionTab extends StatefulWidget {
  const ReflectionTab({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<ReflectionTab> createState() => _ReflectionTabState();
}

String _getStatus(int index) {
  switch (index) {
    case 0:
      return 'ALL';
    case 1:
      return 'WAIT_PROGRESS';
    case 2:
      return 'PROCESSING';
    case 3:
      return 'PROCESSED';
    case 4:
      return 'NEW';
    case 5:
      return 'CANCEL';
    default:
      return 'ALL';
  }
}

class _ReflectionTabState extends State<ReflectionTab> {
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    var status = _getStatus(widget.tabIndex);
    var residentId = context.read<ResidentInfoPrv>().residentId;
    var listReflection = context.read<ReflectionPrv>().listReflection;
    return FutureBuilder(
      future: context
          .read<ReflectionPrv>()
          .getReflection(context, status, residentId ?? ''),
      builder: (context, snapshot) {
        List<Reflection> newL = [];
        List<Reflection> wait = [];
        List<Reflection> processing = [];
        List<Reflection> processed = [];
        List<Reflection> cancel = [];

        for (var i in listReflection) {
          if (i.status == "NEW") {
            newL.add(i);
          } else if (i.status == "WAIT_PROGRESS") {
            wait.add(i);
          } else if (i.status == "PROCESSING") {
            processing.add(i);
          } else if (i.status == "PROCESSED") {
            processed.add(i);
          } else if (i.status == "CANCEL") {
            cancel.add(i);
          }
        }

        newL.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        wait.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        processing.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        processed.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));
        cancel.sort((a, b) => b.updatedTime!.compareTo(a.updatedTime!));

        List<Reflection> list = newL + wait + processing + processed + cancel;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: PrimaryLoading());
        } else if (snapshot.connectionState == ConnectionState.none) {
          return PrimaryErrorWidget(
            code: snapshot.hasError ? 'err' : '1',
            message: snapshot.data.toString(),
            onRetry: () async {
              setState(() {});
            },
          );
        } else if (list.isEmpty) {
          return SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropMaterialHeader(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onRefresh: () {
              setState(() {});
            },
            child: PrimaryEmptyWidget(
              emptyText: S.of(context).no_reflection,
              icons: PrimaryIcons.mail,
              action: () {},
            ),
          );
        }
        return SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropMaterialHeader(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onRefresh: () {
            setState(() {});
          },
          child: ListView(
            children: [
              vpad(12),
              ...list.map((e) {
                return Stack(
                  children: [
                    PrimaryCard(
                      margin: const EdgeInsets.only(
                        bottom: 16,
                        left: 12,
                        right: 12,
                      ),
                      onTap: () {
                        if (e.status == 'PROCESSED') {
                          Navigator.pushNamed(
                            context,
                            ReflectionProcessedDetails.routeName,
                            arguments: e,
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            CreateReflection.routeName,
                            arguments: {
                              'isEdit': true,
                              'ref': e,
                              'status': e.status,
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            PrimaryIcon(
                              icons: e.ticket_type == 'COMPLAIN'
                                  ? PrimaryIcons.mail
                                  : PrimaryIcons.feedback,
                              style: PrimaryIconStyle.gradient,
                              gradients: PrimaryIconGradient.yellow,
                              size: 32,
                              padding: const EdgeInsets.all(12),
                              color: Colors.white,
                            ),
                            hpad(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vpad(10),
                                  Text(
                                    // (e.ticket_type == "COMPLAIN"
                                    //         ? e.complainReason != null
                                    //             ? e.complainReason!.content
                                    //             : ""
                                    //         : e.opinionContribute != null
                                    //             ? e.opinionContribute!.content
                                    //             : "") ??
                                    e.opinionContribute?.content ?? '',
                                    style: txtBold(16),
                                  ),
                                  vpad(4),
                                  Table(
                                    textBaseline: TextBaseline.ideographic,
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.baseline,
                                    columnWidths: const {
                                      0: FlexColumnWidth(2),
                                      1: FlexColumnWidth(2),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Text(
                                            '${S.of(context).created_date}:',
                                          ),
                                          Text(
                                            Utils.dateFormat(e.date ?? '', 1),
                                          ),
                                        ],
                                      ),
                                      TableRow(children: [vpad(2), vpad(2)]),
                                      TableRow(
                                        children: [
                                          Text('${S.of(context).letter_num}:'),
                                          Text(
                                            e.code ?? '',
                                          ),
                                        ],
                                      ),
                                      TableRow(children: [vpad(2), vpad(2)]),
                                      TableRow(
                                        children: [
                                          Text('${S.of(context).status}:'),
                                          Text(
                                            e.s!.name ?? '',
                                            style: txtBold(
                                              14,
                                              genStatusColor(e.status ?? ''),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (genStatusColor(e.ticket_type as String)),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          genStatus(e.ticket_type ?? ''),
                          style: txtSemiBold(12, Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              vpad(80),
            ],
          ),
        );
      },
    );
  }
}
