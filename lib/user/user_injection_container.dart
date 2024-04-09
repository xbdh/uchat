import 'package:uchat/main_injection_container.dart';
import 'package:uchat/user/presentation/cubit/credential/credential_cubit.dart';

import 'data/data_sources/remote/user_remote_data_sources.dart';
import 'data/data_sources/remote/user_remote_data_sources_impl.dart';
import 'data/repositories/use_repositories_impl.dart';
import 'domain/repositories/user_repositories.dart';
import 'domain/use_cases/credential/verify_phone_number_usecase.dart';

Future<void> userInjectionContainer() async {
  // * CUBITS INJECTION


  sl.registerFactory<CredentialCubit>(() =>
      CredentialCubit(
        verifyPhoneNumberUseCase: sl(),
      ));


  // * USE CASES INJECTION


  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
          () => VerifyPhoneNumberUseCase(repository: sl.call()));


  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(remoteDataSource: sl.call()));

  sl.registerLazySingleton<UserRemoteDataSource>(() =>
      UserRemoteDataSourceImpl(
        auth: sl.call(),
        fireStore: sl.call(),
      ));
}
