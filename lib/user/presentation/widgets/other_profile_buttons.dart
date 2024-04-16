import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/app/utils/methods.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';

class OtherProfileButton extends StatefulWidget {
  final String loginUid;
  final UserEntity userEntity;

  const OtherProfileButton(
      {super.key, required this.loginUid, required this.userEntity});

  @override
  State<OtherProfileButton> createState() => _OtherProfileButtonState();
}

class _OtherProfileButtonState extends State<OtherProfileButton> {
  @override
  Widget build(BuildContext context) {
    final loginUid = widget.loginUid;
    final userEntity = widget.userEntity;

    Widget buildButtons() {
      // else show send friend request button
      if (userEntity.friendRequestsFromUIDs.contains(loginUid)) {
        // show send friend request button
        return MyElevatedButton(
          onPressed: () async {
            // await context
            //     .read<AuthenticationProvider>()
            //     .cancleFriendRequest(friendID: userModel.uid)
            //     .whenComplete(() {
            //   showSnackBar(context, 'Request Canceled');
            // });
            BlocProvider.of<FriendRequestCubit>(context).cancleFriendRequest(
              friendUID: userEntity.uid,
              myUID: loginUid,
            );
          },
          label: 'Cancle Request',
          //width: MediaQuery.of(context).size.width * 0.7,
          backgroundColor: Theme.of(context).cardColor,
          textColor: Theme.of(context).colorScheme.primary,
        );
      } else if (userEntity.sentFriendRequestsToUIDs.contains(loginUid)) {
        return MyElevatedButton(
          onPressed: () async {
            // await context
            //     .read<AuthenticationProvider>()
            //     .acceptFriendRequest(friendID: userModel.uid)
            //     .whenComplete(() {
            //   showSnackBar(
            //       context, 'You are now friends with ${userModel.name}');
            // });
            BlocProvider.of<FriendRequestCubit>(context).acceptFriendRequest(
              friendUID: userEntity.uid,
              myUID: loginUid,
            );
          },
          label: 'Accept Friend',
          //width: MediaQuery.of(context).size.width * 0.4,
          backgroundColor: Theme.of(context).cardColor,
          textColor: Theme.of(context).colorScheme.primary,
        );
      } else if (userEntity.friendsUIDs.contains(loginUid)) {
        return Column(
          children: [
            MyElevatedButton(
              onPressed: () async {
                // show unfriend dialog to ask the user if he is sure to unfriend
                // create a dialog to confirm logout
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Unfriend',
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      'Are you sure you want to Unfriend ${userEntity.name}?',
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          // remove friend
                          // await context
                          //     .read<AuthenticationProvider>()
                          //     .removeFriend(friendID: userModel.uid)
                          //     .whenComplete(() {
                          //   showSnackBar(
                          //       context, 'You are no longer friends');
                          // });
                          BlocProvider.of<FriendRequestCubit>(context)
                              .removeFriend(
                            friendUID: userEntity.uid,
                            myUID: loginUid,
                          );
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              label: 'Unfriend',
              //width: MediaQuery.of(context).size.width * 0.4,
              backgroundColor: Colors.deepPurple,
              textColor: Colors.white,
            ),
            const SizedBox(width: 10),
            MyElevatedButton(
              onPressed: () async {
                // navigate to chat screen
                // navigate to chat screen with the folowing arguments
                // 1. friend uid 2. friend name 3. friend image 4. groupId with an empty string
                // Navigator.pushNamed(context, Constants.chatScreen,
                //     arguments: {
                //       Constants.contactUID: userModel.uid,
                //       Constants.contactName: userModel.name,
                //       Constants.contactImage: userModel.image,
                //       Constants.groupId: ''
                //     });
              },
              label: 'Chat',
              // width: MediaQuery.of(context).size.width * 0.4,
              backgroundColor: Theme.of(context).cardColor,
              textColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 10),
            MyElevatedButton(
              onPressed: () async {
                // navigate to chat screen
                // navigate to chat screen with the folowing arguments
                // 1. friend uid 2. friend name 3. friend image 4. groupId with an empty string
                // Navigator.pushNamed(context, Constants.chatScreen,
                //     arguments: {
                //       Constants.contactUID: userModel.uid,
                //       Constants.contactName: userModel.name,
                //       Constants.contactImage: userModel.image,
                //       Constants.groupId: ''
                //     });
              },
              label: 'call/video',
              // width: MediaQuery.of(context).size.width * 0.4,
              backgroundColor: Theme.of(context).cardColor,
              textColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        );
      } else {
        return MyElevatedButton(
          onPressed: () async {
            // await context
            //     .read<AuthenticationProvider>()
            //     .sendFriendRequest(friendID: userModel.uid)
            //     .whenComplete(() {
            //   showSnackBar(context, 'friend request sent');
            // });

            BlocProvider.of<FriendRequestCubit>(context).sendFriendRequest(
              friendUID: userEntity.uid,
              myUID: loginUid,
            );
          },
          label: 'Send Request',
          // width: MediaQuery.of(context).size.width * 0.7,
          backgroundColor: Theme.of(context).cardColor,
          textColor: Theme.of(context).colorScheme.primary,
        );
      }
    }

    return BlocListener<FriendRequestCubit, FriendRequestState>(
      listener: (context, friendRequest) {

        if (friendRequest is FriendRequestAccepted) {
          showSnackBar(
             message: 'You are now friends with ${userEntity.name}',
            context: context,
          );
        } else if (friendRequest is FriendRequestCancled) {
          showSnackBar(
            message: 'Request Canceled',
            context: context,
          );
        } else if (friendRequest is FriendRequestFailed) {
          showSnackBar(
            message: 'Failed',
            context: context,
          );
        } else if (friendRequest is FriendRequestSent) {
          showSnackBar(
            message: 'Friend request sent',
            context: context,
          );
        }

      },
      child: buildButtons(),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    //required this.width,
    required this.backgroundColor,
    required this.textColor,
  });

  final VoidCallback onPressed;
  final String label;

  //final double width;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    Widget buildElevatedButton() {
      return SizedBox(
        //width: width,
        //  // 占据整个宽度
        width: double.infinity,
        child: ElevatedButton(


          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      );
    }

    return buildElevatedButton();
  }
}
