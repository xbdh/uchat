import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uchat/app/constants/firebase_collection.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/data/models/group_model.dart';

import 'package:uchat/chat/data/models/last_message_model.dart';

import 'package:uchat/chat/data/models/message_model.dart';

import 'package:uchat/user/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../main.dart';
import 'message_remote_date_sources.dart';

class MessageRemoteDataSourceImpl extends MessageRemoteDataSource {

  final FirebaseFirestore fireStore;
  final FirebaseStorage storage;

  MessageRemoteDataSourceImpl({required this.fireStore, required this.storage});


  @override
  Stream<List<MessageModel>> getMessageListStream({
    required String senderUID,
    required String recipientUID,
    required String? groupID,
  }){
    if (groupID != null) {
      return fireStore.
          collection(FirebaseCollectionManager.groups).
          doc(groupID).
          collection(FirebaseCollectionManager.messages).
          snapshots().map((snapshot) => snapshot.docs.map((e)=> MessageModel.fromSnapshot(e)).toList()  );
    }

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
    //print('getChatListStream+++++++++++$uid');
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
    required String currentUID,
    required String recipientUID,
    required String messageID})  async {
     // update sender message status as seen
    await  fireStore.
          collection(FirebaseCollectionManager.users).
          doc(currentUID).
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
          doc(currentUID).
          collection(FirebaseCollectionManager.messages).
          doc(messageID).
          update({'isSeen': true});

  }

  @override
  Future<void> setLastMessageStatus({
    required String currentUID,
    required String recipientUID})  async {
   // update sender message status as seen
    await  fireStore.
          collection(FirebaseCollectionManager.users).
          doc(currentUID).
          collection(FirebaseCollectionManager.chats).
          doc(recipientUID).
          update({'isSeen': true});

    // update recipient message status as seen
    await  fireStore.
          collection(FirebaseCollectionManager.users).
          doc(recipientUID).
          collection(FirebaseCollectionManager.chats).
          doc(currentUID).
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

  @override
  Future<void> createGroup(GroupModel groupModel) async {
    await fireStore.collection(FirebaseCollectionManager.groups).
    doc(groupModel.groupId).
    set(groupModel.toMap());

  }

  @override
  Stream<List<GroupModel>> getGroupListStream({required String uid, required isPrivate}) {
    return fireStore.collection(FirebaseCollectionManager.groups).
    where('isPrivate', isEqualTo: isPrivate).
    snapshots().
    map((snapshot) => snapshot.docs.map((e)=> GroupModel.fromSnapshot(e)).toList()  );
  }

  @override
  Future<GroupModel> getSingleGroup(String groupId)  async {
   final group= await fireStore.collection(FirebaseCollectionManager.groups).
    doc(groupId).
    get().then((value) => GroupModel.fromSnapshot(value));
    return group;
  }

  @override
  Future<void> sendGroupLastMessage({
    required String senderUID,
    required String recipientUID,
    required GroupModel groupModel}) async{

    // logger.i('sendGroupe++++++++++++++${groupModel.toMap()}');
    // logger.i('senderUID++++++++++++++${senderUID}');
    // logger.i('recipientUID++++++++++++++${recipientUID}');

    try {
      await fireStore.
      collection(FirebaseCollectionManager.groups).
      doc(recipientUID).
      update({
        'lastMessage': groupModel.lastMessage,
        "senderUID" : groupModel.senderUID,
        "messageType": groupModel.messageType.toShortString(),
        "timeSent": groupModel.timeSent,

      });
    } catch (e) {
      //logger.e('errore++++++++++++++${e}');
      throw e;
    }


  }

  @override
  Future<void> sendGroupMessage({
    required String senderUID,
    required String recipientUID,
    required String messageID,
    required MessageModel messageModel}) async {
    await fireStore.
          collection(FirebaseCollectionManager.groups).
          doc(recipientUID).
          collection(FirebaseCollectionManager.messages).
          doc(messageID).
          set(messageModel.toMap());

  }

  @override
  Future<void> setGroupMessageStatus({required String currentUID, required String recipientUID, required String messageID})async {
    // update sender message status as seen
    await fireStore.
          collection(FirebaseCollectionManager.groups).
          doc(recipientUID).
          collection(FirebaseCollectionManager.messages).
          doc(messageID).
          update({
         'isSeenBy': FieldValue.arrayUnion([currentUID])
          });


  }

  @override
  Stream<int> getGroupUnreadMessageCount({required String uid, required String groupID}) {

    // logger.i('Uid++++++++++++++${uid}');
    // logger.i('getGroupUnreadMessageCount++++++++++++++${groupID}');

    return fireStore.collection(FirebaseCollectionManager.groups).
    doc(groupID).
    collection(FirebaseCollectionManager.messages).
    snapshots().
    asyncMap((event) {
      var count = 0;
      for (var doc in event.docs) {
        final message = MessageModel.fromSnapshot(doc);
        if (!message.isSeenBy.contains(uid)) {
          count++;
        }
      }
      return count;
    });
  }

  @override
  Stream<int> getUnreadMessageCount({required String uid, required String recipientUID}) {
    // logger.i('__Uid++++++++++++++${uid}');
    // logger.i('__getUnreadMessageCount++++++++++++++${recipientUID}');

    try {
      return fireStore.collection(FirebaseCollectionManager.users).
      doc(uid).
      collection(FirebaseCollectionManager.chats).
      doc(recipientUID).
      collection(FirebaseCollectionManager.messages).
          where('isSeen', isEqualTo: false).
          where('senderUID', isNotEqualTo: uid).
      snapshots().
      map((event) {
        //logger.i('event.docs.length++++++++++++++${event.docs.length}');
        return event.docs.length;
      });
    } catch (e) {
      logger.e('error++++++++++++++${e}');
      throw e;
    }

  }

}