part of 'send_text_message_cubit.dart';

sealed class SendTextMessageState extends Equatable {
  const SendTextMessageState();
}

final class SendTextMessageInitial extends SendTextMessageState {
  @override
  List<Object> get props => [];
}
final class SendTextMessageLoading extends SendTextMessageState {
  @override
  List<Object> get props => [];
}

final class SendTextMessageSuccess extends SendTextMessageState {
  @override
  List<Object> get props => [];
}

final class SendTextMessageFailed extends SendTextMessageState {
  @override
  List<Object> get props => [];
}
