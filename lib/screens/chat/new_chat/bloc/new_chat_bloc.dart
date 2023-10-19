import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
                  imageUrl:
                      'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o=',
                  id: '82091008-a484-4a89-ae75-a22bf8d6f3ad',
                ),
                createdAt: DateTime.now().millisecondsSinceEpoch,
                id: const Uuid().v4(),
                text:
                    "Quý khách cần giúp đỡ , hãy chờ ít phút để nhân viên trả lời lại",
              ),
            ],
          ),
        ) {
    on<StartChatEvent>((event, emit) {
      emit(state.copyWith(isInit: false));
    });
    on<NewChatInitEvent>((event, emit) {
      emit(state.copyWith(isInit: true));
    });
    on<NewMessageEvent>((event, emit) {
      emit(state.copyWith(messages: state.messages));
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
      keepConnectChannel(context);
      openRoomLiveChat();
      sendStartChat();
      streamLiveChat();
    }).catchError((e) {
      Utils.showErrorMessage(context, e.toString());
    });
  }

  keepConnectChannel(BuildContext context) {
    state.webSocketChannel?.stream.listen((message) {
      print(message);
      var data = json.decode(message);
      if (data['msg'] == 'ping') {
        NewChatServices.shared.sendPong(state.webSocketChannel!);
      }
      if (data['msg'] == 'changed') {
        addMessageToScreen(context, data);
      }
    });
  }

  openRoomLiveChat() async {
    var room = await NewChatServices.shared.openNewRoomLiveChat(
      state.webSocketChannel!,
      state.visitorToken ?? "",
      null,
    );
    print(room);
    state.roomId = room['room']?['_id'];
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

  addMessageToScreen(BuildContext context, data) {
    print(data);
    types.User user = types.User(
      id: data["fields"]?['args']?[0]?['u']?['_id'],
      lastName: data["fields"]?['args']?[0]?['u']?['name'],
    );
    types.Message message = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: data["fields"]?['args']?[0]?['_id'],
      text: data["fields"]?['args']?[0]?['msg'],
    );
    state.messages.insert(0, message);
    context.read<NewChatBloc>().add(NewMessageEvent());
  }
}
