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
    var listApartmentChoice = context.read<ResidentInfoPrv>().listOwn.map((e) {
      return DropdownMenuItem(
        value: e.apartmentId,
        child: Text(
          e.apartment?.name! != null
              ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
              : e.apartmentId!,
        ),
      );
    }).toList();
    return ChangeNotifierProvider(
      create: (context) => BookingPrv(),
      builder: (context, builder) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: S.of(context).booking_hand_over,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    vpad(16),
                    PrimaryDropDown(
                      isDense: false,
                      label: S.of(context).surface,
                      isRequired: true,
                      selectList: listApartmentChoice,
                    ),
                    vpad(16),
                    PrimaryTextField(
                      validator: Utils.emptyValidator,
                      label: S.of(context).hand_over_date,
                      isRequired: true,
                      isReadOnly: true,
                      hint: "dd/mm/yyyy",
                      onTap: () =>
                          context.read<BookingPrv>().pickHandOverDate(context),
                      suffixIcon:
                          const PrimaryIcon(icons: PrimaryIcons.calendar),
                      controller:
                          context.read<BookingPrv>().handOverDateController,
                      validateString:
                          context.watch<BookingPrv>().validateHandOverDate,
                    ),
                    vpad(16),
                    PrimaryTextField(
                      validator: Utils.emptyValidator,
                      label: S.of(context).hand_over_time,
                      isReadOnly: true,
                      isRequired: true,
                      onTap: () =>
                          context.read<BookingPrv>().pickHandOverTime(context),
                      suffixIcon: const PrimaryIcon(icons: PrimaryIcons.clock),
                      hint: "hh/mm",
                      controller:
                          context.read<BookingPrv>().handOverTimeController,
                      validateString:
                          context.watch<BookingPrv>().validateHandOverTime,
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
                        initialValue: "Đã duyệt",
                        textColor: greenColorBase,
                        // controller: context.read<BookingPrv>().noteController,
                      ),
                    vpad(30),
                    PrimaryButton(
                      width: dvWidth(context) - 48,
                      isFit: true,
                      isLoading: context.watch<BookingPrv>().isSendLoading,
                      buttonType: isBook ? ButtonType.green : ButtonType.yellow,
                      buttonSize: ButtonSize.medium,
                      text: isBook
                          ? S.of(context).send_request
                          : S.of(context).re_book,
                      onTap: () {},
                    ),
                    vpad(40)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
