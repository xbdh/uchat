part of 'send_file_message_cubit.dart';

sealed class SendFileMessageState extends Equatable {
  const SendFileMessageState();
}

final class SendFileMessageInitial extends SendFileMessageState {
  @override
  List<Object> get props => [];
}

final class SendFileMessageLoading extends SendFileMessageState {
  @override
  List<Object> get props => [];
}
final class SendFileMessageSuccess extends SendFileMessageState {
  @override
  List<Object> get props => [];
}

final class SendFileMessageFailed extends SendFileMessageState {
  @override
  List<Object> get props => [];
}
