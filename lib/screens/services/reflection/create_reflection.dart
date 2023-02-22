import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import 'prv/create_reflection_prv.dart';

class CreateReflection extends StatelessWidget {
  const CreateReflection({super.key});
  static const routeName = '/reflection/add';
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).add_reflection,
      ),
      body: ChangeNotifierProvider(
        create: (context) => CreateReflectionPrv(),
        builder: (context, child) {
          return FutureBuilder(
              future: context
                  .read<CreateReflectionPrv>()
                  .getReflectionReason(context),
              builder: (context, state) {
                return SafeArea(
                    child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: [
                    vpad(12),
                  ],
                ));
              });
        },
      ),
    );
  }
}
