import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uchat/chat/presentation/cubit/message_reply/message_reply_cubit.dart';
import 'package:uchat/chat/presentation/cubit/send_file_message/send_file_message_cubit.dart';
import 'package:uchat/chat/presentation/cubit/send_text_message/send_text_message_cubit.dart';
import 'package:uchat/chat/presentation/widgets/message_reply_preview_swipe.dart';
import 'package:uchat/main.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

import '../../../app/enums/enums.dart';
import '../../../app/utils/methods.dart';
import '../../../user/presentation/cubit/my_entity/my_entity_cubit.dart';
import '../../domain/entities/message_reply_entity.dart';
import 'package:uchat/main_injection_container.dart' as di;

class ChatMessageBottomField extends StatefulWidget {
  final String friendUid, friendName, friendImage;

  const ChatMessageBottomField(
      {super.key, required this.friendUid, required this.friendName, required this.friendImage});

  @override
  State<ChatMessageBottomField> createState() => _ChatMessageBottomFieldState();
}

class _ChatMessageBottomFieldState extends State<ChatMessageBottomField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  bool sending = false;
  File? finalFileImage;
  String filePath = '';

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void selectImage(bool fromCamera) async {
    finalFileImage = await pickImage(
      context: context  ,
      fromCamera: fromCamera,
      onFail: (String message) {
        showSnackBar(context: context, message: message);
      },
    );

    // crop image
    await cropImage(finalFileImage?.path);

    popContext();
  }

  // select a video file from device
  // void selectVideo(bool fromCamera) async {
  //   File? fileVideo = await pickVideo(
  //     fromCamera: fromCamera,
  //     context: context,
  //     onFail: (String message) {
  //       showSnackBar(context: context, message: message);
  //     },
  //   );
  //
  //   popContext();
  //
  //   if (fileVideo != null) {
  //     filePath = fileVideo.path;
  //     // send video message to firestore
  //     sendFileMessage(
  //       messageType: MessageType.video,
  //     );
  //   }
  // }

  popContext() {
    Navigator.pop(context);
  }

  Future<void> cropImage(croppedFilePath) async {
    if (croppedFilePath != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: croppedFilePath,
        maxHeight: 800,
        maxWidth: 800,
        compressQuality: 90,
      );

      if (croppedFile != null) {
        filePath = croppedFile.path;
        // send image message to firestore
        // sendFileMessage(
        //   messageType: MessageType.image,
        // );
      }
    }
  }

  // send image message to firestore
  void sendFileMessage({
    required MessageType messageType,
    //required UserEntity sender,
    //required MessageReplyEntity? messageReply,
  }) {
    final myEntity = context
        .watch<MyEntityCubit>()
        .state!;
    final messageReply = context
        .watch<MessageReplyCubit>()
        .state;

    BlocProvider.of<SendFileMessageCubit>(context)
        .sendFileMessage(
      sender: myEntity,
      messageReply: messageReply,
      recipientUID: widget.friendUid,
      recipientName: widget.friendName,
      recipientImage: widget.friendImage,
      file: finalFileImage!,
      messageType: MessageType.image,
    );
  }

  @override
  Widget build(BuildContext context) {
    final myEntity = context
        .watch<MyEntityCubit>()
        .state!;
    final messageReplay = context
        .watch<MessageReplyCubit>()
        .state;

    return BlocProvider(
      create: (context) => di.sl<SendTextMessageCubit>(),
      child: BlocConsumer<SendTextMessageCubit, SendTextMessageState>(
        listener: (context, state) {
          if (state is SendTextMessageFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to send message"),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is SendTextMessageSuccess) {
            //logger.i("ssssssssssssssssssssssssssssssss");
            _textEditingController.clear();
            _focusNode.unfocus();
            BlocProvider.of<MessageReplyCubit>(context).clearMessageReply();
            setState(() {
              sending = false;
            });
          } else if (state is SendTextMessageLoading) {
            setState(() {
              sending = true;
            });
          }
        },
        builder: (context, state) {
          final isMessageReply = messageReplay != null;
          return Container(
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .cardColor,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
            ),
            child: Column(
              children: [
                isMessageReply
                    ?MessageReplyPreviewSwipe(messageReplyEntity: messageReplay)
                    :const SizedBox.shrink(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              height: 250,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 20),
                              decoration: BoxDecoration(
                                //color: bottomAttachContainerColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      _attachWindowItem(
                                        icon: Icons.document_scanner,
                                        color: Colors.deepPurpleAccent,
                                        title: "File",
                                      ),
                                      _attachWindowItem(
                                          icon: Icons.camera_alt,
                                          color: Colors.pinkAccent,
                                          title: "Camera",
                                          onTap: () {
                                            selectImage(true);
                                            // sendFileMessage(
                                            //     messageType: MessageType.image,
                                            //     // sender: myEntity,
                                            //     // messageReply: messageReplay,
                                            // );
                                          }),
                                      _attachWindowItem(
                                          icon: Icons.image,
                                          color: Colors.purpleAccent,
                                          title: "Gallery",
                                          onTap: () {
                                            selectImage(false);
                                            BlocProvider.of<SendFileMessageCubit>(context)
                                                .sendFileMessage(
                                              sender: myEntity,
                                              messageReply: messageReplay,
                                              recipientUID: widget.friendUid,
                                              recipientName: widget.friendName,
                                              recipientImage: widget.friendImage,
                                              file: File(filePath),
                                              messageType: MessageType.image,
                                            );
                                          }),

                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      _attachWindowItem(icon: Icons.headphones,
                                          color: Colors.deepOrange,
                                          title: "Audio"),
                                      _attachWindowItem(
                                          icon: Icons.videocam_rounded,
                                          color: Colors.lightGreen,
                                          title: "Video",
                                          onTap: () {
                                            //selectVideo(false);
                                          }),
                                      _attachWindowItem(
                                          icon: Icons.gif_box_outlined,
                                          color: Colors.indigoAccent,
                                          title: "Gif",
                                          onTap: () {
                                            //_sendGifMessage();
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.attachment),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        focusNode: _focusNode,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          sending ? null :
                          BlocProvider.of<SendTextMessageCubit>(context)
                              .sendTextMessage(
                            sender: myEntity,
                            messageReply: messageReplay,
                            recipientUID: widget.friendUid,
                            recipientName: widget.friendName,
                            recipientImage: widget.friendImage,
                            message: _textEditingController.text,
                            messageType: MessageType.text,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: const EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: sending
                                ? SizedBox(
                              width: 24.0, // 控制大小
                              height: 24.0, // 控制大小
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0, // 可以调整这个值来改变加载指示器的粗细
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            )
                                : SizedBox(
                              width: 24.0, // 确保与CircularProgressIndicator的尺寸相同
                              height: 24.0, // 确保与CircularProgressIndicator的尺寸相同
                              child: Icon(Icons.arrow_upward, color: Colors.white),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

_attachWindowItem(
    {IconData? icon, Color? color, String? title, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40), color: color),
          child: Icon(icon),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "$title",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}