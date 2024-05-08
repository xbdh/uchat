import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/use_cases/get_chat_message_list_stream_usecase.dart';

part 'chat_message_list_stream_state.dart';

class ChatMessageListStreamCubit extends Cubit<ChatMessageListStreamState> {
  GetChatMessageListStreamUseCase getChatMessageListStreamUseCase;
  ChatMessageListStreamCubit(
      {required this.getChatMessageListStreamUseCase}
      ) : super(ChatMessageListStreamInitial());

  late StreamSubscription<List<MessageEntity>> chatMessageListStreamSubscription;
  Future<void> getChatMessageListStream({
    required String senderUID,
    required String recipientUID,
    required String? groupID,
  }) async {
    try {
      emit(ChatMessageListStreamLoading());
      final streamRespond = getChatMessageListStreamUseCase.call(
        senderUID, recipientUID, groupID,
      );
      chatMessageListStreamSubscription=streamRespond.listen((streams) {
        // if closed
        emit(ChatMessageListStreamLoaded(
          messageLists: streams,
        ));
      });

    } catch (e) {
      emit(ChatMessageListStreamFailed());
    }
  }

  Future<void> leaveChatMessageListStream() async {
    chatMessageListStreamSubscription.cancel();
  }
}
