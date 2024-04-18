part of 'message_reply_cubit.dart';

sealed class MessageReplyState extends Equatable {
  const MessageReplyState();
}

final class MessageReplyInitial extends MessageReplyState {
  @override
  List<Object> get props => [];
}
