import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/primary_screen.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // WebSocketChannel? webSocketChannel = WebSocketChannel();
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: AppBar(),
      body: StreamBuilder(
        // stream: state.webSocketChannel!.stream,
        builder: (context, snapshot) {
          return vpad(0);
        },
      ),
    );
  }
}
