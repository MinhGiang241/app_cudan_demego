import 'package:rocket_chat_flutter_connector/models/channel.dart';
import 'package:rocket_chat_flutter_connector/models/room.dart';
import 'package:rocket_chat_flutter_connector/services/http_service.dart'
    as rocket_http_service;
import 'package:rocket_chat_flutter_connector/web_socket/notification.dart'
    as rocket_notification;

class WebsocketConnect {
  static const String serverUrl =
      "https://chat.demego.vn"; // https://chat.masflex.vn
  static const String webSocketUrl =
      "wss://chat.demego.vn/websocket"; // wss://chat.demego.vn/websocket
  static const String username = "minhgiang241";
  static const String password = "Admin@123";
  static Channel channel = Channel(id: "GENERAL");
  static Room room = Room(id: "GENERAL");
  static final rocket_http_service.HttpService rocketHttpService =
      rocket_http_service.HttpService(Uri.parse(serverUrl));
}
