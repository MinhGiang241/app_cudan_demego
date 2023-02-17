import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app_cudan/screens/chat/bloc/websocket_connect.dart';
import 'package:app_cudan/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:meta/meta.dart';
import 'package:rocket_chat_flutter_connector/exceptions/exception.dart';
import 'package:rocket_chat_flutter_connector/models/authentication.dart';
import 'package:rocket_chat_flutter_connector/models/user.dart';
import 'package:rocket_chat_flutter_connector/services/authentication_service.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/rocket_chat_data.dart';
import '../../../utils/utils.dart';
import '../custom/custom_websocket_service.dart';

part 'chat_message_event.dart';
part 'chat_message_state.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  ChatMessageBloc() : super(ChatMessageInitial()) {
    on<LoadChatMessageStart>((event, emit) async {
      emit(ChatMessageStart(
        user: user,
        authToken: authToken,
      ));
    });
    on<BackChatMessageInit>((event, emit) async {
      emit(ChatMessageInitial(
        user: user,
        authToken: authToken,
      ));
    });
  }

  String authToken = '';
  User? user;

  Future getAuthentication(context) async {
    final AuthenticationService authenticationService =
        AuthenticationService(WebsocketConnect.rocketHttpService);
    var authen = await authenticationService
        .login(WebsocketConnect.username, WebsocketConnect.password)
        .catchError((e) {
      Utils.showErrorMessage(context, e.toString());
    });
    authToken = authen.data?.authToken ?? "";
    user = authen.data!.me;

    return authen;
    // throw RocketChatException((result as Map)['body']);
  }

  // @override
  // Stream<ChatMessageState> mapEventToState(ChatMessageEvent event)async{
  //   if(event is ChatMessageStart){
  //     yield ();
  //   }
  // }
}
