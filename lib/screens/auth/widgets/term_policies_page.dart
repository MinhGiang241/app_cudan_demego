import 'package:app_cudan/constants/policies.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import 'term_policies.dart';

class TermPoliciesPage extends StatelessWidget {
  const TermPoliciesPage({super.key});
  static const routeName = '/policies';

  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).policies,
      ),
      body: ListView(
        children: [
          vpad(10),
          ...policies
              .where((element) => element['type'] != PType.title)
              .map((v) => textformat(v)),
          vpad(40),
        ],
      ),
    );
  }
}
