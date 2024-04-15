import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'uid_state.dart';

class UidCubit extends Cubit<String> {
  UidCubit() : super('');

  void setUid(String uid) => emit(uid);
}
