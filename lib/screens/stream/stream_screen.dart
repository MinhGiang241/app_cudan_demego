import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'my_bloc.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  MyBloc myBloc = MyBloc();
  @override
  void dispose() {
    myBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myBloc.counterStream.listen((data) {
      print(data);
    });
    return PrimaryScreen(
      appBar: const PrimaryAppbar(title: "Stream example"),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: StreamBuilder(
              stream: myBloc.counterStream,
              builder: ((context, snapshot) {
                return Center(
                  child: Text(
                    snapshot.hasData ? snapshot.data.toString() : '0',
                  ),
                );
              })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myBloc.increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
