import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../widgets/primary_screen.dart';

class AddGymCardScreen extends StatelessWidget {
  const AddGymCardScreen({super.key});
  static const routeName = '/services/gym/add';

  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: "d",
      ),
    );
  }
}
