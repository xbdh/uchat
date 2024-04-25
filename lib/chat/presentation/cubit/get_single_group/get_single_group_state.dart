part of 'get_single_group_cubit.dart';

sealed class GetSingleGroupState extends Equatable {
  const GetSingleGroupState();
}

final class GetSingleGroupInitial extends GetSingleGroupState {
  @override
  List<Object> get props => [];
}
final class GetSingleGroupLoading extends GetSingleGroupState {
  @override
  List<Object> get props => [];
}
final class GetSingleGroupLoaded extends GetSingleGroupState {
  final GroupEntity group;
  const GetSingleGroupLoaded({required this.group});
  @override
  List<Object> get props => [
    group
  ];
}

final class GetSingleGroupFailed extends GetSingleGroupState {
  @override
  List<Object> get props => [];
}

