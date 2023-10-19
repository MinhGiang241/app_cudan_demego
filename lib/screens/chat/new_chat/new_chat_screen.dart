import 'dart:io';

import 'package:app_cudan/screens/chat/bloc/chat_message_bloc.dart';
import 'package:app_cudan/screens/chat/new_chat/bloc/new_chat_bloc.dart';
import 'package:app_cudan/screens/chat/new_chat/widgets/video_player_widget.dart';
import 'package:app_cudan/widgets/primary_dialog.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
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
  var messages = <types.Message>[
    types.VideoMessage(
      uri: '',
      size: 10,
      id: '2',
      name: 's',
      author: types.User(
        lastName: "Giang",
        firstName: "Minh",
        imageUrl:
            'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
        id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
      ),
    ),
    types.AudioMessage(
      duration: Duration(seconds: 333),
      id: '11',
      name: "alo",
      size: 5000,
      uri:
          'https://vnno-zn-5-tf-a320-zmp3.zmdcdn.me/caa6c89c3a6a5a14199db65626917b36?authen=exp=1697857293~acl=/caa6c89c3a6a5a14199db65626917b36/*~hmac=4f04f2f9150008b60fe883204bd1b444',
      author: types.User(
        lastName: "Giang",
        firstName: "Minh",
        imageUrl:
            'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
        id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
      ),
    ),
    ...List.generate(
      10,
      (index) => (types.TextMessage(
        author: types.User(
          lastName: "Giang",
          firstName: "Minh",
          imageUrl:
              'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
          id: index % 2 == 0
              ? '82091008-a484-4a89-ae75-a22bf8d6f3ad'
              : '82091008-a484-4a89-ae75-a22bf8d6f3ac',
        ),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "Đây là message test",
      )),
    ),
  ];
  final _user = const types.User(
    lastName: "Giang",
    firstName: "Minh",
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
    imageUrl:
        'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
  );
  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            messages[index] = updatedMessage;
          });
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      messages[index] = updatedMessage;
    });
  }

  void _handleImageSelection() async {
    var listImageExt = ['png', 'jpg', 'jpeg'];
    Utils.selectImage(context, false, isFile: true).then(
      (value) async {
        if (value != null) {
          if (listImageExt.contains(value[0].name.split('.').last)) {
            final bytes = await value[0].readAsBytes();
            final image = await decodeImageFromList(bytes);

            final message = types.ImageMessage(
              author: _user,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              height: image.height.toDouble(),
              id: uuid.v4(),
              name: value[0].name,
              size: bytes.length,
              uri: value[0].path,
              width: image.width.toDouble(),
            );

            _addMessage(message);
          } else {
            final bytes = await value[0].readAsBytes();

            final message = types.FileMessage(
              author: _user,
              createdAt: DateTime.now().millisecondsSinceEpoch,
              id: uuid.v4(),
              name: value[0].name,
              size: bytes.length,
              uri: value[0].path,
            );
            _addMessage(message);
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<NewChatBloc>().state.webSocketChannel =
          CustomWebSocketService.shared.connectToWebSocketLiveChat(
        WebsocketConnect.webSocketUrl,
      );

      if (context.read<NewChatBloc>().state.isInit) {
        await context.read<NewChatBloc>().createVisitor(context);
        // Utils.showDialog(
        //   context: context,
        //   dialog: PrimaryDialog.custom(
        //     content: NewListMessageSubject(),
        //   ),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final NewChatBloc bloc = context.read<NewChatBloc>();

    return PrimaryScreen(
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
        title: Text(S.of(context).customer_care),
        backgroundColor: primaryColor4,
      ),
      body: SafeArea(
        child: BlocBuilder<NewChatBloc, NewChatState>(
          builder: (context, state) {
            return Chat(
              customBottomWidget: state.isInit ? vpad(0) : null,
              inputOptions: InputOptions(
                enabled: true,
              ),
              l10n: const ChatL10nEn(
                inputPlaceholder: 'Nhập tin nhắn',
              ),
              listBottomWidget: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    if (state.isInit) {
                      bloc.add(StartChatEvent());
                    } else {
                      bloc.add(NewChatInitEvent());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.login),
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
                sendButtonIcon: Icon(Icons.send, color: Colors.white),
              ),
              usePreviewData: true,
              onMessageVisibilityChanged: (me, flase) => {},
              user: state.user ?? _user,
              messages: state.messages,
              onSendPressed: bloc.handleSendPressed,
              onMessageTap: _handleMessageTap,
              onPreviewDataFetched: _handlePreviewDataFetched,
              showUserAvatars: true,
              showUserNames: true,
              disableImageGallery: false,
              onAttachmentPressed: _handleImageSelection,
              hideBackgroundOnEmojiMessages: true,
              audioMessageBuilder: (p0, {messageWidth = 10}) {
                return AudioPlayerWidget(p0: p0, user: _user);
              },
              videoMessageBuilder: (p0, {messageWidth = 10}) =>
                  VideoPlayerWidget(p0: p0, user: _user),
              //onPreviewDataFetched: _handlePreviewDataFetched,
            );
          },
        ),
      ),
    );
    // );
  }
}
