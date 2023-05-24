// ignore_for_file: must_be_immutable

import 'package:app_cudan/constants/constants.dart';
import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../generated/l10n.dart';
import '../../../models/chat_subject.dart';
import '../../../services/api_chat.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_card.dart';
import '../bloc/chat_message_bloc.dart';

class ListMessageSubject extends StatefulWidget {
  ListMessageSubject(
      {super.key, required this.bloc, required this.toogleGreeting});
  ChatMessageBloc bloc;
  Function() toogleGreeting;

  @override
  State<ListMessageSubject> createState() => _ListMessageSubjectState();
}

class _ListMessageSubjectState extends State<ListMessageSubject> {
  final PageController controller = PageController();
  final List<ChatSubject> listMessageSubject = [];
  int pageIndex = 0;
  _onPageViewChange(index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        await APIChat.getChatSubject().then((v) {
          listMessageSubject.clear();
          for (var i in v) {
            listMessageSubject.add(ChatSubject.fromJson(i));
          }
        }).catchError((e) {
          Utils.showErrorMessage(context, e);
        });
      }(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return vpad(0);
        }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const PrimaryLoading();
        // }
        var pageNum = (listMessageSubject.length / 5).ceil();
        return PrimaryCard(
          borderRadius: BorderRadius.circular(24),
          background: grayScaleColor4,
          constraints:
              BoxConstraints(minWidth: 40, maxWidth: dvWidth(context) * 0.7),
          margin: const EdgeInsets.only(top: 12, bottom: 12),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 64,
                child: Center(
                  child: Text(
                    S.of(context).choose_subject,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                    style: txtRegular(14, grayScaleColorBase),
                  ),
                ),
              ),
              const Divider(color: grayScaleColor3, thickness: 1),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 0,
                  maxHeight: 320,
                ),
                child: PageView.builder(
                  itemCount: pageNum,
                  controller: controller,
                  onPageChanged: _onPageViewChange,
                  itemBuilder: (context, index) {
                    var sublist = listMessageSubject.sublist(
                      pageIndex * 5,
                      pageIndex == pageNum - 1
                          ? listMessageSubject.length
                          : pageIndex * 5 + 5,
                    );
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: sublist.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            var accountId = context
                                .read<ResidentInfoPrv>()
                                .userInfo!
                                .account
                                ?.id;
                            widget.bloc.sendGreetingMessage(
                              accountId!,
                              accountId,
                              sublist[index].name!,
                            );
                            widget.bloc.clearMessage(sublist[index].id ?? "");
                            // widget.toogleGreeting();
                            // Future.delayed(const Duration(milliseconds: 10))
                            //     .then((_) {
                            //   widget.bloc.sendGreetingMessage(
                            //     accountId!,
                            //     accountId,
                            //     sublist[index].name!,
                            //   );
                            // });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: (index == sublist.length - 1 &&
                                        sublist.length != 1)
                                    ? BorderSide.none
                                    : const BorderSide(
                                        color: grayScaleColor3,
                                        width: 1,
                                      ),
                              ),
                            ),
                            height: 64,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                sublist[index].name ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                softWrap: true,
                                style: txtRegular(14, grayScaleColorBase),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              vpad(10),
              AnimatedSmoothIndicator(
                onDotClicked: (index) {
                  controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                },
                activeIndex: pageIndex,
                count: pageNum,
                effect: const WormEffect(),
              ),
              vpad(10),
            ],
          ),
        );
      },
    );
  }
}
