import 'dart:convert';
import 'dart:io';

import 'package:app_cudan/screens/chat/bloc/websocket_connect.dart';
import 'package:app_cudan/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:loggy/loggy.dart';
import 'package:rocket_chat_flutter_connector/models/channel.dart';
import 'package:rocket_chat_flutter_connector/models/room.dart';
import 'package:rocket_chat_flutter_connector/models/user.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/rocket_chat_data.dart';

class CustomWebSocketService {
  WebSocketChannel connectToWebSocket(String url, {required String authToken}) {
    WebSocketChannel webSocketChannel = IOWebSocketChannel.connect(url);
    _sendConnectRequest(webSocketChannel);
    _sendLoginRequest(
      webSocketChannel,
      authToken: authToken,
    );
    return webSocketChannel;
  }

  void _sendConnectRequest(WebSocketChannel webSocketChannel) {
    Map msg = {
      'msg': 'connect',
      'version': '1',
      'support': ['1', 'pre2', 'pre1'],
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void _sendLoginRequest(
    WebSocketChannel webSocketChannel, {
    required String authToken,
  }) {
    Map msg = {
      'msg': 'method',
      'method': 'login',
      'id': '17',
      'params': [
        {'resume': authToken},
      ],
    };

    webSocketChannel.sink.add(jsonEncode(msg));
  }

  WebSocketChannel connectToWebSocketLiveChat(String url) {
    WebSocketChannel webSocketChannel = IOWebSocketChannel.connect(url);
    _sendConnectRequest(webSocketChannel);

    return webSocketChannel;
  }

  void streamNotifyUserSubscribe(WebSocketChannel webSocketChannel, User user) {
    Map msg = {
      'msg': 'sub',
      'id': user.id! + DateTime.now().millisecond.toString(),
      'name': 'stream-notify-user',
      'params': [
        user.id! + '/notification',
        {'useCollection': false, 'args': []},
      ],
    };

    logInfo('🚀🚀  streamNotifyUserSubscribe $msg');

    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamNotifyRoom(
    WebSocketChannel webSocketChannel,
    User user,
    Room room,
  ) {
    Map msg = {
      'msg': 'method',
      'method': 'stream-notify-room',
      'id': '42',
      'params': ['${room.id}/typing', user.name, true],
    };
    logInfo('🚀🚀 streamNotifyRoom ${msg}');
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamChannelMessagesSubscribe(
    WebSocketChannel webSocketChannel,
    Channel channel,
  ) {
    Map msg = {
      'msg': 'sub',
      'id': channel.id! + 'subscription-id',
      'name': 'stream-room-messages',
      'params': [channel.id, false],
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamChannelMessagesUnsubscribe(
    WebSocketChannel webSocketChannel,
    Channel channel,
  ) {
    Map msg = {
      'msg': 'unsub',
      'id': channel.id! + 'subscription-id',
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamRoomMessagesSubscribe(
    WebSocketChannel webSocketChannel,
    Room room, {
    required String token,
  }) {
    Map msg = {
      'msg': 'sub',
      'id': room.id! + DateTime.now().millisecond.toString(),
      'name': 'stream-room-messages',
      'params': [
        room.id,
        {'useCollection': false, 'args': []},
      ],
    };
    logInfo('🚀🚀  streamRoomMessagesSubscribe $msg');
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamRoomMessagesUnsubscribe(
    WebSocketChannel webSocketChannel,
    Room room,
  ) {
    Map msg = {
      'msg': 'unsub',
      'id': room.id! + 'subscription-id',
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamRoomTypingEvent(WebSocketChannel webSocketChannel, String roomId) {
    Map msg = {
      'msg': 'sub',
      'id': roomId + 'subscription-id',
      'name': 'stream-notify-room',
      'params': ['$roomId/event'],
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendUserStatusEvent(WebSocketChannel webSocketChannel, String roomId) {
    Map msg = {
      'msg': 'sub',
      'id': roomId + 'subscription-id',
      'name': 'stream-notify-room',
      'params': ['$roomId/event'],
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendMessageOnChannel(
    String message,
    WebSocketChannel webSocketChannel,
    Channel channel,
  ) {
    Map msg = {
      'msg': 'method',
      'method': 'sendMessage',
      'id': '42',
      'params': [
        {'rid': channel.id, 'msg': message},
      ],
    };

    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendMessageOnRoom(
    String message,
    WebSocketChannel webSocketChannel,
    Room room,
  ) {
    Map msg = {
      'msg': 'method',
      'method': 'sendMessage',
      'id': '42',
      'params': [
        {'rid': room.id, 'msg': message},
      ],
    };
    logInfo('🚀🚀 streamNotifyRoom $msg');
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void updateMessageOnRoom(
    MessageChat message,
    WebSocketChannel webSocketChannel,
  ) {
    Map msg = {
      'msg': 'method',
      'method': 'updateMessage',
      'id': '42',
      'params': [message.toJson()],
    };
    logInfo('🚀🚀 streamNotifyRoom $msg');
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void setReaction(
    WebSocketChannel webSocketChannel,
    String emoji,
    String messageId,
    String token,
  ) {
    Map msg = {
      'msg': 'method',
      'method': 'setReaction',
      'id': '22',
      'params': [
        emoji,
        messageId,
        true,
      ],
    };
    logInfo('🚀🚀 streamNotifyRoom $msg');
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendPong(WebSocketChannel webSocketChannel) {
    Map msg = {'msg': 'pong'};
    logInfo('🚀🚀 sendPong $msg');
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  sendUserPresence(WebSocketChannel webSocketChannel, String status) {
    Map msg = {
      'msg': 'method',
      'method': 'UserPresence:setDefaultStatus',
      'id': '101',
      'params': [status],
    };
    return webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendUserPresenceOnline(WebSocketChannel webSocketChannel) {
    Map msg = {'msg': 'method', 'method': 'UserPresence:online', 'id': '42'};
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendUserPresenceAway(WebSocketChannel webSocketChannel) {
    Map msg = {'msg': 'method', 'method': 'UserPresence:away', 'id': '42'};
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamUserPresence(
    WebSocketChannel webSocketChannel,
    List<String> userId,
  ) {
    webSocketChannel.sink.add(
      jsonEncode({
        'msg': 'sub',
        'id': userId[0],
        'name': 'stream-user-presence',
        'params': [
          '',
          {'added': userId},
        ],
      }),
    );
  }

// Custom
  void getLastes50Message(WebSocketChannel webSocketChannel, Room room) {
    Map msg = {
      'msg': 'method',
      'method': 'loadHistory',
      'id': '42',
      'params': [
        room.id, null, 50,

        //  { "$date": 1480377601 }
      ],
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

//Live chat

  void getInitialDataLive(WebSocketChannel webSocketChannel) {
    Map msg = {
      'msg': 'method',
      'method': 'livechat:getInitialData',
      'id': '42',
      'params': [
        'id_user_livechat',
        //  { "$date": 1480377601 }
      ],
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void registerGuestChat(
    WebSocketChannel webSocketChannel,
    String token,
    String name,
    String email,
  ) {
    Map msg = {
      'msg': 'method',
      'method': 'livechat:registerGuest',
      'params': [
        "id_user_livechat",
        {
          'token': token,
          'name': name,
          'email': email,
          // "department": "3jMKjTQJxCDxwxxtx"
        }
      ],
      'id': '5',
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendMessageLiveChat(
    WebSocketChannel webSocketChannel,
    String id,
    String? rid,
    String token,
    String message,
  ) {
    Map msg = {
      'msg': 'method',
      'method': 'sendMessageLivechat',
      'params': [
        {
          '_id': DateTime.now().millisecondsSinceEpoch.toString(),
          'rid': rid,
          'msg': message,
          'token': token,
        }
      ],
      'id': '11',
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void sendOfflineMessage(
    WebSocketChannel webSocketChannel,
    String visitorName,
    String email,
    String message,
  ) {
    Map msg = {
      'msg': 'method',
      'method': 'livechat:sendOfflineMessage',
      'params': [
        {'name': visitorName, 'email': email, 'message': message},
      ],
      'id': '3',
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  void streamLiveChatRoom(
    WebSocketChannel webSocketChannel,
    String visitorToken,
    String id,
    String param,
  ) {
    Map msg = {
      'msg': 'sub',
      'id': DateTime.now().millisecond.toString(),
      'name': 'stream-room-messages',
      'params': [
        param,
        {
          'useCollection': false,
          'args': [
            {'visitorToken': visitorToken},
          ],
        }
      ],
    };
    webSocketChannel.sink.add(jsonEncode(msg));
  }

  Future closeLiveChatRoom(String? rid, String visitorToken) async {
    return await ApiService.shared.postApi(
      path: '${WebsocketConnect.serverUrl}/api/v1/livechat/room.close',
      data: {"rid": rid, "token": visitorToken},
    );
  }

  loadLiveChatHistory(String? roomId, String? token) async {
    return await ApiService.shared.getApi(
      path:
          '${WebsocketConnect.serverUrl}/api/v1/livechat/messages.history/$roomId',
      params: {"token": token},
    );
  }

  //upload File on Room
  openNewRoomLiveChat(
    WebSocketChannel webSocketChannel,
    String token,
    String? rId,
  ) async {
    return await ApiService.shared.getApi(
      path: '${WebsocketConnect.serverUrl}/api/v1/livechat/room',
      params: {
        "token": token,
      },
    );
  }

  void sendUploadFileOnRoom(
    WebSocketChannel webSocketChannel,
    Room room,
    File file,
    String? desc,
    token,
    userId,
  ) async {
    var listImageExt = ['jpg', 'jpeg', 'png'];
    var ext = file.path.split('.').last;
    var contentType = MediaType('file', ext);
    if (listImageExt.contains(ext)) {
      contentType = MediaType('image', ext);
    }
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, contentType: contentType),
      'description': desc,
    });

    var options = Options(
      headers: {
        'X-Auth-Token': token,
        'X-User-Id': userId,
      },
    );

    await ApiService.shared
        .postApi(
      path: '${WebsocketConnect.serverUrl}/api/v1/rooms.upload/${room.id}',
      data: formData,
      op: options,
    )
        .then((v) {
      print(v);
    });
  }

  void sendUploadFileOnLiveChat(
    WebSocketChannel webSocketChannel,
    String roomId,
    File file,
    String? desc,
    token,
  ) async {
    var listImageExt = ['jpg', 'jpeg', 'png'];
    var ext = file.path.split('.').last;
    var contentType = MediaType('file', ext);
    if (listImageExt.contains(ext)) {
      contentType = MediaType('image', ext);
    }
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, contentType: contentType),
      'description': desc,
    });

    var options = Options(
      headers: {
        'x-visitor-token': token,
      },
    );

    await ApiService.shared
        .postApi(
      path: '${WebsocketConnect.serverUrl}/api/v1/livechat/upload/$roomId',
      data: formData,
      op: options,
    )
        .then((v) {
      print(v);
    });
  }
}
