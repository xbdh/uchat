part of 'set_message_status_cubit.dart';

sealed class SetMessageStatusState extends Equatable {
  const SetMessageStatusState();
}

final class SetMessageStatusInitial extends SetMessageStatusState {
  @override
  List<Object> get props => [];
}
final class SetMessageStatusSuccess extends SetMessageStatusState {
  @override
  List<Object> get props => [];
}


final class SetMessageStatusFailed extends SetMessageStatusState {
  @override
  List<Object> get props => [];
}

