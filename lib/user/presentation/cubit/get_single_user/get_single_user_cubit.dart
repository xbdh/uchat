import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/user/get_single_user_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
// require to pass the usecase
  GetSingleUserCubit({
    required this.getSingleUserUseCase,
  }) : super(GetUserInitial());
  Future<void> getSingleUser({required String uid}) async {
    try {
      emit(GetUserLoading());
      final streamResponse = getSingleUserUseCase.call(uid);
      streamResponse.listen((user) {
        emit(GetSingleUserLoaded(singleUser: user));
      });
    } on Exception catch (e) {
      emit(GetSingleUserFailure());
    }
  }

  
}
