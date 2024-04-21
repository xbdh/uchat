import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/firebase_collection.dart';
import '../../../../app/enums/enums.dart';
import '../../../../user/domain/entities/user_entity.dart';
import '../../../domain/entities/message_reply_entity.dart';
import '../../../domain/use_cases/send_file_message_usecase.dart';
import '../../../domain/use_cases/store_file_usecase.dart';

part 'send_file_message_state.dart';

class SendFileMessageCubit extends Cubit<SendFileMessageState> {
  SendFileMessageUseCase sendFileMessageUseCase;
  StoreFileUseCase storeFileUseCase;

  SendFileMessageCubit({
    required this.sendFileMessageUseCase
  , required this.storeFileUseCase
  }) : super(SendFileMessageInitial());

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
      emit(SendFileMessageLoading());
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

      emit(SendFileMessageSuccess());
    } catch (e) {
      emit(SendFileMessageFailed());
    }
  }
}
//如果你的Cubit中包含多种状态（如success、fail和loading），
