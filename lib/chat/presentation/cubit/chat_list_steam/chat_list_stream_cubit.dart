import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/last_message_entity.dart';
import '../../../domain/use_cases/get_chat_list_stream_usecase.dart';

part 'chat_list_stream_state.dart';

class ChatListStreamCubit extends Cubit<ChatListStreamState> {
  GetChatListStreamUseCase getChatListStreamUseCase;

  ChatListStreamCubit({required this.getChatListStreamUseCase}) : super(ChatListStreamInitial());

  //late Stream<List<LastMessageEntity>> chatListStream;
  late StreamSubscription<List<LastMessageEntity>> chatListStreamSubscription;
  Future<void> getChatListStream({required String uid}) async {
    try {
      emit(ChatListStreamLoading());
      final chatListStream = getChatListStreamUseCase.call(uid);
      chatListStreamSubscription=chatListStream.listen((chatLists) {
        emit(ChatListStreamLoaded(
          chatLists: chatLists,
        ));
      });
    } catch (e) {
      emit(ChatListStreamFailed());
    }
  }

  Future<void> leaveChatListStream() async {
    chatListStreamSubscription.cancel();
  }

}
