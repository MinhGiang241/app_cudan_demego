import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_cudan/generated/intl/messages_en.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
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
                  lastName: "Tin nhắn tự động",
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
          "department": ApiService.shared.regCode, //tecco
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
      //openRoomLiveChat();
      //sendStartChat();
      //streamLiveChat();
      //keepConnectChannel(context);
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
      lastName: data["fields"]?['args']?[0]?['u']?['name'],
    );
    if (state.employee == null && state.user?.id != user.id) {
      state.employee = user;
    }
    if (state.employee != null && state.employee?.lastName == null) {
      state.employee = user;
    }

    if (data["fields"]?['args']?[0]?['attachments'] != null &&
        data["fields"]?['args']?[0]?['attachments'].isNotEmpty) {
      var attachment = data["fields"]?['args']?[0]?['attachments']?[0];
      // Check điều kiện file tải lên là hình ảnh
      if (attachment?['type'] == 'file' &&
          attachment?["image_type"].contains("image")) {
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
      }
    } else {
      types.Message message = types.TextMessage(
        author: user,
        createdAt: data["fields"]?['args']?[0]?['ts']?['\$date'] ??
            DateTime.now().microsecondsSinceEpoch,
        id: data["fields"]?['args']?[0]?['_id'],
        text: data["fields"]?['args']?[0]?['msg'],
      );
      state.messages.insert(0, message);
    }

    //context.read<NewChatBloc>().add(NewMessageEvent());
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

  // void handleImageSelection(BuildContext context) async {
  //   var listImageExt = ['png', 'jpg', 'jpeg'];
  //   Utils.selectImage(context, false, isFile: true).then(
  //     (value) async {
  //       if (value != null) {
  //         if (listImageExt.contains(value[0].name.split('.').last)) {
  //           final bytes = await value[0].readAsBytes();
  //           final image = await decodeImageFromList(bytes);

  //           final message = types.ImageMessage(
  //             author: state.user!,
  //             createdAt: DateTime.now().millisecondsSinceEpoch,
  //             height: image.height.toDouble(),
  //             id: uuid.v4(),
  //             name: value[0].name,
  //             size: bytes.length,
  //             uri: value[0].path,
  //             width: image.width.toDouble(),
  //           );

  //           uploadFileLiveChat(message);
  //         } else {
  //           final bytes = await value[0].readAsBytes();

  //           final message = types.FileMessage(
  //             author: state.user!,
  //             createdAt: DateTime.now().millisecondsSinceEpoch,
  //             id: uuid.v4(),
  //             name: value[0].name,
  //             size: bytes.length,
  //             uri: value[0].path,
  //           );
  //           uploadFileLiveChat(message);
  //         }
  //       }
  //     },
  //   );
  // }

  uploadFileLiveChat(BuildContext context) {
    Utils.selectImage(context, false, isFile: true).then((v) {
      if (v != null && v.isNotEmpty) {
        NewChatServices.shared.sendUploadFileOnLiveChat(
          state.webSocketChannel!,
          state.roomId ?? "",
          File(v[0].path),
          v[0].name,
          state.visitorToken,
        );
      }
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }
}
