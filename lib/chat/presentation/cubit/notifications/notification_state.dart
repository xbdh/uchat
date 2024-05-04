part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}
final class NotificationLoading extends NotificationState {
  @override
  List<Object> get props => [];
}
final class NotificationSuccess extends NotificationState {
  @override
  List<Object> get props => [];
}
final class NotificationFailed extends NotificationState {
  @override
  List<Object> get props => [];
}

final class NotificationReceiveSuccess extends NotificationState {
  final String friendUid;
  final String friendName;
  final String friendImage;
  final String callType;
   NotificationReceiveSuccess({
    required this.friendUid,
    required this.friendName,
    required this.friendImage,
    required this.callType,
  });
  @override
  List<Object> get props => [
    friendUid,
    friendName,
    friendImage,
    callType,
  ];
}
