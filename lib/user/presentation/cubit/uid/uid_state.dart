part of 'uid_cubit.dart';

sealed class UidState extends Equatable {
  const UidState();
}

final class UidInitial extends UidState {
  @override
  List<Object> get props => [];
}
