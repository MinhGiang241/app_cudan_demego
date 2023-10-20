part of 'new_chat_bloc.dart';

//@immutable
abstract class NewChatEvent {}

class NewChatInitEvent extends NewChatEvent {}

class registerTokenEvent extends NewChatEvent {}

class StartChatEvent extends NewChatEvent {
  StartChatEvent({this.startMessage});
  types.PartialText? startMessage;
}

class BackNewChatInitEvent extends NewChatEvent {}

class NewMessageEvent extends NewChatEvent {}
