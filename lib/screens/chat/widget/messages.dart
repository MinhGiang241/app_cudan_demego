import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../bloc/chat_bloc.dart';

class Measages extends StatefulWidget {
  const Measages({super.key, required this.messageBloc});
  final ChatBloc messageBloc;
  @override
  State<Measages> createState() => _MeasagesState();
}

class _MeasagesState extends State<Measages> {
  // @override
  // void initState() {
  //   super.initState();
  //   itemScrollController.scrollTo(
  //       index: ,
  //       duration: Duration(seconds: 2),
  //       curve: Curves.easeInOutCubic);
  // }

  @override
  Widget build(BuildContext context) {
// ScrollablePositionedList.builder(
//   itemCount: 500,
//   itemBuilder: (context, index) => Text('Item $index'),
//   itemScrollController: itemScrollController,
//   itemPositionsListener: itemPositionsListener,
// );

    return SafeArea(
      child: StreamBuilder(
          stream: widget.messageBloc.messageStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // itemScrollController.scrollTo(
            //     index: snapshot.data!.docs.length - 1,
            //     duration: Duration(seconds: 2),
            //     curve: Curves.easeInOutCubic);

            return ScrollablePositionedList.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // widget.messageBloc.scroll(snapshot.data!.docs.length - 1);
                QueryDocumentSnapshot qs = snapshot.data!.docs[index];
                Timestamp t = qs['time'];
                DateTime d = t.toDate();
                return InkWell(
                  onTap: () {
                    widget.messageBloc.scroll(snapshot.data!.docs.length - 1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(qs['message']),
                  ),
                );
              },
              itemScrollController: widget.messageBloc.itemScrollController,
              itemPositionsListener: widget.messageBloc.itemPositionsListener,
            );

            // SingleChildScrollView(
            //   controller: _controller,
            //   child: Column(children: [
            //     ...snapshot.data!.docs.asMap().entries.map((e) {
            //       Timestamp t = e.value['time'];
            //       DateTime d = t.toDate();
            //       return SizedBox(
            //         key: e.key == listQs.length - 1 ? dataKey : null,
            //         child: Text(e.value['message']),
            //       );
            //     })
            //   ]),
            // );

            // ListView.builder(
            //     controller: _controller,
            //     itemCount: snapshot.data!.docs.length,
            //     physics: const ScrollPhysics(),
            //     shrinkWrap: true,
            //     primary: false,
            //     itemBuilder: (_, index) {
            //       QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            //       Timestamp t = qs['time'];
            //       DateTime d = t.toDate();
            //       print(d.toString());
            //       return Padding(
            //         padding: const EdgeInsets.all(40.0),
            //         child: Text(
            //           qs['message'],
            //         ),
            //       );
            //     });
          }),
    );
  }
}
