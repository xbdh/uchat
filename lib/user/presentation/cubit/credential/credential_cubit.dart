import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:uchat/user/domain/use_cases/credential/verify_phone_number_usecase.dart';
import 'package:equatable/equatable.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  CredentialCubit({required this.verifyPhoneNumberUseCase}) : super(CredentialInitial());


  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    try {
      await verifyPhoneNumberUseCase.call(phoneNumber);
      emit(CredentialPhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
