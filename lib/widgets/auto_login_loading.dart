import 'package:flutter/material.dart';
import 'primary_loading.dart';

class AutoLoginLoading extends StatelessWidget {
  const AutoLoginLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: PrimaryLoading()),
    );
  }
}
