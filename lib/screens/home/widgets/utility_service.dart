import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../widgets/primary_icon.dart';
import '../../services/ultilty/utility_service_screen.dart';
import 'home_title_widget.dart';

class UtilityService extends StatelessWidget {
  const UtilityService({super.key});
  @override
  Widget build(BuildContext context) {
    final data = [
      {
        'icon': PrimaryIcons.dollar,
        'icon-gradient': PrimaryIconGradient.primary,
        'color': demepro3,
        'text': "Dịch vụ tiện ích",
        'shadow-color': demepro2
      },
      {
        'icon': PrimaryIcons.dollar,
        'icon-gradient': PrimaryIconGradient.primary,
        'color': demepro3,
        'text': "Dịch vụ tiện ích",
        'shadow-color': demepro2,
      },
      {
        'icon': PrimaryIcons.dollar,
        'icon-gradient': PrimaryIconGradient.primary,
        'color': demepro3,
        'text': "Dịch vụ tiện ích",
        'shadow-color': demepro2,
      },
      {
        'icon': PrimaryIcons.dollar,
        'icon-gradient': PrimaryIconGradient.primary,
        'color': demepro3,
        'text': "Dịch vụ tiện ích",
        'shadow-color': demepro2,
      },
      {
        'icon': PrimaryIcons.dollar,
        'icon-gradient': PrimaryIconGradient.primary,
        'color': demepro3,
        'text': "Dịch vụ tiện ích",
        'shadow-color': demepro2,
      },
    ];
    return HomeTitleWidget(
      title: 'Tiện ích',
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        shrinkWrap: true,
        childAspectRatio: 1,
        children: [
          ...data.map(
            (e) => SizedBox(
              width: 85,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 1,
                          blurRadius: 24,
                          color: (e['shadow-color'] as Color).withOpacity(0.25),
                          offset: const Offset(0, 16),
                        )
                      ],
                    ),
                    child: PrimaryIcon(
                      icons: e['icon'] as PrimaryIcons,
                      style: PrimaryIconStyle.gradient,
                      gradients: e['icon-gradient'] as PrimaryIconGradient,
                      color: e['color'] as Color,
                      padding: const EdgeInsets.all(12),
                      size: 32,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          UtilityServiceScreen.routeName,
                          arguments: {
                            'year': null,
                            'month': null,
                            'index': null
                          },
                        );
                      },
                    ),
                  ),
                  vpad(12),
                  AutoSizeText(
                    'Dịch vụ',
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.center,
                    style: txtBodySmallBold(color: grayScaleColorBase),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
