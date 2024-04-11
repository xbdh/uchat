part of 'credential_cubit.dart';

sealed class CredentialState extends Equatable {
  const CredentialState();
}

final class CredentialInitial extends CredentialState {
  @override
  List<Object> get props => [];
}
class CredentialLoading extends CredentialState {
  @override
  List<Object> get props => [];
}



class CredentialSignupSuccess extends CredentialState {
  String uid;
  CredentialSignupSuccess({required this.uid});
  @override
  List<Object> get props => [];
}

class CredentialLoginSuccess extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialInfoSuccess extends CredentialState {
  @override
  List<Object> get props => [];
}

class CredentialFailure extends CredentialState {
  @override
  List<Object> get props => [];
}
