import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/api_service.dart';
import '../../../../utils/utils.dart';
import '../../../auth/prv/resident_info_prv.dart';
import '../../bloc/chat_message_bloc.dart';
import '../../bloc/websocket_connect.dart';
import '../../custom/custom_websocket_service.dart';
import '../services/new_chat_services.dart';

part 'new_chat_event.dart';
part 'new_chat_state.dart';

class NewChatBloc extends Bloc<NewChatEvent, NewChatState> {
  NewChatBloc()
      : super(
          NewChatState(
            isInit: true,
            messages: [
              types.TextMessage(
                author: types.User(
                  lastName: S.current.auto_message,
                  imageUrl: AppImage.avatarUrl,
                  id: '1111',
                ),
                createdAt: DateTime.now().millisecondsSinceEpoch,
                id: const Uuid().v4(),
                text: S.current.chat_greeting,
              ),
            ],
          ),
        ) {
    on<StartChatEvent>((event, emit) {
      emit(
        state.copyWith(
          isInit: false,
          messages: [],
        ),
      );
      start(message: event.startMessage);
    });
    on<NewChatInitEvent>((event, emit) {
      emit(state.copyWith(isInit: true));
    });
    on<NewMessageEvent>((event, emit) {
      emit(state.copyWith(messages: state.messages));
    });
    on<BackNewChatInitEvent>((event, emit) {
      state.employee = null;
      emit(
        state.copyWith(
          messages: state.messages,
          isInit: true,
        ),
      );
      NewChatServices.shared
          .closeLiveChatRoom(state.roomId, state.visitorToken ?? '');
    });
  }
  var _dio = Dio();
  StreamController messageController = StreamController();

  createVisitor(BuildContext context) async {
    var residentProvider = context.read<ResidentInfoPrv>();
    var email = residentProvider.userInfo?.account?.email;
    // var token = residentProvider.userInfo?.account?.id;
    var phone = residentProvider.userInfo?.account?.phone ??
        residentProvider.userInfo?.account?.userName;
    var name = residentProvider.userInfo?.info_name ??
        residentProvider.userInfo?.account?.fullName ??
        residentProvider.userInfo?.account?.userName;
    var residentId = residentProvider.residentId;
    await _dio.post(
      '${WebsocketConnect.serverUrl}/api/v1/livechat/visitor',
      data: {
        "visitor": {
          // "username": name,
          // "_id": token,
          "name": name ?? phone,
          "email": email ?? "rocketchat@gmail.com",
          "token": uuid.v4(),
          "department": ApiService.shared.regCode,
          "phone": phone,
          "customFields": [
            {
              "key": "residentCode",
              "value": residentId ?? "",
              "overwrite": true,
            },
            {
              "key": "phone",
              "value": phone ?? "",
              "overwrite": true,
            },
          ],
        },
      },
    ).then((v) {
      print(v);
      state.visitorToken = v.data?['visitor']?['token'];
      state.user = types.User(
        id: v.data?['visitor']?['_id'],
        lastName: v.data?['visitor']?['name'],
        metadata: {
          'phone': v.data?['visitor']?['phone'],
          'residentId': v.data?['visitor']?['livechatData']?['residentCode'],
          'email': v.data?['visitor']?['visitorEmails'],
          'status': v.data?['visitor']?['status'],
        },
      );
    }).catchError((e) {
      Utils.showErrorMessage(context, e.toString());
    });
  }

  start({types.PartialText? message}) async {
    await openRoomLiveChat();
    sendStartChat();
    if (message != null) {
      handleSendPressed(message);
    }
    streamLiveChat();
    keepConnectChannel();
  }

  keepConnectChannel() {
    state.webSocketChannel?.stream.listen((message) {
      print(message);
      var data = json.decode(message);
      if (data['msg'] == 'ping') {
        NewChatServices.shared.sendPong(state.webSocketChannel!);
      }
      if (data['msg'] == 'changed') {
        addMessageToScreen(data);
      }
    });
  }

  openRoomLiveChat() async {
    await NewChatServices.shared
        .openNewRoomLiveChat(
      state.webSocketChannel!,
      state.visitorToken ?? "",
      null,
    )
        .then((v) {
      state.roomId = v['room']?['_id'];
    });
  }

  sendStartChat() async {
    NewChatServices.shared.sendMessageLiveChat(
      state.webSocketChannel!,
      state.roomId,
      state.visitorToken ?? '',
      "Bắt đầu",
    );
  }

  streamLiveChat() {
    NewChatServices.shared.streamLiveChatRoom(
      state.webSocketChannel!,
      state.visitorToken ?? "",
      state.roomId ?? "",
    );
  }

  void handleSendPressed(types.PartialText message) {
    NewChatServices.shared.sendMessageLiveChat(
      state.webSocketChannel!,
      state.roomId,
      state.visitorToken ?? '',
      message.text,
    );
  }

  addMessageToScreen(data) {
    log(jsonEncode(data));
    types.User user = types.User(
      id: data["fields"]?['args']?[0]?['u']?['_id'],
      lastName: data["fields"]?['args']?[0]?['u']?['_id'] != state.user?.id
          ? "BQLNCC - ${ApiService.shared.projectName}"
          : data["fields"]?['args']?[0]?['u']?['name'],
    );
    if (state.employee == null && state.user?.id != user.id) {
      state.employee = user;
    }
    if (state.employee != null && state.employee?.lastName == null) {
      state.employee = user;
    }

    if (user.id != state.user && !state.isActiveScreen) {
      state.count += 1;
      messageController.add(state.count);
    }

    if (data["fields"]?['args']?[0]?['attachments'] != null &&
        data["fields"]?['args']?[0]?['attachments'].isNotEmpty) {
      var attachment = data["fields"]?['args']?[0]?['attachments']?[0];
      // Check điều kiện file tải lên là hình ảnh
      if (data["fields"]?['args']?[0]?['file']?['type'] != null &&
          data["fields"]?['args']?[0]?['file']?['type'].contains('image')) {
        types.Message message = types.ImageMessage(
          id: data["fields"]?['args']?[0]?['_id'],
          name: attachment?['title'],
          size: attachment?['image_size'],
          author: user,
          uri: '${WebsocketConnect.serverUrl}${attachment?['image_url']}',
          createdAt: data["fields"]?['args']?[0]?['ts']?['\$date'] ??
              DateTime.now().microsecondsSinceEpoch,
          roomId: state.roomId,
          height: attachment?["image_dimensions"]?['height'].toDouble(),
          width: attachment?["image_dimensions"]?['width'].toDouble(),
          type: types.MessageType.image,
        );
        state.messages.insert(0, message);
      } else if (data["fields"]?['args']?[0]?['file']?['type'] != null &&
          data["fields"]?['args']?[0]?['file']?['type'].contains('audio')) {
        types.Message message = types.AudioMessage(
          duration: Duration.zero,
          id: data["fields"]?['args']?[0]?['_id'],
          author: user,
          name: attachment?['title'],
          size: attachment?['audio_size'],
          uri: '${WebsocketConnect.serverUrl}${attachment?['title_link']}',
          createdAt: data["fields"]?['args']?[0]?['ts']?['\$date'] ??
              DateTime.now().microsecondsSinceEpoch,
          type: types.MessageType.audio,
        );
        state.messages.insert(0, message);
      } else if (data["fields"]?['args']?[0]?['file']?['type'] != null &&
          data["fields"]?['args']?[0]?['file']?['type'].contains('video')) {
        types.Message message = types.VideoMessage(
          id: data["fields"]?['args']?[0]?['_id'],
          author: user,
          name: attachment?['title'],
          size: attachment?['video_size'],
          uri: '${WebsocketConnect.serverUrl}${attachment?['title_link']}',
          createdAt: data["fields"]?['args']?[0]?['ts']?['\$date'] ??
              DateTime.now().microsecondsSinceEpoch,
          type: types.MessageType.video,
        );
        state.messages.insert(0, message);
      } else {
        types.Message message = types.FileMessage(
          id: data["fields"]?['args']?[0]?['_id'],
          name: attachment?['title'],
          author: user,
          size: 0,
          uri: '${WebsocketConnect.serverUrl}${attachment?['title_link']}',
          roomId: state.roomId,
          type: types.MessageType.file,
          showStatus: true,
          createdAt: data["fields"]?['args']?[0]?['ts']?['\$date'] ??
              DateTime.now().microsecondsSinceEpoch,
        );
        state.messages.insert(0, message);
      }
    } else {
      types.Message message = types.TextMessage(
        author: user,
        createdAt: data["fields"]?['args']?[0]?['ts']?['\$date'] ??
            DateTime.now().microsecondsSinceEpoch,
        id: data["fields"]?['args']?[0]?['_id'],
        text: data?['fields']?['args']?[0]?['msg'] == "promptTranscript"
            ? S.current.close_chat
            : EmojiParser().emojify(data["fields"]?['args']?[0]?['msg']),
      );
      if (!(state.messages.isNotEmpty && message.id == state.messages[0].id)) {
        state.messages.insert(0, message);
      }
    }
    if (user.id != state.user?.id &&
        data?['fields']?['args']?[0]?['msg'] == "promptTranscript") {
      emit(state.copyWith(isInit: true));
    }
    SystemSound.play(SystemSoundType.alert);
  }

  closeLiveChatRoom(BuildContext context) {
    Utils.showConfirmMessage(
      context: context,
      title: S.of(context).end,
      content: S.of(context).confirm_end_chat,
      onConfirm: () {
        Navigator.pop(context);
        context.read<NewChatBloc>().add(BackNewChatInitEvent());
      },
    );
  }

  uploadFileLiveChat(BuildContext context) {
    Utils.selectImage(context, false, isFile: true).then((v) {
      if (v != null && v.isNotEmpty) {
        NewChatServices.shared.sendUploadFileOnLiveChat(
          state.webSocketChannel!,
          state.roomId ?? "",
          File(v[0].path),
          v[0].name,
          state.visitorToken,
          onSendProgress: (uploaded, total) {
            state..percent = uploaded * 100 ~/ total;
            print('${uploaded * 100 ~/ total}%');
          },
        );
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  void handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              state.messages.indexWhere((element) => element.id == message.id);
          var updatedMessage =
              (state.messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          state.messages[index] = updatedMessage;

          final documentsDir = Platform.isIOS
              ? (await getApplicationDocumentsDirectory()).path
              : Directory('/storage/emulated/0/Download').path;

          localPath = '$documentsDir/${message.name}';
          var isExistedFile = File(localPath).existsSync();

          if (!isExistedFile) {
            await Utils.downloadFile(
              url: message.uri,
              show: false,
              name: message.name,
            );
          }
        } catch (e) {
          print(e);
        } finally {
          final index =
              state.messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (state.messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          state.messages[index] = updatedMessage;
        }
      }

      await OpenFile.open(localPath);
    }
  }

  void handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index =
        state.messages.indexWhere((element) => element.id == message.id);
    final updatedMessage =
        (state.messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    state.messages[index] = updatedMessage;
  }

  void resetCount() {
    state.count = 0;
    state.isActiveScreen = true;
    messageController.add(state.count);
    //StreamCount.shared.controller.add(state.count);
  }

  void setIsActiveScren(bool active) {
    state.isActiveScreen = active;
  }
}
