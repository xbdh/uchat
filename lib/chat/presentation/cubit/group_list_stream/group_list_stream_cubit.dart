import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/group_entity.dart';
import '../../../domain/use_cases/get_group_list_stream_usecase.dart';

part 'group_list_stream_state.dart';

class GroupListStreamCubit extends Cubit<GroupListStreamState> {
  final GetGroupListStreamUseCase getGroupListStreamUseCase;
  GroupListStreamCubit(
  {
    required this.getGroupListStreamUseCase
  }
  ) : super(GroupListStreamInitial());

  Future<void> getGroupListStream({required String uid,required isPrivate}) async {
    try {
     emit(GroupListStreamLoading());
      final streamResponse = getGroupListStreamUseCase.call(uid,isPrivate);
      streamResponse.listen((groupLists) {
        emit(GroupListStreamLoaded(
          groupLists:groupLists,
        ));
      });
    } catch (e) {
      emit(GroupListStreamFailed());
    }
  }
}
