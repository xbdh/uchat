part of 'agora_video_cubit.dart';

sealed class AgoraVideoState extends Equatable {
  const AgoraVideoState();
}

final class AgoraVideoInitial extends AgoraVideoState {
  @override
  List<Object> get props => [];
}
final class AgoraVideoLocalJoining extends AgoraVideoState {
  @override
  List<Object> get props => [];
}

final class AgoraVideoLocalJoined extends AgoraVideoState {
  @override
  List<Object> get props => [];
}

final class AgoraVideoRemoteJoined extends AgoraVideoState {
  final int rUid;
  const AgoraVideoRemoteJoined({required this.rUid});
  @override
  List<Object> get props => [rUid];
}

final class AgoraVideoRemoteLeft extends AgoraVideoState {
  @override
  List<Object> get props => [];
}

final class AgoraVideoFailed extends AgoraVideoState {
  @override
  List<Object> get props => [];
}
final class AgoraVideoIsReady extends AgoraVideoState {
  @override
  List<Object> get props => [];
}

