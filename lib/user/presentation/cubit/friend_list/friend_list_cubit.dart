import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/friend/get_friend_list_usecase.dart';
import 'package:uchat/user/domain/use_cases/friend/get_friend_requests_list_usecase.dart';

part 'friend_list_state.dart';

class FriendListCubit extends Cubit<FriendListState> {
  final GetFriendRequestListUseCase getFriendRequestListUseCase;
  final GetFriendListUseCase getFriendListUseCase;
  FriendListCubit({ required this.getFriendRequestListUseCase,  required this.getFriendListUseCase}) : super(FriendListInitial());

  Future<void> getFriendRequestList({required String myUID}) async {

    try {
      final friendRequestList = await getFriendRequestListUseCase.call(myUID);
      emit(FriendListLoaded(
        friends: friendRequestList

      ));
    } catch (e) {
      emit(FriendListFailed());
    }
  }

  Future<void> getFriendList({required String myUID}) async {


    try {
      final friendList = await getFriendListUseCase.call(myUID);
      //print("friendList++++++++++: $friendList  ");
      emit(FriendListLoaded(
          friends:  friendList

      ));
    } catch (e) {
      emit(FriendListFailed());
    }
  }
}
