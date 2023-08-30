import 'package:app_cudan/screens/services/ultilty/prv/add_new_letter_ultility_prv.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../widgets/primary_icon.dart';

class BookingTimePage extends StatelessWidget {
  const BookingTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    var list = context.watch<AddNewLetterUltilityPrv>().timeList;
    var value = context.watch<AddNewLetterUltilityPrv>().currentTimeValue;
    return ListView(
      shrinkWrap: true,
      children: [
        vpad(20),
        PrimaryTextField(
          isRequired: true,
          suffixIcon: const PrimaryIcon(
            icons: PrimaryIcons.calendar,
          ),
          isReadOnly: true,
          controller: context.read<AddNewLetterUltilityPrv>().dateController,
          label: "Chọn ngày",
          onTap: () =>
              context.read<AddNewLetterUltilityPrv>().pickDate(context),
        ),
        vpad(12),
        ...list.asMap().entries.map(
              (e) => Row(
                children: [
                  Radio(
                    fillColor: MaterialStateColor.resolveWith((states) {
                      if ((e.value['full'] as bool)) {
                        return grayScaleColor4;
                      }
                      return primaryColorBase;
                    }),
                    toggleable: !(e.value['full'] as bool),
                    value: e.value['time'],
                    groupValue: value,
                    onChanged: (v) {
                      if (!(e.value['full'] as bool)) {
                        context
                            .read<AddNewLetterUltilityPrv>()
                            .bookingTime(v, e.key);
                      }
                      ;
                    },
                  ),
                  hpad(10),
                  InkWell(
                    onTap: () {
                      if (!(e.value['full'] as bool)) {
                        context
                            .read<AddNewLetterUltilityPrv>()
                            .bookingTime(e.value['time'], e.key);
                      }
                    },
                    child: Text(
                      e.value['time'] as String,
                      style: txtRegular(
                        14,
                        (e.value['full'] as bool) ? grayScaleColor4 : null,
                      ),
                    ),
                  ),
                  if ((e.value['full'] as bool)) hpad(10),
                  if ((e.value['full'] as bool))
                    Text(
                      "Hết chỗ",
                      style: txtRegular(14, redColorBase),
                    ),
                ],
              ),
            ),
        vpad(20),
        Text("Nhập số lượng cư dân"),
        vpad(12),
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Spacer(),
              ClipOval(
                child: Material(
                  color: primaryColorBase, // Button color
                  child: InkWell(
                    // Splash color
                    onTap:
                        context.read<AddNewLetterUltilityPrv>().subtractResNum,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  context.watch<AddNewLetterUltilityPrv>().resNum.toString(),
                ),
              ),
              ClipOval(
                child: Material(
                  color: primaryColorBase, // Button color
                  child: InkWell(
                    // Splash color
                    onTap: context.read<AddNewLetterUltilityPrv>().addResNum,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        vpad(40),
        PrimaryButton(
          text: 'Tiếp tục',
          onTap: () =>
              context.read<AddNewLetterUltilityPrv>().onNextStep1(context),
        ),
        vpad(20),
      ],
    );
  }
}
