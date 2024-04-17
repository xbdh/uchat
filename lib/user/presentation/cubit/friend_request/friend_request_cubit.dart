import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/domain/use_cases/friend/accept_friend_request_usecase.dart';
import 'package:uchat/user/domain/use_cases/friend/cancle_friend_request_usecase.dart';
import 'package:uchat/user/domain/use_cases/friend/get_friend_list_usecase.dart';
import 'package:uchat/user/domain/use_cases/friend/get_friend_requests_list_usecase.dart';
import 'package:uchat/user/domain/use_cases/friend/remove_friend_usecase.dart';
import 'package:uchat/user/domain/use_cases/friend/send_friend_request_usecase.dart';

part 'friend_request_state.dart';

class FriendRequestCubit extends Cubit<FriendRequestState> {
  final AcceptFriendRequestUseCase acceptFriendRequestUseCase;
  final CancleFriendRequestUseCase cancleFriendRequestUseCase;

  final SendFriendRequestUseCase sendFriendRequestUseCase;
  final RemoveFriendUseCase removeFriendUseCase;


  FriendRequestCubit({
    required this.acceptFriendRequestUseCase,
    required this.cancleFriendRequestUseCase,
    required this.sendFriendRequestUseCase,
    required this.removeFriendUseCase,
  }) : super(FriendRequestInitial());

  Future<void> acceptFriendRequest(
      {required String friendUID, required String myUID}) async {

    try {
      await acceptFriendRequestUseCase.call(friendUID, myUID);
      emit(FriendRequestAccepted());
    } catch (e) {
     emit(FriendRequestFailed());
    }
  }

  Future<void> cancleFriendRequest(
      {required String friendUID, required String myUID}) async {

    try {
      await cancleFriendRequestUseCase.call(friendUID, myUID);
      emit(FriendRequestCancled());
    } catch (e) {
      emit(FriendRequestFailed());
    }
  }



  Future<void> sendFriendRequest(
      {required String friendUID, required String myUID}) async {

    try {
      await sendFriendRequestUseCase.call(friendUID, myUID);
      emit(FriendRequestSent());
    } catch (e) {
      emit(FriendRequestFailed());
    }
  }

  Future<void> removeFriend(
      {required String friendUID, required String myUID}) async {

    try {
      await removeFriendUseCase.call(friendUID, myUID);
      emit(FriendRemoved());
    } catch (e) {
      emit(FriendRequestFailed());
    }
  }
}
