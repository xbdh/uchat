part of 'my_entity_cubit.dart';

sealed class MyEntityState extends Equatable {
  const MyEntityState();
}

final class MyEntityInitial extends MyEntityState {
  @override
  List<Object> get props => [];
}
