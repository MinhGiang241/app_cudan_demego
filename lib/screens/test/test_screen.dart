// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/primary_button.dart';
import '../../widgets/primary_screen.dart';
import '../chat/bloc/chat_message_bloc.dart';

class TestScreen extends StatelessWidget {
  TestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ChatMessageBloc bloc = context.read<ChatMessageBloc>();
    return PrimaryScreen(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Column(
        children: const [
          PrimaryButton(
            text: "stream-room",
          ),
          PrimaryButton(
            text: "add_message",
          ),
          PrimaryButton(
            text: "register message room",
          ),
          PrimaryButton(
            text: "",
          ),
        ],
      ),
    );
  }
}
