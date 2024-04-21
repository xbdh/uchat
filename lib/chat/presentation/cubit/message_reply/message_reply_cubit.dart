import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uchat/chat/domain/entities/message_reply_entity.dart';

part 'message_reply_state.dart';

class MessageReplyCubit extends Cubit<MessageReplyEntity?> {
  MessageReplyCubit() : super(null);

  void setMessageReply(MessageReplyEntity reply) => emit(reply);
  void clearMessageReply() => emit(null);
}
