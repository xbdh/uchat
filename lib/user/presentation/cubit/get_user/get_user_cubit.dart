import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/user/get_all_user_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/get_single_user_usecase.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
// require to pass the usecase
  GetUserCubit({
    required this.getSingleUserUseCase,
    required this.getAllUsersUseCase,
  }) : super(GetUserInitial());
  Future<void> getSingleUser({required String uid}) async {
    try {
      emit(GetUserLoading());
      final streamResponse = getSingleUserUseCase.call(uid);
      streamResponse.listen((user) {
        emit(GetSingleUserLoaded(singleUser: user));
      });
    } on Exception catch (e) {
      emit(GetUserFailure());
    }
  }

  Future<void> getAllUser(bool includeMe) async {
    try {
      emit(GetUserLoading());
      final streamResponse = getAllUsersUseCase.call(includeMe);
      streamResponse.listen((users) {
        if (includeMe) {
          emit(GetAllUserLoaded(allUser: users));

        }else{
          emit(GetUsersExpectMeLoaded(allUser: users));
        }
      });
    } on Exception catch (e) {
      emit(GetUserFailure());
    }
  }
}
