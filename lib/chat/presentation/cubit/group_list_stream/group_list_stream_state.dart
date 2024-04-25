part of 'group_list_stream_cubit.dart';

sealed class GroupListStreamState extends Equatable {
  const GroupListStreamState();
}

final class GroupListStreamInitial extends GroupListStreamState {
  @override
  List<Object> get props => [];
}

final class GroupListStreamLoading extends GroupListStreamState {
  @override
  List<Object> get props => [];
}

final class GroupListStreamLoaded extends GroupListStreamState {
  final List<GroupEntity> groupLists;
  const GroupListStreamLoaded({required this.groupLists});
  @override
  List<Object> get props => [groupLists];
}

final class GroupListStreamFailed extends GroupListStreamState {
  @override
  List<Object> get props => [];
}

