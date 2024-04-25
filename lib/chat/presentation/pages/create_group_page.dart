import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uchat/chat/presentation/cubit/create_group/create_group_cubit.dart';
import 'package:uchat/chat/presentation/widgets/group_type_radio_list.dart';
import 'package:uchat/app/widgets/friend_list_group_view_title.dart';
import 'package:uchat/app/widgets/friends_list.dart';

import '../../../app/enums/enums.dart';
import '../../../app/utils/methods.dart';
import '../../../app/widgets/dispaly_user_avatar.dart';
import '../../../user/presentation/cubit/uid/uid_cubit.dart';
import '../../domain/entities/group_entity.dart';
import 'package:uchat/main_injection_container.dart' as di;

class CreateGroupPage extends StatefulWidget {
  const CreateGroupPage({super.key});

  @override
  State<CreateGroupPage> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  File? finalImageFile;
  String userImage = '';
  GroupType groupValue = GroupType.private;

  // controller
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _groupDesController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupDesController.dispose();
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
          finalImageFile = File(croppedFile.path);
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

  @override
  Widget build(BuildContext context) {
    final uid = context.watch<UidCubit>().state;
    return BlocProvider(
  create: (context) => di.sl<CreateGroupCubit>(),
  child: BlocConsumer<CreateGroupCubit, CreateGroupState>(
  listener: (context, state) {
    if (state is CreateGroupSuccess) {
      showSnackBar(context: context, message: 'Group created successfully');
      context.pop();
    }
  },
  builder: (context, state) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Create Group'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.pop();
              },
            ),
          actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  final groupName = _groupNameController.text;
                  final groupDes = _groupDesController.text;
                  if (groupName.isNotEmpty && finalImageFile != null) {
                    final GroupEntity groupEntity = GroupEntity(
                      creatorUID: uid,
                      groupName : groupName,
                      groupDescription : groupDes,
                      groupImage: '',
                      groupId : '',
                      lastMessage: '',
                      senderUID: '',
                      messageType: MessageType.text,
                      messageId :'',
                      timeSent:  DateTime.now(),
                      createdAt : DateTime.now(),
                      isPrivate: groupValue == GroupType.private ? true : false,
                      editSettings: false,
                      approveMembers: false,
                      lockMessages: false,
                      requestToJoin: false,
                      membersUIDs: [uid],
                      adminsUIDs: [uid],
                      awaitingApprovalUIDs: [],

                    );
                    // add group
                    BlocProvider.of<CreateGroupCubit>(context).createGroup(groupEntity, finalImageFile!);
                    //context.pop();


                  } else {
                    showSnackBar(
                        context: context, message: 'Please fill all fields');
                  }
                },
              ),
            ),
          ),
          ],

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              DisplayUserAvatar(
                finalFileImage: finalImageFile,
                radius: 60,
                onPressed: () {
                  showBottomSheet();
                },
              ),
              const SizedBox(width: 10),
              buildGroupType(),
            ]),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _groupNameController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Group name',
                  hintText: 'Group name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _groupDesController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Des',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            ),

            const SizedBox(
              height: 10,
            ),
            const Text(
              "Select Group Members",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CupertinoSearchTextField(
              placeholder: 'Search',
              onChanged: (value) {
                print(value);
              },
            ),
            Expanded(
              child: FriendsList(
                uid: uid,
                viewType: FriendViewType.group,
              ),
            )
          ]),
        ));
  },
),
);
  }

  Column buildGroupType() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: GroupTypeListTile(
            title: GroupType.private.name,
            value: GroupType.private,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value!;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: GroupTypeListTile(
            title: GroupType.public.name,
            value: GroupType.public,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
