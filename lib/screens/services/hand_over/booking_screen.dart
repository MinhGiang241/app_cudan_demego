import 'package:app_cudan/models/hand_over.dart';
import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_dropdown.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../auth/prv/resident_info_prv.dart';
import 'prv/booking_prv.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});
  static const routeName = '/hand-over/booking';

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    bool isBook = arg['book'] ?? true;
    AppointmentSchedule? schedule = arg['schedule'];
    return ChangeNotifierProvider(
      create: (context) => BookingPrv(
        schedule: schedule,
      ),
      builder: (context, builder) {
        return FutureBuilder(
          future: context.read<BookingPrv>().getApartmentListContract(context),
          builder: (context, snapshot) {
            var listApartmentChoice =
                context.read<BookingPrv>().apartmentList.map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text('${e.name} - ${e.f?.name} - ${e.b?.name}'),
              );
            }).toList();
            return PrimaryScreen(
              appBar: PrimaryAppbar(
                title: S.of(context).booking_hand_over,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Form(
                      onChanged: context.watch<BookingPrv>().autoValid
                          ? () => context.read<BookingPrv>().validate(context)
                          : null,
                      autovalidateMode: context.watch<BookingPrv>().autoValid
                          ? AutovalidateMode.onUserInteraction
                          : null,
                      key: context.read<BookingPrv>().formKey,
                      child: Column(
                        children: [
                          vpad(16),
                          PrimaryDropDown(
                            //textStyle: txtBodySmallBold(color: grayScaleColor1),
                            enable: isBook,
                            value: context.watch<BookingPrv>().apartmentValue,
                            onChange:
                                context.read<BookingPrv>().onChangeApartment,
                            isDense: false,
                            label: S.of(context).surface,
                            isRequired: true,
                            selectList: listApartmentChoice,
                            validateString:
                                context.watch<BookingPrv>().validateApartment,
                            validator: Utils.emptyValidatorDropdown,
                          ),
                          vpad(16),
                          PrimaryTextField(
                            textStyle: !isBook
                                ? txtBodySmallBold(color: grayScaleColor2)
                                : null,
                            enable: isBook,
                            validator: Utils.emptyValidator,
                            label: S.of(context).hand_over_date,
                            isRequired: true,
                            isReadOnly: true,
                            hint: "dd/mm/yyyy",
                            onTap: () => context
                                .read<BookingPrv>()
                                .pickHandOverDate(context),
                            suffixIcon:
                                const PrimaryIcon(icons: PrimaryIcons.calendar),
                            controller: context
                                .read<BookingPrv>()
                                .handOverDateController,
                            validateString: context
                                .watch<BookingPrv>()
                                .validateHandOverDate,
                          ),
                          vpad(16),
                          PrimaryTextField(
                            textStyle: !isBook
                                ? txtBodySmallBold(color: grayScaleColor2)
                                : null,
                            enable: isBook,
                            validator: Utils.emptyValidator,
                            label: S.of(context).hand_over_time,
                            isReadOnly: true,
                            isRequired: true,
                            onTap: () => context
                                .read<BookingPrv>()
                                .pickHandOverTime(context),
                            suffixIcon:
                                const PrimaryIcon(icons: PrimaryIcons.clock),
                            hint: "hh/mm",
                            controller: context
                                .read<BookingPrv>()
                                .handOverTimeController,
                            validateString: context
                                .watch<BookingPrv>()
                                .validateHandOverTime,
                          ),
                          // vpad(16),
                          // PrimaryTextField(
                          //   label: S.of(context).note,
                          //   maxLines: 3,
                          //   controller: context.read<BookingPrv>().noteController,
                          // ),
                          if (!isBook) vpad(16),
                          if (!isBook)
                            PrimaryTextField(
                              label: S.of(context).status,
                              enable: false,
                              isReadOnly: true,
                              initialValue: genStatus(schedule?.status ?? ''),
                              textColor: genStatusColor(schedule?.status),
                              textStyle:
                                  txtBold(14, genStatusColor(schedule?.status)),
                              // controller: context.read<BookingPrv>().noteController,
                            ),
                          if (!isBook && schedule?.cancel_reason != null)
                            vpad(16),
                          if (!isBook && schedule?.cancel_reason != null)
                            PrimaryTextField(
                              textStyle: !isBook
                                  ? txtBodySmallBold(color: grayScaleColor2)
                                  : null,
                              label: S.of(context).cancel_reason,
                              enable: false,
                              isReadOnly: true,
                              initialValue: schedule?.r?.name,
                              // textColor: genStatusColor(schedule?.status),
                              // textStyle:
                              //     txtBold(14, genStatusColor(schedule?.status)),
                              // controller: context.read<BookingPrv>().noteController,
                            ),
                          if (!isBook && schedule?.cancel_note != null)
                            vpad(16),
                          if (!isBook && schedule?.cancel_note != null)
                            PrimaryTextField(
                              textStyle: !isBook
                                  ? txtBodySmallBold(color: grayScaleColor2)
                                  : null,
                              label: S.of(context).note_can_reason,
                              enable: false,
                              isReadOnly: true,
                              initialValue: schedule?.cancel_note,
                              // textColor: genStatusColor(schedule?.status),
                              // textStyle:
                              //     txtBold(14, genStatusColor(schedule?.status)),
                              // controller: context.read<BookingPrv>().noteController,
                            ),
                          vpad(30),
                          Row(
                            children: [
                              if (!isBook && schedule?.status != "CANCEL")
                                Expanded(
                                  flex: 10,
                                  child: PrimaryButton(
                                    isFit: true,
                                    isLoading: context
                                        .watch<BookingPrv>()
                                        .isSendLoading,
                                    buttonType: ButtonType.red,
                                    buttonSize: ButtonSize.medium,
                                    text: S.of(context).can_schedule,
                                    onTap: () {
                                      return context
                                          .read<BookingPrv>()
                                          .cancel(context, schedule?.status);
                                    },
                                  ),
                                ),
                              if (!isBook && schedule?.status != "CANCEL")
                                Expanded(
                                  flex: 1,
                                  child: hpad(0),
                                ),
                              if (schedule?.status != "CANCEL")
                                Expanded(
                                  flex: 10,
                                  child: PrimaryButton(
                                    isFit: true,
                                    isLoading: context
                                        .watch<BookingPrv>()
                                        .isSendLoading,
                                    buttonType: isBook
                                        ? ButtonType.green
                                        : ButtonType.yellow,
                                    buttonSize: ButtonSize.medium,
                                    text: isBook
                                        ? S.of(context).send_request
                                        : S.of(context).re_book,
                                    onTap: () {
                                      if (isBook) {
                                        return context
                                            .read<BookingPrv>()
                                            .send(context);
                                      } else {
                                        return context
                                            .read<BookingPrv>()
                                            .reBook(context);
                                      }
                                    },
                                  ),
                                ),
                            ],
                          ),
                          vpad(40)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
