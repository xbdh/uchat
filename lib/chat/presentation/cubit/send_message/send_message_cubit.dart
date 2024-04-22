import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/firebase_collection.dart';
import '../../../../app/enums/enums.dart';
import '../../../../user/domain/entities/user_entity.dart';
import '../../../domain/entities/message_reply_entity.dart';
import '../../../domain/use_cases/send_file_message_usecase.dart';
import '../../../domain/use_cases/send_text_message_usecase.dart';
import '../../../domain/use_cases/store_file_usecase.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendFileMessageUseCase sendFileMessageUseCase;
  StoreFileUseCase storeFileUseCase;
  SendTextMessageUseCase sendTextMessageUseCase;
  SendMessageCubit(
  {
    required this.sendFileMessageUseCase,
    required this.storeFileUseCase,
    required this.sendTextMessageUseCase
}
      ) : super(SendMessageInitial());

  Future<void> sendFileMessage({
    required UserEntity sender,
    required MessageReplyEntity? messageReply,
    required String recipientUID,
    required String recipientName,
    required String recipientImage,
    required File file,
    required MessageType messageType,
  }) async {
    try {
      emit(SendMessageLoading());
      String messageId = const Uuid().v4();

      final ref =
          '${FirebaseStoreManager.chatFiles}/${messageType.toShortString()}/${sender.uid}/$recipientUID/$messageId';
      String fileUrl = await storeFileUseCase.call(file, ref);

      await sendFileMessageUseCase.call(
        sender: sender,
        messageReply: messageReply,
        recipientUID: recipientUID,
        recipientName: recipientName,
        recipientImage: recipientImage,
        message: fileUrl,
        messageType: messageType,
        messageId: messageId,
      );

      emit(SendMessageSuccess());
    } catch (e) {
      emit(SendMessageFailed());
    }
  }
  Future<void> sendTextMessage({
    required UserEntity sender,
    required MessageReplyEntity? messageReply,
    required String recipientUID,
    required String recipientName,
    required String recipientImage,
    required String message,
    required MessageType messageType,
  }) async {

    try {
      emit(SendMessageLoading());
      await sendTextMessageUseCase.call(
        sender: sender,
        messageReply: messageReply,
        recipientUID: recipientUID,
        recipientName: recipientName,
        recipientImage: recipientImage,
        message: message,
        messageType: messageType,
      );
      emit(SendMessageSuccess());
    } catch (e) {
      emit(SendMessageFailed());
    }
  }

}

//如果你的Cubit中包含多种状态（如success、fail和loading），
// 并且你发现只有第一次输入后能成功清除TextField，而后续输入没有触发清除操作，
// 这可能是因为Cubit状态更新的方式导致的。
//
//在Flutter的Bloc或Cubit中，如果连续发出的两个状态对象是相同的（即它们的所有属性值都相等），
// 那么Bloc/Cubit将不会触发状态改变的监听器（BlocListener、BlocBuilder等）。
// 这是因为Bloc/Cubit默认使用状态对象的==操作符来检测状态变化，如果连续两个状态相等，
// 则认为状态没有变化。
//
//考虑到你的状态有success、fail以及loading，如果你在每次发送成功后都仅仅更新状态为success，
// 并且success状态之间没有区别（例如，它们都是简单的Success()状态），
// 那么第一次之后的状态更新将不会被识别为状态变化，因此BlocListener的listener不会被调用来清除TextField。
//
//为了解决这个问题，你可以在发送操作之前将状态设置为loading，
// 然后根据操作的结果设置为success或fail。此外，确保每次状态更新时都创建一个新的状态对象，
// 你还可以为success状态添加额外的信息（如时间戳或唯一ID），确保每次成功状态都是不同的。
//
