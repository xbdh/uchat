part of 'chat_message_list_stream_cubit.dart';

sealed class ChatMessageListStreamState extends Equatable {
  const ChatMessageListStreamState();
}

final class ChatMessageListStreamInitial extends ChatMessageListStreamState {
  @override
  List<Object> get props => [];
}

final class ChatMessageListStreamLoading extends ChatMessageListStreamState {
  @override
  List<Object> get props => [];
}
final class ChatMessageListStreamLoaded extends ChatMessageListStreamState {
  List<MessageEntity> messageLists;
  ChatMessageListStreamLoaded({required this.messageLists});
  @override
  List<Object> get props => [messageLists];
}
final class ChatMessageListStreamFailed extends ChatMessageListStreamState {
  @override
  List<Object> get props => [];
}