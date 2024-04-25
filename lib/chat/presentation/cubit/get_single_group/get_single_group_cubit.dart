import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/group_entity.dart';
import '../../../domain/use_cases/get_single_group_usecase.dart';

part 'get_single_group_state.dart';

class GetSingleGroupCubit extends Cubit<GetSingleGroupState> {
  final GetSingleGroupUseCase getSingleGroupUseCase;
  GetSingleGroupCubit(
  {
    required this.getSingleGroupUseCase,
  }
  ) : super(GetSingleGroupInitial());

 Future<void> getSingleGroup(String groupId) async {
    emit(GetSingleGroupLoading());
    try {
      final group = await getSingleGroupUseCase(groupId);
      emit(GetSingleGroupLoaded(group: group));
    } catch (e) {
      emit(GetSingleGroupFailed());
    }
  }
}
