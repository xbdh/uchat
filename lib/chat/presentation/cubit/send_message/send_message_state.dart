part of 'send_message_cubit.dart';

sealed class SendMessageState extends Equatable {
  const SendMessageState();
}

final class SendMessageInitial extends SendMessageState {
  @override
  List<Object> get props => [];
}

final class SendMessageLoading extends SendMessageState {
  @override
  List<Object> get props => [];
}
final class SendMessageSuccess extends SendMessageState {
  @override
  List<Object> get props => [];
}
final class SendMessageFailed extends SendMessageState {
  @override
  List<Object> get props => [];
}