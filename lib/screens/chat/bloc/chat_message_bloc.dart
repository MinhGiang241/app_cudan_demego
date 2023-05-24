// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:app_cudan/generated/l10n.dart';
import 'package:app_cudan/screens/chat/bloc/websocket_connect.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rocket_chat_flutter_connector/models/user.dart';
import 'package:rocket_chat_flutter_connector/services/authentication_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/rocket_chat_data.dart';
import '../../../utils/utils.dart';
import '../custom/custom_websocket_service.dart';

part 'chat_message_event.dart';
part 'chat_message_state.dart';

var uuid = const Uuid();

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatState> {
  ChatMessageBloc()
      : super(
          ChatState(
            messagesMap: {},
            stateChat: StateChatEnum.INIT,
            showGreeting: false,
          ),
        ) {
    //   on<LoadChatMessageStart>((event, emit) async {
    //     emit(
    //       ChatMessageStart(
    //         user: user,
    //         authToken: authToken,
    //         visitorToken: event.visitorToken ?? "",
    //         roomId: event.roomId,
    //         webSocketChannel: event.webSocketChannel,
    //       ),
    //     );
    //   });
    //   on<BackChatMessageInit>((event, emit) async {
    //     emit(
    //       ChatMessageInitial(
    //         user: user,
    //         authToken: authToken,
    //         visitorToken: visitorToken,
    //       ),
    //     );
    //   });
    // }
    on<LoadChatMessageStart>((event, emit) async {
      emit(
        ChatState(
          stateChat: StateChatEnum.START,
          showGreeting: true,
          user: user,
          authToken: authToken,
          visitorToken: event.visitorToken ?? "",
          roomId: event.roomId,
          webSocketChannel: event.webSocketChannel,
          messagesMap: event.messagesMap ?? {},
        ),
      );
    });
    on<BackChatMessageInit>((event, emit) async {
      emit(
        ChatState(
          messagesMap: {},
          stateChat: StateChatEnum.INIT,
          showGreeting: false,
          user: user,
          authToken: authToken,
          visitorToken: visitorToken,
        ),
      );
    });
  }
  final _dio = Dio();
  WebSocketChannel? webSocketChannel;
  String authToken = '';
  User? user;
  String visitorToken = uuid.v4();
  CustomWebSocketService webSocketService = CustomWebSocketService();

  Future createVisitor(context, email, token, phone, name, residentId) async {
    await _dio.post(
      '${WebsocketConnect.serverUrl}/api/v1/livechat/visitor',
      data: {
        "visitor": {
          // "username": name,
          "_id": token,
          "name": name ?? phone,
          "email": email ?? "rocketchat@gmail.com",
          "token": token,
          "phone": phone,
          "customFields": [
            {
              "key": "residentCode",
              "value": residentId ?? "",
              "overwrite": true
            },
          ]
        }
      },
    ).then((v) {
      user = User.fromMap(v.data['visitor']);
      print(user);
    }).catchError((e) {
      Utils.showErrorMessage(context, e);
    });
  }

  Future getAuthentication(context) async {
    final AuthenticationService authenticationService =
        AuthenticationService(WebsocketConnect.rocketHttpService);
    var authen = await authenticationService
        .login(WebsocketConnect.username, WebsocketConnect.password)
        .catchError((e) {
      // Utils.showErrorMessage(context, e.toString());
    });
    authToken = authen.data?.authToken ?? "";
    user = authen.data!.me;

    return authen;
    // throw RocketChatException((result as Map)['body']);
  }

  void registerGuestChat(String token, String name, String email) {
    webSocketService.registerGuestChat(
      state.webSocketChannel!,
      visitorToken,
      name,
      email,
    );
  }

  Future openNewRoomLiveChat(String token) async {
    return await webSocketService.openNewRoomLiveChat(
      state.webSocketChannel!,
      token,
      null,
    );
  }

  setRoomId(String? rId) {
    state.roomId = rId;
  }

  Future loadLiveChatHistory(roomId, token) async {
    await webSocketService.loadLiveChatHistory(roomId, token).then((v) {
      if (v['messages'] != null) {
        state.messagesMap.clear();
        for (var i in v['messages'].reversed) {
          var me = MessageChat.fromJson(i);
          // print(i);
          state.messagesMap[me.id ?? ""] = me;
        }
      }
    });
  }

  void streamLiveChatRoom(String visitorToken, String id, String param) {
    webSocketService.streamLiveChatRoom(
      state.webSocketChannel!,
      visitorToken,
      state.roomId ?? id,
      state.roomId ?? param,
    );
  }

  genUniqueId() {
    return uuid.v4();
  }

  void sendStartMessage(String? token, String message) {
    if (message.isNotEmpty) {
      webSocketService.sendMessageLiveChat(
        state.webSocketChannel!,
        genUniqueId(),
        state.roomId,
        token ?? "",
        message,
      );
    }
  }

  void addMessage(MessageChat m) {
    state.messagesMap[m.id ?? ''] = m;
  }

  void toogleGreeting() {
    state.showGreeting = !state.showGreeting;
  }

  void closeChatRoom(String? rid) {
    state.webSocketService.closeLiveChatRoom(rid, visitorToken);
  }

  void scroll() {
    state.scrollController
        .jumpTo(state.scrollController.position.maxScrollExtent);
  }

  selectEmoji(String emoji) {
    state.textEditionController.text = state.textEditionController.text + emoji;
  }

  void sendMessageLiveChat(
    String id,
    String rid,
    String token,
    String message,
  ) {
    webSocketService.sendMessageLiveChat(
      state.webSocketChannel!,
      id,
      state.roomId ?? rid,
      visitorToken,
      message,
    );
  }

  void sendMessage(String token) {
    if (state.textEditionController.text.isNotEmpty) {
      // webSocketService.sendMessageOnChannel(textEditionController.text,
      //     webSocketChannel!, WebsocketConnect.channel);
      print('text:${state.textEditionController.text.trim()}');
      webSocketService.sendMessageLiveChat(
        state.webSocketChannel!,
        genUniqueId(),
        state.roomId ?? token,
        token,
        state.textEditionController.text.trim(),
      );
      state.textEditionController.clear();
    }
  }

  sendUploadFileOnLiveChat(File file, token, rid) {
    webSocketService.sendUploadFileOnLiveChat(
      state.webSocketChannel!,
      state.roomId ?? rid,
      file,
      state.textEditionController.text.trim(),
      token,
    );
    state.textEditionController.clear();
  }

  void sendGreetingMessage(String rid, String token, String message) {
    if (message.isNotEmpty) {
      webSocketService.sendMessageLiveChat(
        state.webSocketChannel!,
        genUniqueId(),
        state.roomId ?? rid,
        token,
        message,
      );
    }
  }

  void clearMessage(String key) {
    state.messagesMap.remove(key);
  }

  void setQuit(bool v) {
    state.quit = v;
  }
}
