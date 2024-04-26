part of 'get_unread_count_cubit.dart';

sealed class GetUnreadCountState extends Equatable {
  const GetUnreadCountState();
}

final class GetUnreadCountInitial extends GetUnreadCountState {
  @override
  List<Object> get props => [];
}
final class GetUnreadCountLoading extends GetUnreadCountState {
  @override
  List<Object> get props => [];
}

final class GetUnreadCountLoaded extends GetUnreadCountState {
  final int count;
  const GetUnreadCountLoaded({required this.count});
  @override
  List<Object> get props => [count];
}

final class GetUnreadCountFailed extends GetUnreadCountState {
  @override
  List<Object> get props => [];
}

