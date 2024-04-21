part of 'chat_list_stream_cubit.dart';

sealed class ChatListStreamState extends Equatable {
  const ChatListStreamState();
}

final class ChatListStreamInitial extends ChatListStreamState {
  @override
  List<Object> get props => [];
}

final class ChatListStreamLoading extends ChatListStreamState {
  @override
  List<Object> get props => [];
}

final class ChatListStreamLoaded extends ChatListStreamState {
  List<LastMessageEntity> chatLists;
  ChatListStreamLoaded({required this.chatLists});
  @override
  List<Object> get props => [chatLists];
}

final class ChatListStreamFailed extends ChatListStreamState {
  @override
  List<Object> get props => [];
}