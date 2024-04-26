import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uchat/chat/domain/use_cases/update_last_message_status_usecase.dart';

import '../../../domain/use_cases/update_group_message_status_usecase.dart';
import '../../../domain/use_cases/update_message_status_usecase.dart';

part 'set_message_status_state.dart';

class SetMessageStatusCubit extends Cubit<SetMessageStatusState> {
  UpdateMessageStatusUseCase updateMessageStatusUseCase;
  UpdateLastMessageStatusUseCase updateLastMessageStatusUseCase;
  UpdateGroupMessageStatusUseCase updateGroupMessageStatusUseCase;
 SetMessageStatusCubit({
   required this.updateMessageStatusUseCase,
   required this.updateLastMessageStatusUseCase,
    required this.updateGroupMessageStatusUseCase
 }) : super(SetMessageStatusInitial());

  Future<void> setMessageStatus({
    required String currentUID,
    required  String recipientUID,
    required  String messageID,
    required bool isGroup,
    required List<String> isSeenByList

  }) async {
    try {
      if (isGroup) {
        if (isSeenByList.contains(currentUID )) {
          return;
        }else {
          await updateGroupMessageStatusUseCase.call(currentUID, recipientUID, messageID);
          emit(SetMessageStatusSuccess());
        }
      }else {
        await updateMessageStatusUseCase.call(currentUID, recipientUID, messageID);
        await updateLastMessageStatusUseCase.call(currentUID, recipientUID);
        emit(SetMessageStatusSuccess());
      }

    } catch (e) {
      emit(SetMessageStatusFailed());
    }
  }
}
