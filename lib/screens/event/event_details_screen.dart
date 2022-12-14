import 'package:app_cudan/widgets/primary_image_netword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/api_constant.dart';
import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/event.dart';
import '../../services/api_event.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_screen.dart';
import '../auth/prv/resident_info_prv.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});
  static const routeName = '/event/details';

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isShowButtonParticipation = true;
  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    final event = arg['event'];
    final onParticipate = arg['part'];
    if (event.e != null || event.isShowButtonParticipate == false) {
      isShowButtonParticipation = false;
    }
    return PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).event,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              vpad(16),
              Text(
                event.title ?? '',
                style: txtBodyLargeBold(),
                textAlign: TextAlign.center,
              ),
              vpad(12),
              Text(
                  '${S.of(context).time_happening}: ${Utils.dateFormat(event.start_time ?? '', 1)} - ${Utils.dateFormat(event.end_time ?? '', 1)}',
                  style: txtRegular(14, grayScaleColorBase)),
              vpad(12),
              Text('${S.of(context).happening_location}:  ${event.location}',
                  style: txtRegular(14, grayScaleColorBase)),
              vpad(12),
              Text(
                  '${S.of(context).end_time_reg}:  ${Utils.dateFormat(event.due_regist ?? '', 1)}',
                  style: txtRegular(14, grayScaleColorBase)),
              if (event.file_upload != null && event.file_upload!.isNotEmpty)
                vpad(12),
              if (event.file_upload != null && event.file_upload!.isNotEmpty)
                PrimaryImageNetwork(
                  canShowPhotoView: false,
                  path:
                      "${ApiConstants.uploadURL}?load=${event.file_upload![0].id}",
                ),
              vpad(12),
              HtmlWidget(
                '''${event.content_event}''',
                onTapUrl: (url) {
                  launchUrl(Uri.parse(url));
                  return false;
                },
                textStyle: txtBodyMediumRegular(),
              ),
              vpad(30),
              if (isShowButtonParticipation &&
                  event.time_status == "COMING" &&
                  !isSend)
                PrimaryButton(
                  buttonSize: ButtonSize.medium,
                  buttonType: ButtonType.green,
                  onTap: () {
                    Utils.showConfirmMessage(
                        context: context,
                        title: S.of(context).confirm_participate_event,
                        content: S.of(context).confirm_par_ques_event(
                            event.title != null
                                ? event.title!.toLowerCase()
                                : ''),
                        onConfirm: () async {
                          Navigator.pop(context);
                          var paticipation = EventParticipation(
                            accountId: context
                                .read<ResidentInfoPrv>()
                                .userInfo!
                                .account!
                                .id,
                            eventId: event.id,
                            event_for: event.event_for,
                            residentId:
                                context.read<ResidentInfoPrv>().residentId,
                          );

                          await APIEvent.participateEvent(paticipation.toJson())
                              .then((v) {
                            onParticipate();
                            Utils.showSuccessMessage(
                                context: context,
                                onClose: () {
                                  setState(() {
                                    isSend = true;
                                  });
                                },
                                e: S.of(context).scuccess_participation(
                                    event.title != null
                                        ? event.title!.toLowerCase()
                                        : ""));
                          }).catchError((e) {
                            Utils.showErrorMessage(context, e);
                          });
                        });
                  },
                  text: S.of(context).participate,
                ),
              vpad(60),
            ],
          ),
        ));
  }
}
