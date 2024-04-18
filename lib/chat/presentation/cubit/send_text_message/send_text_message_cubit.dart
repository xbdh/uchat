import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';
import 'package:uchat/chat/domain/entities/message_reply_entity.dart';

import '../../../../app/enums/enums.dart';
import '../../../../user/domain/entities/user_entity.dart';
import '../../../domain/use_cases/send_text_message_usecase.dart';

part 'send_text_message_state.dart';

class SendTextMessageCubit extends Cubit<SendTextMessageState> {
  // usecase
  SendTextMessageUseCase sendTextMessageUseCase;

  SendTextMessageCubit({required this.sendTextMessageUseCase}) : super(SendTextMessageInitial());

  Future<void> sendTextMessage({
    required UserEntity sender,
    required MessageReplyEntity? messageReply,
    required String recipientUID,
    required String recipientName,
    required String recipientImage,
    required String message,
    required MessageType messageType,
  }) async {

    try {
      await sendTextMessageUseCase.call(
        sender: sender,
        messageReply: messageReply,
        recipientUID: recipientUID,
        recipientName: recipientName,
        recipientImage: recipientImage,
        message: message,
        messageType: messageType,
      );
      emit(SendTextMessageSuccess());
    } catch (e) {
      emit(SendTextMessageFailed());
    }
  }

}
