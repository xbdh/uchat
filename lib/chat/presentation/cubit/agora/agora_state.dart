part of 'agora_cubit.dart';

sealed class AgoraState extends Equatable {
  const AgoraState();
}

final class AgoraInitial extends AgoraState {
  @override
  List<Object> get props => [];
}
final class AgoraLocalJoining extends AgoraState {
  @override
  List<Object> get props => [];
}

final class AgoraLocalJoined extends AgoraState {
  @override
  List<Object> get props => [];
}

final class AgoraRemoteJoined extends AgoraState {
  @override
  List<Object> get props => [];
}
final class AgoraRemoteLeave extends AgoraState {
  @override
  List<Object> get props => [];
}
final class AgoraFailed extends AgoraState {
  @override
  List<Object> get props => [];
}
