import 'package:app_cudan/screens/services/transport_card/prv/add_new_transport_card_prv.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_blocked_scroll_physics/horizontal_blocked_scroll_physics.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/dash_button.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';

class AddNewTransportCardScreen extends StatefulWidget {
  const AddNewTransportCardScreen({super.key});
  static const routeName = '/add_transportcard';

  @override
  State<AddNewTransportCardScreen> createState() =>
      _AddNewTransportCardScreenState();
}

class _AddNewTransportCardScreenState extends State<AddNewTransportCardScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddNewTransportCardPrv(),
      builder: (context, snapshot) => PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).reg_transport_card,
        ),
        body: SafeArea(
          child: PageView(
            controller: context.read<AddNewTransportCardPrv>().pageController,
            onPageChanged: context.read<AddNewTransportCardPrv>().onPageChanged,
            physics: context.watch<AddNewTransportCardPrv>().isDisableRightCroll
                ? const LeftBlockedScrollPhysics()
                : null,
            children: [
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        vpad(12),
                        Row(
                          children: [
                            DashButton(
                              text: S.of(context).add_transport,
                              lable: S.of(context).transport_list,
                              isRequired: true,
                              icon: const PrimaryIcon(
                                icons: PrimaryIcons.add_to_queue,
                              ),
                              onTap: () {
                                return context
                                    .read<AddNewTransportCardPrv>()
                                    .addTransport();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      vpad(12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
