import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import 'prv/add_new_resident_prv.dart';

class AddNewResidentScreen extends StatelessWidget {
  const AddNewResidentScreen({super.key});
  static const routeName = '/reg_resident/add';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddNewResidentPrv(),
      builder: (context, child) {
        var activeStep = context.watch<AddNewResidentPrv>().activeStep;
        return PrimaryScreen(
            isPadding: false,
            appBar: PrimaryAppbar(
              title: S.of(context).add_dependent_person,
            ),
            body: SafeArea(
              child: FutureBuilder(
                future: () {}(),
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.white,
                            width: dvWidth(context) / 2,
                            height: 50,
                            child: Center(
                              child: Text(
                                S.of(context).step1,
                                style: txtBold(
                                    14,
                                    activeStep == 0
                                        ? grayScaleColorBase
                                        : activeStep > 0
                                            ? greenColorBase
                                            : grayScaleColor4),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            width: dvWidth(context) / 2,
                            height: 50,
                            child: Center(
                              child: Text(
                                S.of(context).step3,
                                style: txtBold(
                                  14,
                                  activeStep == 1
                                      ? grayScaleColorBase
                                      : activeStep > 2
                                          ? greenColorBase
                                          : grayScaleColor4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  );
                },
              ),
            ));
      },
    );
  }
}
