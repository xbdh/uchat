part of 'agora_cubit.dart';

sealed class AgoraState extends Equatable {
  const AgoraState();
}

final class AgoraInitial extends AgoraState {
  @override
  List<Object> get props => [];
}
final class AgoraLocalUserJoined extends AgoraState {
  @override
  List<Object> get props => [];
}
final class AgoraRemoteUserLeft extends AgoraState {
  @override
  List<Object> get props => [];
}
final class AgoraRemoteUserJoined extends AgoraState {
  @override
  List<Object> get props => [];
}
final class AgoraFailed extends AgoraState {
  @override
  List<Object> get props => [];
}
