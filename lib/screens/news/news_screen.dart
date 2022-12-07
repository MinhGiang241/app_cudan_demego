import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/primary_screen.dart';

class NewListScreen extends StatelessWidget {
  const NewListScreen({super.key});
  static const routeName = '/news';

  @override
  Widget build(BuildContext context) {
    return PrimaryScreen();
  }
}
