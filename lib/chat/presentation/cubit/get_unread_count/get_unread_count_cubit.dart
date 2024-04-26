import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/use_cases/get_unread_count_usecase.dart';

part 'get_unread_count_state.dart';

class GetUnreadCountCubit extends Cubit<GetUnreadCountState> {
  GetUnreadCountUseCase getUnreadCountUseCase;
  GetUnreadCountCubit(
  {
    required this.getUnreadCountUseCase
  }
      ) : super(GetUnreadCountInitial());

  Future<void> getUnreadCount({
    required String uid,
    required String recipientUID,
    required bool  isGroup,
  }) async {
    try {
      emit(GetUnreadCountLoading());
      final countStream = getUnreadCountUseCase.call(uid, recipientUID, isGroup);
      countStream.listen((count) {
        emit(GetUnreadCountLoaded(count: count));
      });
    } catch (e) {
      emit(GetUnreadCountFailed());
    }
  }
}
