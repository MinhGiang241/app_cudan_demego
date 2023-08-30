import 'package:app_cudan/models/construction.dart';
import 'package:app_cudan/services/api_construction.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../models/timeline_model.dart';
import '../../../../widgets/timeline_view.dart';

class ConstructionDocumentHistoryTab extends StatefulWidget {
  const ConstructionDocumentHistoryTab({
    super.key,
    required this.constructionDocumentId,
  });
  final String constructionDocumentId;
  @override
  State<ConstructionDocumentHistoryTab> createState() =>
      _ConstructionDocumentHistoryTabState();
}

class _ConstructionDocumentHistoryTabState
    extends State<ConstructionDocumentHistoryTab> {
  List<TimelineModel> history = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        await APIConstruction.getConstructionDocumentHistory(
          widget.constructionDocumentId,
        ).then((v) {
          if (v != null) {
            history.clear();
            for (var i in v) {
              var his = ConstructionDocumentHistory.fromMap(i);
              history.add(
                TimelineModel(
                  date: his.date ?? his.createdTime,
                  title: genStatusDocHis(his.status),
                  subTitle: his.content,
                  color: genColorDocHis(his.status),
                ),
              );
            }
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
                content: history,
              ),
            ),
          ],
        );
      },
    );
  }

  genColorDocHis(String? status) {
    switch (status) {
      case "UNDER_CONSTRUCTION":
        return yellowColor;
      case "WAIT_ACCEPTANCE":
        return primaryColorBase;
      case "UNDER_ACCEPTANCE":
        return greenColorBase;
      case "VIOLATION_RECORD":
        return redColorBase;
      case "COMPLETE":
        return greenColor6;
      case "PAUSE_CONSTRUCTION":
        return orangeColor;
      default:
        return grayScaleColorBase;
    }
  }

  genStatusDocHis(String? status) {
    switch (status) {
      case "UNDER_CONSTRUCTION":
        return S.current.under_construction;
      case "WAIT_ACCEPTANCE":
        return S.current.wait_acceptance;
      case "UNDER_ACCEPTANCE":
        return S.current.under_acceptance;
      case "VIOLATION_RECORD":
        return S.current.violation_exe;
      case "COMPLETE":
        return S.current.complete;
      case "PAUSE_CONSTRUCTION":
        return S.current.pause_construction;
      default:
        return S.current.continue_construction;
    }
  }
}
