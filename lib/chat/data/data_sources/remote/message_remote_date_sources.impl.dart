import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uchat/app/constants/firebase_collection.dart';
import 'package:uchat/app/enums/enums.dart';

import 'package:uchat/chat/data/models/last_message_model.dart';

import 'package:uchat/chat/data/models/message_model.dart';

import 'package:uchat/user/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

import 'message_remote_date_sources.dart';

class MessageRemoteDataSourceImpl extends MessageRemoteDataSource {

  final FirebaseFirestore fireStore;
  final FirebaseStorage storage;

  MessageRemoteDataSourceImpl({required this.fireStore, required this.storage});


  @override
  Stream<List<LastMessageModel>> getChatListStream() {
    // TODO: implement getChatListStream
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageModel>> getMessageStream() {
    // TODO: implement getMessageStream
    throw UnimplementedError();
  }

  @override
  Future<void> sendFileMessage(MessageModel message)  async {
    // TODO: implement sendFileMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendTextMessage({
    required UserModel sender,
    required String recipientUID,
    required String recipientName,
    required String recipientImage,
    required String message,
    required MessageType messageType}) async  {

    try {
      var messageID =const Uuid().v4();

    } catch (e) {
      throw e;
    }

  }

  @override
  Future<void> sendLastMessage({
    required String senderUID,
    required String recipientUID,
    required LastMessageModel lastMessageModel}) async {

    await fireStore.
          collection(FirebaseCollectionManager.users).
          doc(senderUID).
          collection(FirebaseCollectionManager.chats).
          doc(recipientUID).set(lastMessageModel.toMap());
  }

  @override
  Future<void> sendMessage({
    required String senderUID,
    required String recipientUID,
    required String messageID,
    required MessageModel messageModel})  async{

    await fireStore.
          collection(FirebaseCollectionManager.users).
          doc(senderUID).
          collection(FirebaseCollectionManager.chats).
          doc(recipientUID).
          collection(FirebaseCollectionManager.messages).
          doc(messageID).
          set(messageModel.toMap());

  }



}