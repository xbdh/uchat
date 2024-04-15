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
    final GetFriendRequestListUseCase getFriendRequestListUseCase;
    final GetFriendListUseCase getFriendListUseCase;
    final SendFriendRequestUseCase sendFriendRequestUseCase;
    final RemoveFriendUseCase removeFriendUseCase;

    late List<UserEntity> _friendRequestList;
    late List<UserEntity> _friendList;
    // get
    List<UserEntity> get friendRequestList => _friendRequestList;
    List<UserEntity> get friendList => _friendList;

   FriendRequestCubit({
    required this.acceptFriendRequestUseCase,
    required this.cancleFriendRequestUseCase,
    required this.getFriendRequestListUseCase,
    required this.getFriendListUseCase,
    required this.sendFriendRequestUseCase,
    required this.removeFriendUseCase,
  }) : super(FriendRequestInitial());

   Future<void> acceptFriendRequest({required String friendUID,required String myUID}) async {

      await acceptFriendRequestUseCase.call(friendUID, myUID);

    }

    Future<void> cancleFriendRequest({required String friendUID,required String myUID}) async {

        await cancleFriendRequestUseCase.call(friendUID, myUID);

   }

   Future<void> getFriendRequestList({required String myUID}) async {

       final friendRequestList = await getFriendRequestListUseCase.call(myUID);
       _friendRequestList = friendRequestList;

   }
   Future<void> getFriendList({required String myUID}) async {

       final friendList = await getFriendListUseCase.call(myUID);
        _friendList = friendList;

   }

   Future<void> sendFriendRequest({required String friendUID,required String myUID}) async {

       await sendFriendRequestUseCase.call(friendUID, myUID);

   }

    Future<void> removeFriend({required String friendUID,required String myUID}) async {

        await removeFriendUseCase.call(friendUID, myUID);

    }


}
