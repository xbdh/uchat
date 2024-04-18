import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uchat/user/domain/entities/user_entity.dart';

part 'my_entity_state.dart';

class MyEntityCubit extends Cubit<UserEntity?> {
  MyEntityCubit() : super(null);
  void setUser(UserEntity user) {
    emit(user);
  }
}
