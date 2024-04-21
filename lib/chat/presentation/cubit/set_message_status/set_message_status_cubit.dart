import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uchat/chat/domain/use_cases/update_last_message_status_usecase.dart';

import '../../../domain/use_cases/update_message_status_usecase.dart';

part 'set_message_status_state.dart';

class SetMessageStatusCubit extends Cubit<SetMessageStatusState> {
  UpdateMessageStatusUseCase updateMessageStatusUseCase;
  UpdateLastMessageStatusUseCase updateLastMessageStatusUseCase;
 SetMessageStatusCubit({required this.updateMessageStatusUseCase, required this.updateLastMessageStatusUseCase}) : super(SetMessageStatusInitial());

  Future<void> setMessageStatus({
    required String senderUID,
    required  String recipientUID,
    required  String messageID}) async {
    try {
      await updateMessageStatusUseCase.call(senderUID, recipientUID, messageID);
      await updateLastMessageStatusUseCase.call(senderUID, recipientUID);
      emit(SetMessageStatusSuccess());
    } catch (e) {
      emit(SetMessageStatusFailed());
    }
  }
}
