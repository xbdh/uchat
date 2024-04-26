import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uchat/chat/presentation/cubit/message_reply/message_reply_cubit.dart';
import 'package:uchat/chat/presentation/widgets/message_reply_preview_swipe.dart';

import '../../../app/enums/enums.dart';
import '../../../app/utils/methods.dart';
import '../../../main.dart';
import '../../../user/presentation/cubit/my_entity/my_entity_cubit.dart';
import '../../domain/entities/message_reply_entity.dart';
import 'package:uchat/main_injection_container.dart' as di;

import '../cubit/send_message/send_message_cubit.dart';

class ChatMessageBottomField extends StatefulWidget {
  final String friendUid, friendName, friendImage ;
  final String? groupID;

  const ChatMessageBottomField(
      {super.key,
        required this.friendUid,
        required this.friendName,
        required this.friendImage,
        required this.groupID
      });

  @override
  State<ChatMessageBottomField> createState() => _ChatMessageBottomFieldState();
}

class _ChatMessageBottomFieldState extends State<ChatMessageBottomField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late FlutterSoundRecord _soundRecord;
  bool isLoading = false;
  bool isShowSendButton = false;
  File? finalFileImage;
  String filePath = '';
  bool isRecording = false;


  @override
  void initState() {
    _soundRecord = FlutterSoundRecord();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _soundRecord.dispose();
    super.dispose();
  }

  // check microphone permission
  Future<bool> checkMicrophonePermission() async {
    bool hasPermission = await Permission.microphone.isGranted;
    final status = await Permission.microphone.request();
    if (status == PermissionStatus.granted) {
      hasPermission = true;
    } else {
      hasPermission = false;
    }

    return hasPermission;
  }

  // start recording audio
  Future<void> startRecording() async {
    final hasPermission = await checkMicrophonePermission();
    if (hasPermission) {
      var tempDir = await getTemporaryDirectory();
      filePath = '${tempDir.path}/flutter_sound.aac';
      await _soundRecord.start(
        path: filePath,
      );
      setState(() {
        isRecording = true;
      });
    }
  }

  // stop recording audio
  Future<void> stopRecording() async {
    await _soundRecord.stop();
    setState(() {
      isRecording = false;
      //isSendingAudio = true;
    });
    // send audio message to firestore
    // sendFileMessage(
    //   messageType: MessageEnum.audio,
    // );
  }

 Future<void> selectImage(bool fromCamera) async {
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

  //select a video file from device
  Future<void> selectVideo(bool fromCamera) async {
    File? fileVideo = await pickVideo(
      fromCamera: fromCamera,
      context: context,
      onFail: (String message) {
        showSnackBar(context: context, message: message);
      },
    );

    popContext();

    if (fileVideo != null) {
      filePath = fileVideo.path;
      // send video message to firestore
    }
  }

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



  @override
  Widget build(BuildContext context) {
    final myEntity = context
        .watch<MyEntityCubit>()
        .state!;
    final messageReplay = context
        .watch<MessageReplyCubit>()
        .state;

    // logger.i("messageReplay ++$messageReplay");

    return BlocProvider(
  create: (context) => di.sl<SendMessageCubit>(),
  child: BlocConsumer<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageFailed) {
         showSnackBar(context: context, message: "Failed to send message");
        } else if (state is SendMessageSuccess) {
          logger.i("ssssssssssssssssssssssssssssssss");
          setState(() {
            isLoading = false;
           // fileSending = false;
          });
          _textEditingController.clear();
          _focusNode.unfocus();
          BlocProvider.of<MessageReplyCubit>(context).clearMessageReply();

        } else if (state is SendMessageLoading) {
          print("loading+++++++++++++++++");
          setState(() {
            //fileSending= true;
            isLoading = true;
            //isShowSendButton = false;
          });
        }
      },
      builder: (context, state) {

        //print("messageReplay $messageReplay");
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
                    onPressed:  () {
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
                                        onTap: () async {
                                          await selectImage(true);
                                          await BlocProvider.of<SendMessageCubit>(context)
                                              .sendFileMessage(
                                            sender: myEntity,
                                            messageReply: messageReplay,
                                            recipientUID: widget.friendUid,
                                            recipientName: widget.friendName,
                                            recipientImage: widget.friendImage,
                                            file: File(filePath),
                                            messageType: MessageType.image,
                                            groupID: widget.groupID,
                                          );
                                        }),
                                    _attachWindowItem(
                                        icon: Icons.image,
                                        color: Colors.purpleAccent,
                                        title: "Gallery",
                                        onTap: ()async  {
                                          await selectImage(false);
                                          await BlocProvider.of<SendMessageCubit>(context)
                                              .sendFileMessage(
                                            sender: myEntity,
                                            messageReply: messageReplay,
                                            recipientUID: widget.friendUid,
                                            recipientName: widget.friendName,
                                            recipientImage: widget.friendImage,
                                            file: File(filePath),
                                            messageType: MessageType.image,
                                            groupID: widget.groupID,
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
                                        title: "Audio",
                                        onTap: ()  {

                                        }),
                                    _attachWindowItem(
                                        icon: Icons.videocam_rounded,
                                        color: Colors.lightGreen,
                                        title: "Video",
                                        onTap: () async {
                                          await selectVideo(false);
                                          await BlocProvider.of<SendMessageCubit>(context)
                                              .sendFileMessage(
                                            sender: myEntity,
                                            messageReply: messageReplay,
                                            recipientUID: widget.friendUid,
                                            recipientName: widget.friendName,
                                            recipientImage: widget.friendImage,
                                            file: File(filePath),
                                            messageType: MessageType.video,
                                            groupID: widget.groupID,
                                          );

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
                  GestureDetector(
                    onLongPress: (){
                      logger.i("long press");
                      startRecording();
                    },
                    onLongPressUp: (){
                      logger.i("long press up");
                      stopRecording();
                      logger.i("long press up$filePath");
                      filePath==''?null:
                      BlocProvider.of<SendMessageCubit>(context)
                          .sendFileMessage(
                        sender: myEntity,
                        messageReply: messageReplay,
                        recipientUID: widget.friendUid,
                        recipientName: widget.friendName,
                        recipientImage: widget.friendImage,
                        file: File(filePath),
                        messageType: MessageType.audio,
                        groupID: widget.groupID,
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
                      child: const SizedBox(
                        width: 24.0, // 控制大小
                        height: 24.0, // 控制大小
                        child: Icon(Icons.mic, color: Colors.white),

                      ),
                    ),
                  ),

                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        // setState(() {
                        //   isShowSendButton = value.isNotEmpty;
                        // });
                      },
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
                  // isLoading
                  //     ? const Padding(
                  //          padding: EdgeInsets.all(8.0),
                  //           child:CircularProgressIndicator()
                  //   )
                  //     :
                  GestureDetector(
                      onTap: ()  async{
                       // isShowSendButton ?
                        isLoading?null:
                            _textEditingController.text.isNotEmpty?
                         BlocProvider.of<SendMessageCubit>(context)
                            .sendTextMessage(
                          sender: myEntity,
                          messageReply: messageReplay,
                          recipientUID: widget.friendUid,
                          recipientName: widget.friendName,
                          recipientImage: widget.friendImage,
                          message: _textEditingController.text,
                          messageType: MessageType.text,
                          groupID: widget.groupID,
                        ):null;
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

                          child: isLoading
                              ? const SizedBox(
                              width: 24.0, // 控制大小
                              height: 24.0, // 控制大小
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0, // 可以调整这个值来改变加载指示器的粗细
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            )
                              : const SizedBox(
                              width: 24.0, // 确保与CircularProgressIndicator的尺寸相同
                              height: 24.0, // 确保与CircularProgressIndicator的尺寸相同
                              child: Icon(Icons.arrow_upward, color: Colors.white),
                          ),
                          ),
                        ),
                      )
                ],
              ),
            ],
          ),
        );
      },
    ),
);
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
}

