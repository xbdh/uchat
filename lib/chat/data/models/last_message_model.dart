

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/app/enums/enums.dart';
import 'package:uchat/chat/domain/entities/last_message_entity.dart';

class LastMessageModel  extends Equatable {
  String senderUID;
  String recipientUID;
  String recipientName;
  String recipientImage;
  String message;
  MessageType messageType;
  DateTime timeSent;
  bool isSeen;

  LastMessageModel({
    required this.senderUID,
    required this.recipientUID,
    required this.recipientName,
    required this.recipientImage,
    required this.message,
    required this.messageType,
    required this.timeSent,
    required this.isSeen,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    senderUID,
    recipientUID,
    recipientName,
    recipientImage,
    message,
    messageType,
    timeSent,
    isSeen,
  ];

  factory LastMessageModel.fromSnapshot(DocumentSnapshot snapshot){
    final snap = snapshot.data() as Map<String, dynamic>;

    return LastMessageModel(
      senderUID: snap['senderUID'],
      recipientUID: snap['recipientUID'],
      recipientName: snap['recipientName'],
      recipientImage: snap['recipientImage'],
      message: snap['message'],
      messageType: MessageTypeExtension.fromString(snap['messageType']),
      timeSent: snap['timeSent'].toDate(),
      isSeen: snap['isSeen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderUID': senderUID,
      'recipientUID': recipientUID,
      'recipientName': recipientName,
      'recipientImage': recipientImage,
      'message': message,
      'messageType': messageType.toShortString(),
      'timeSent': timeSent,
      'isSeen': isSeen,
    };
  }
  factory LastMessageModel.fromMap(Map<String, dynamic> map){
    return LastMessageModel(
      senderUID: map['senderUID'],
      recipientUID: map['recipientUID'],
      recipientName: map['recipientName'],
      recipientImage: map['recipientImage'],
      message: map['message'],
      messageType: MessageTypeExtension.fromString(map['messageType']),
      timeSent: map['timeSent'].toDate(),
      isSeen: map['isSeen'],
    );
  }

  factory LastMessageModel.fromLastMessageEntity(LastMessageEntity lastMessageEntity){
    return LastMessageModel(
      senderUID: lastMessageEntity.senderUID,
      recipientUID: lastMessageEntity.recipientUID,
      recipientName: lastMessageEntity.recipientName,
      recipientImage: lastMessageEntity.recipientImage,
      message: lastMessageEntity.message,
      messageType: lastMessageEntity.messageType,
      timeSent: lastMessageEntity.timeSent,
      isSeen: lastMessageEntity.isSeen,
    );
  }

}