part of 'agora_voice_cubit.dart';

sealed class AgoraVoiceState extends Equatable {
  const AgoraVoiceState();
}

final class AgoraInitial extends AgoraVoiceState {
  @override
  List<Object> get props => [];
}
final class AgoraLocalJoining extends AgoraVoiceState {
  @override
  List<Object> get props => [];
}

final class AgoraLocalJoined extends AgoraVoiceState {
  @override
  List<Object> get props => [];
}

final class AgoraRemoteJoined extends AgoraVoiceState {
  @override
  List<Object> get props => [];
}
final class AgoraRemoteLeave extends AgoraVoiceState {
  @override
  List<Object> get props => [];
}
final class AgoraFailed extends AgoraVoiceState {
  @override
  List<Object> get props => [];
}
