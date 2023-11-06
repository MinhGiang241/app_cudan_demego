import 'package:app_cudan/screens/chat/bloc/chat_message_bloc.dart';
import 'package:app_cudan/screens/chat/new_chat/bloc/new_chat_bloc.dart';
import 'package:app_cudan/screens/chat/new_chat/widgets/video_player_widget.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:percent_indicator/percent_indicator.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_loading.dart';
import '../../home/home_screen.dart';
import '../bloc/websocket_connect.dart';
import '../custom/custom_websocket_service.dart';
import 'widgets/audio_player_widget.dart';
import 'widgets/new_list_message_subject.dart';

class NewChatScreen extends StatefulWidget {
  NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  late NewChatBloc bloc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //bloc.resetCount();
      //bloc.messageController.();
      if (context.read<NewChatBloc>().state.isInit) {
        context.read<NewChatBloc>().state.webSocketChannel =
            CustomWebSocketService.shared.connectToWebSocketLiveChat(
          WebsocketConnect.webSocketUrl,
        );
      }

      if (context.read<NewChatBloc>().state.isInit) {
        await context.read<NewChatBloc>().createVisitor(context);
      }
    });
  }

  @override
  void dispose() {
    bloc.setIsActiveScren(false);
    // bloc.messageController.add(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<NewChatBloc>();

    return WillPopScope(
      onWillPop: () async {
        // bloc.closeLiveChatRoom(context);
        Navigator.pushReplacementNamed(
          context,
          HomeScreen.routeName,
        );
        return false;
      },
      child:
          // BlocBuilder<NewChatBloc, NewChatState>(
          //   builder: (context, state) =>

          BlocConsumer<NewChatBloc, NewChatState>(
        listener: (context, state) {},
        builder: (context, state) => PrimaryScreen(
          isPadding: false,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 32,
                child: Image.asset(AppImage.receiption),
              ),
            ),
            // centerTitle: false,
            title: Text(
              S.of(context).customer_care,
            ),
            backgroundColor: primaryColor4,
          ),
          body: SafeArea(
            child: Column(
              children: [
                if (state.percent != 0 && state.percent != 100)
                  Row(
                    children: [
                      Flexible(
                        child: LinearPercentIndicator(
                          barRadius: Radius.circular(12),
                          lineHeight: 14.0,
                          percent: state.percent / 100,
                          backgroundColor: grayScaleColor4,
                          progressColor: primaryColorBase,
                        ),
                      ),
                      Text(
                        '${S.of(context).uploading} ${state.percent}%',
                        style: txtBodySmallRegular(),
                      ),
                    ],
                  ),
                Expanded(
                  child: (state.loading)
                      ? Center(child: PrimaryLoading())
                      : Chat(
                          customBottomWidget: state.isInit ? vpad(0) : null,
                          inputOptions: InputOptions(
                            enabled: true,
                          ),
                          l10n: ChatL10nEn(
                            inputPlaceholder: S.of(context).enter_text,
                          ),
                          listBottomWidget: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                if (state.isInit) {
                                  //  bloc.sendStartChat();
                                  bloc.add(
                                    StartChatEvent(),
                                  );
                                  Utils.showDialog(
                                    context: context,
                                    dialog: PrimaryDialog.custom(
                                      content: NewListMessageSubject(
                                        bloc: bloc,
                                      ),
                                    ),
                                  );
                                  //bloc.add(StartChatEvent());
                                  //await context.read<NewChatBloc>().start();
                                } else {
                                  bloc.closeLiveChatRoom(context);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      state.isInit ? Icons.login : Icons.logout,
                                    ),
                                    hpad(10),
                                    Text(
                                      state.isInit
                                          ? S.of(context).start_chat
                                          : S.of(context).end_chat,
                                      overflow: TextOverflow.ellipsis,
                                      style: txtRegular(
                                        14,
                                        grayScaleColorBase,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          theme: DefaultChatTheme(
                            attachmentButtonIcon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            documentIcon: Icon(
                              Icons.folder,
                              color: Colors.white,
                            ),
                            backgroundColor: primaryColor5,
                            primaryColor: Colors.teal,
                            secondaryColor: grayScaleColor4,
                            // systemMessageTheme: ,
                            inputContainerDecoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 1),
                                colors: <Color>[
                                  // primaryColorBase,
                                  // primaryColor3,
                                  // primaryColor4,
                                  // purpleColor
                                  Color(0xff1f005c),
                                  Color(0xff5b0060),
                                  Color(0xff870160),
                                  Color(0xffac255e),
                                  Color(0xffca485c),
                                  Color(0xffe16b5c),
                                  Color(0xfff39060),
                                  Color(0xffffb56b),
                                ], // Gradient from https://learnui.design/tools/gradient-generator.html
                                tileMode: TileMode.mirror,
                              ),
                            ),
                            //inputBackgroundColor: Colors.teal,
                            sendButtonIcon:
                                Icon(Icons.send, color: Colors.white),
                          ),
                          usePreviewData: true,
                          onMessageVisibilityChanged: (me, flase) => {},
                          user: state.user ?? types.User(id: uuid.v4()),
                          messages: state.messages,
                          onSendPressed: bloc.handleSendPressed,
                          onMessageTap: bloc.handleMessageTap,
                          onPreviewDataFetched: bloc.handlePreviewDataFetched,
                          showUserAvatars: true,
                          showUserNames: true,
                          disableImageGallery: false,
                          onAttachmentPressed: () =>
                              bloc.uploadFileLiveChat(context),
                          hideBackgroundOnEmojiMessages: true,
                          audioMessageBuilder: (p0, {messageWidth = 10}) {
                            return AudioPlayerWidget(p0: p0, user: state.user!);
                          },
                          videoMessageBuilder: (p0, {messageWidth = 10}) =>
                              VideoPlayerWidget(p0: p0, user: state.user!),
                          //onPreviewDataFetched: _handlePreviewDataFetched,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
    // );
  }
}
