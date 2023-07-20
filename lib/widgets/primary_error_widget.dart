import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';

class PrimaryErrorWidget extends StatelessWidget {
  const PrimaryErrorWidget({
    Key? key,
    this.code,
    this.message,
    this.onRetry,
  }) : super(key: key);

  final String? code;
  final String? message;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (code == 'error') Text(S.of(context).err_x(message ?? "")),
          if (code == 'internet_error') Text(S.of(context).err_conn),
          vpad(10),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(
              Icons.replay_outlined,
            ),
            label: Text(S.of(context).retry),
          )
        ],
      ),
    );
  }
}
