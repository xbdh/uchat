import 'dart:io';

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
  Stream<List<MessageModel>> getMessageListStream({
    required String senderUID,
    required String recipientUID,}){

    return fireStore.
          collection(FirebaseCollectionManager.users).
          doc(senderUID).
          collection(FirebaseCollectionManager.chats).
          doc(recipientUID).
          collection(FirebaseCollectionManager.messages).
          snapshots().map((snapshot) => snapshot.docs.map((e)=> MessageModel.fromSnapshot(e)).toList()  );

  }

  @override
  Stream<List<LastMessageModel>> getChatListStream({required String uid}){
    print('getChatListStream+++++++++++$uid');
    return fireStore.
          collection(FirebaseCollectionManager.users).
          doc(uid).
          collection(FirebaseCollectionManager.chats).
        //orderBy('timestamp', descending: true).
          snapshots().map((snapshot) => snapshot.docs.map((e)=> LastMessageModel.fromSnapshot(e)).toList()  );
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

  @override
  Future<void> setMessageStatus({
    required String senderUID,
    required String recipientUID,
    required String messageID})  async {
     // update sender message status as seen
    await  fireStore.
          collection(FirebaseCollectionManager.users).
          doc(senderUID).
          collection(FirebaseCollectionManager.chats).
          doc(recipientUID).
          collection(FirebaseCollectionManager.messages).
          doc(messageID).
          update({'isSeen': true});

    // update recipient message status as seen
    await  fireStore.
          collection(FirebaseCollectionManager.users).
          doc(recipientUID).
          collection(FirebaseCollectionManager.chats).
          doc(senderUID).
          collection(FirebaseCollectionManager.messages).
          doc(messageID).
          update({'isSeen': true});

  }

  @override
  Future<void> setLastMessageStatus({
    required String senderUID,
    required String recipientUID})  async {
   // update sender message status as seen
    await  fireStore.
          collection(FirebaseCollectionManager.users).
          doc(senderUID).
          collection(FirebaseCollectionManager.chats).
          doc(recipientUID).
          update({'isSeen': true});

    // update recipient message status as seen
    await  fireStore.
          collection(FirebaseCollectionManager.users).
          doc(recipientUID).
          collection(FirebaseCollectionManager.chats).
          doc(senderUID).
          update({'isSeen': true});
  }

  @override
  Future<String> storeFile({required File file, required String filePath}) async {
    UploadTask task = storage.ref().child(filePath).putFile(file);
    TaskSnapshot snapshot = await task.whenComplete(() => null);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    //copilot kengwo
    return downloadUrl;
  }



}