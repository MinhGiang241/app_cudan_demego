import 'package:app_cudan/models/booking_service.dart';
import 'package:app_cudan/screens/booking_services/prv/judge_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:app_cudan/widgets/select_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/area.dart';
import '../../models/info_content_view.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_text_field.dart';
import '../auth/prv/resident_info_prv.dart';
import '../payment/widget/payment_item.dart';

class JudgeScreen extends StatefulWidget {
  const JudgeScreen({super.key});
  static const routeName = '/booking-jugdge';

  @override
  State<JudgeScreen> createState() => _JudgeScreenState();
}

class _JudgeScreenState extends State<JudgeScreen> {
  String genScoreString(double score) {
    switch (score.toInt()) {
      case 1:
        return S.current.s1;
      case 2:
        return S.current.s2;
      case 3:
        return S.current.s3;
      case 4:
        return S.current.s4;
      case 5:
        return S.current.s5;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    var service = arg?['service'] as BookingService;
    var reg = arg?['reg'] as RegisterBookingService;
    var area = arg?['area'] as Area;
    var numReg = arg?['numRes'];
    var numGuest = arg?['numGuest'];
    var time_start = arg?['time_start'];
    var time_end = arg?['time_end'];
    var mode = arg?['mode'];
    var sh = arg?['sh'];
    var dateString = arg?['dateString'];
    var isResident = context.read<ResidentInfoPrv>().selectedApartment != null;
    var isEdit = arg?['isEdit'] as bool;

    List<InfoContentView> listInfo = [
      InfoContentView(
        title: S.of(context).util_type,
        content: service.name ?? '',
      ),
      InfoContentView(
        title: S.of(context).zone,
        content: area.name ?? '',
      ),
      if (numReg != null &&
          service.service_charge == "nocharge" &&
          reg.registration_type == "turn")
        InfoContentView(
          title: S.of(context).resident_ticket_amount,
          content: '${numReg}',
        ),
      if (numGuest != null &&
          service.service_charge == "nocharge" &&
          reg.registration_type == "turn")
        InfoContentView(
          title: S.of(context).guest_ticket_amount,
          content: '${numGuest}',
        ),
      if (reg.registration_type == 'turn')
        InfoContentView(
          title: S.of(context).booking_time,
          content:
              '${Utils.dateFormat(reg.use_date ?? dateString, 1)} ${reg.time_slot ?? "${time_start} - ${time_end}"}',
        ),
      if (reg.registration_type == 'month')
        InfoContentView(
          title: S.of(context).expired_reg,
          content: mode == 0
              ? "${sh?.shelfLife?.use_time} ${genShelifeString(sh?.shelfLife?.type_time)}"
              : "${reg.sh?.use_time} ${genShelifeString(reg.sh?.type_time)}",
        ),
      if (reg.registration_type == 'month')
        InfoContentView(
          title: S.of(context).time_slot,
          content: '${reg.time_slot ?? "${time_start} - ${time_end}"}',
        ),
      if (reg.registration_type == 'month')
        InfoContentView(
          title: S.of(context).begin_use_date,
          content: Utils.dateFormat(reg.use_date ?? '', 1),
        ),
      if (reg.registration_type == 'month')
        InfoContentView(
          title: S.of(context).end_use_date,
          content: Utils.dateFormat(reg.end_date ?? '', 1),
        ),
      if (reg.registration_type == 'month')
        InfoContentView(
          title: S.of(context).reg_fee,
          content: mode == 0
              ? service.service_charge == 'nocharge'
                  ? formatCurrency.format(0)
                  : formatCurrency.format(
                      isResident
                          ? (sh?.price_resident ?? 0)
                          : (sh?.price_guest ?? 0),
                    )
              : formatCurrency.format(reg.total_price ?? 0),
        ),
    ];
    return ChangeNotifierProvider(
      create: (_) => JudgePrv(reg: reg, isEdit: isEdit),
      builder: (context, builder) {
        var score = context.watch<JudgePrv>().score;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).judge_service,
          ),
          body: ListView(
            children: [
              vpad(16),
              Text(
                S.of(context).util_info,
                style: txtBold(14),
              ),
              vpad(10),
              ...listInfo.map(
                (v) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          v.title,
                          style: txtSemiBold(12, grayScaleColor3),
                        ),
                      ),
                      hpad(10),
                      Expanded(
                        flex: 1,
                        child: Text(v.content ?? '', style: txtRegular(12)),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Text(
                S.of(context).quality_service,
                style: txtBold(14),
              ),
              vpad(10),
              Align(
                alignment: Alignment.center,
                child: RatingBar.builder(
                  ignoreGestures: !isEdit,
                  initialRating: score,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    if (isEdit) {
                      context.read<JudgePrv>().setScore(rating);
                    }
                  },
                ),
              ),
              vpad(6),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    genScoreString(score),
                    style: txtRegular(14, Colors.amber),
                  ),
                ),
              ),
              vpad(12),
              PrimaryTextField(
                enable: isEdit,
                label: S.of(context).comment_service,
                hint: S.of(context).comment_service,
                maxLines: 4,
                controller: context.read<JudgePrv>().commentController,
              ),
              vpad(20),
              SelectMediaWidget(
                enable: isEdit,
                images: context.watch<JudgePrv>().images,
                existImages: context.watch<JudgePrv>().existedImages,
                onSelect: () => context.read<JudgePrv>().onSelectImage(context),
                onRemove: context.read<JudgePrv>().onRemoveImage,
              ),
              vpad(30),
              if (isEdit)
                PrimaryButton(
                  onTap: () {
                    context.read<JudgePrv>().onSend(context);
                  },
                  isLoading: context.watch<JudgePrv>().loading,
                  text: S.of(context).send,
                  buttonType: ButtonType.orange,
                  buttonSize: ButtonSize.small,
                  borderRadius: BorderRadius.circular(20),
                ),
              vpad(40),
            ],
          ),
        );
      },
    );
  }
}
