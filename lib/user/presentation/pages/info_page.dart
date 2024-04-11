import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uchat/app/utils/methods.dart';
import 'package:uchat/app/widgets/dispaly_user_avatar.dart';
import 'package:uchat/user/data/models/user_model.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';

class InfoPage extends StatefulWidget {
   final String email;
   final String uid;
   const InfoPage({super.key, required this.email, required this.uid});

  @override
  State<InfoPage> createState() => _InfoPAgeState();
}

class _InfoPAgeState extends State<InfoPage> {
  File? finalImage;
  String userImage = '';

  // controller
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void pop() {
    context.pop(); // 退出showModalBottomSheet
  }

  Future<void> _selectImage(bool fromCamera) async {
    final File? selectImageFile = await pickImage(
        context: context,
        fromCamera: fromCamera,
        onFail: (String message) {
          showSnackBar(context: context, message: message);
        });
    await _cropImage(selectImageFile?.path);

    pop();
  }

  // crop image
  Future<void> _cropImage(String? path) async {
    if (path != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        maxHeight: 512,
        maxWidth: 512,
        compressQuality: 100,
      );
      if (croppedFile != null) {
        setState(() {
          finalImage = File(croppedFile.path);
        });
      }
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    await _selectImage(true);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                  onTap: () async {
                    await _selectImage(false);
                  },
                ),
              ],
            ),
          );
        });
  }

  void savaDataRemote(File? finalImage) {
    // String? id= BlocProvider.of<AuthCubit>(context).uid;
    // print("id+++++++++++"  );
    // print(id);
    //  Map p = GoRouterState.of(context).pathParameters as Map<String, dynamic>;
    //  String email = p['email'] as String;
    //  String uid = p['uid'] as String;

    UserEntity user = UserEntity(
        uid: widget.uid,
        name: _nameController.text.trim(),
        // get email from route

        email: widget.email,
        image: '',
        token: '',
        aboutMe: 'hey there! I am using uchat.',
        status: '',
        lastSeen: '',
        createdAt: '',
        isOnline: true,
        friendsUIDs: [],
        getFriendRequestsUIDs: [],
        sentFriendRequestsUIDs: [],
        );
    BlocProvider.of<UserCubit>(context).saveData(user, finalImage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, userState) {
        final u = BlocProvider.of<UserCubit>(context).userEntity;
        if (userState is UserSavaDataSuccess) {
          context.goNamed("Home");
        }
        if (userState is UserSavaDataFail) {
          showSnackBar(context: context, message: "Failed to save data ");
        }
      },
      builder: (context, userState) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('User Info'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.goNamed("Login");
                },
              )
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(children: [
                  DisplayUserAvatar(
                    finalFileImage: finalImage,
                    radius: 70,
                    onPressed: () {
                      showBottomSheet();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        labelText: 'Enter your name',
                        hintText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: MaterialButton(
                        onPressed: (userState is UserLoading)
                            ? null
                            : () {
                                if (_nameController.text.trim().isEmpty ||
                                    _nameController.text.trim().length < 3) {
                                  showSnackBar(
                                      context: context,
                                      message: 'Name is to short');
                                  return;
                                }
                                savaDataRemote(finalImage);
                              },
                        child: (userState is UserLoading)
                            ? const CircularProgressIndicator(
                                color: Colors.orangeAccent,
                              )
                            : const Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.5),
                              )),
                  ),
                ]),
              ),
            ));
      },
    );
  }
}
