import 'package:app_cudan/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_message_event.dart';
part 'chat_message_state.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  ChatMessageBloc() : super(ChatMessageInitial()) {
    on<ChatMessageEvent>((event, emit) async {
      emit(ChatMessageStart());
    });
    on<BackChatMessageInit>((event, emit) async {
      emit(ChatMessageInitial());
    });
  }
}
