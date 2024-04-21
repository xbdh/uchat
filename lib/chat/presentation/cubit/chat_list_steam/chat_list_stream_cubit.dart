import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/last_message_entity.dart';
import '../../../domain/use_cases/get_chat_list_stream_usecase.dart';

part 'chat_list_stream_state.dart';

class ChatListStreamCubit extends Cubit<ChatListStreamState> {
  GetChatListStreamUseCase getChatListStreamUseCase;

  ChatListStreamCubit({required this.getChatListStreamUseCase}) : super(ChatListStreamInitial());

  Future<void> getChatListStream({required String uid}) async {
    try {
      emit(ChatListStreamLoading());
      final streamResponse = getChatListStreamUseCase.call(uid);
      streamResponse.listen((chatLists) {
        emit(ChatListStreamLoaded(
          chatLists: chatLists,
        ));
      });
    } catch (e) {
      emit(ChatListStreamFailed());
    }
  }

}
