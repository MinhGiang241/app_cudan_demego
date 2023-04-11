// ignore_for_file: implementation_imports

import 'package:app_cudan/screens/reg_resident/add_new_resident_screen.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_screen.dart';
import 'add_new_transport_card.dart';
import 'prv/transport_card_prv.dart';

class TransportCardScreen extends StatelessWidget {
  const TransportCardScreen({super.key});
  static const routeName = '/transport_card';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransportCardPrv(),
      child: PrimaryScreen(
        appBar: PrimaryAppbar(title: S.of(context).transport_card),
        floatingActionButton: FloatingActionButton(
          tooltip: S.of(context).add_trans_card,
          onPressed: () {
            Navigator.pushNamed(
              context,
              AddNewTransportCardScreen.routeName,
              arguments: {"isEdit": false},
            );
          },
          backgroundColor: primaryColorBase,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
