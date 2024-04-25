part of 'create_group_cubit.dart';

sealed class CreateGroupState extends Equatable {
  const CreateGroupState();
}

final class CreateGroupInitial extends CreateGroupState {
  @override
  List<Object> get props => [];
}
final class CreateGroupLoading extends CreateGroupState {
  @override
  List<Object> get props => [];
}
final class CreateGroupSuccess extends CreateGroupState {
  @override
  List<Object> get props => [];
}
final class CreateGroupFailed extends CreateGroupState {
  @override
  List<Object> get props => [];
}


