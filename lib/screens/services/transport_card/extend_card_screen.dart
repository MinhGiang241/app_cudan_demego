import 'package:app_cudan/models/list_transport.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/manage_card.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_screen.dart';
import 'manage_card_details_screen.dart';
import 'prv/extend_transport_prv.dart';

class ExtendCardScreen extends StatefulWidget {
  const ExtendCardScreen({super.key});
  static const routeName = '/transport/extend';
  @override
  State<ExtendCardScreen> createState() => _ExtendCardScreenState();
}

class _ExtendCardScreenState extends State<ExtendCardScreen> {
  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var card = arg['card'] as ManageCard;
    var index = arg['index'] as int;
    var cancel = arg['cancel'] as Function;
    var item = arg['item'] as ListTransport;
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).extend,
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              ManageCardDetailsScreen.routeName,
              arguments: {
                "card": card,
                "cancel": cancel,
              },
            );
          },
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ExtendTransportPrv(
          card: card,
          index: index,
          item: item,
          cancel: cancel,
        ),
        builder: (context, snapshot) {
          return FutureBuilder(
            future: context.read<ExtendTransportPrv>().getShelfLife(context),
            builder: (context, snapshot) {
              var shelfLifeList =
                  context.read<ExtendTransportPrv>().shelfLifeList.map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text('${e.use_time ?? ""} ${e.type_time ?? ""}'),
                );
              }).toList();
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Form(
                      onChanged: context.watch<ExtendTransportPrv>().autoValid
                          ? context.read<ExtendTransportPrv>().formValidation
                          : null,
                      autovalidateMode:
                          context.watch<ExtendTransportPrv>().autoValid
                              ? AutovalidateMode.onUserInteraction
                              : null,
                      key: context.read<ExtendTransportPrv>().formKey,
                      child: Column(
                        children: [
                          vpad(20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).trans_info,
                              style:
                                  txtBodySmallBold(color: grayScaleColorBase),
                            ),
                          ),
                          vpad(12),
                          PrimaryDropDown(
                            onChange:
                                context.read<ExtendTransportPrv>().onChange,
                            validator: Utils.emptyValidatorDropdown,
                            value:
                                context.watch<ExtendTransportPrv>().expireValue,
                            selectList: shelfLifeList,
                            validateString: context
                                .watch<ExtendTransportPrv>()
                                .expireValiate,
                            isRequired: true,
                            label: S.of(context).used_expired_date,
                          ),
                          vpad(12),
                          PrimaryTextField(
                            controller: context
                                .read<ExtendTransportPrv>()
                                .oldExpireController,
                            isRequired: true,
                            label: S.of(context).expired_date_old,
                            enable: false,
                          ),
                          vpad(12),
                          PrimaryTextField(
                            controller: context
                                .read<ExtendTransportPrv>()
                                .newExpireController,
                            isRequired: true,
                            label: S.of(context).expired_date_new,
                            enable: false,
                            textColor: Colors.black,
                          ),
                          vpad(12),
                          PrimaryTextField(
                            controller: context
                                .read<ExtendTransportPrv>()
                                .extendController,
                            isRequired: true,
                            label: S.of(context).expired_date_create,
                            enable: false,
                          ),
                          vpad(30),
                          PrimaryButton(
                            width: double.infinity,
                            text: S.of(context).confirm,
                            isLoading:
                                context.watch<ExtendTransportPrv>().isLoading,
                            onTap: () => context
                                .read<ExtendTransportPrv>()
                                .onSubmit(context),
                          ),
                          vpad(40),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
