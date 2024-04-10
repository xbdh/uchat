import 'package:uchat/main_injection_container.dart';
import 'package:uchat/user/data/data_sources/local/user_local_data_sources.dart';
import 'package:uchat/user/domain/use_cases/user/sava_data.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';

import 'data/data_sources/local/user_local_data_sources_impl.dart';
import 'data/data_sources/remote/user_remote_data_sources.dart';
import 'data/data_sources/remote/user_remote_data_sources_impl.dart';
import 'data/repositories/use_repositories_impl.dart';
import 'domain/repositories/user_repositories.dart';
import 'domain/use_cases/auth/login_usecase.dart';
import 'domain/use_cases/auth/signup_usecase.dart';
import 'domain/use_cases/credential/verify_phone_number_usecase.dart';
import 'domain/use_cases/auth/check_user_exists_usecase.dart';

Future<void> userInjectionContainer() async {
  // * CUBITS INJECTION


  sl.registerFactory<CredentialCubit>(() =>
      CredentialCubit(
        verifyPhoneNumberUseCase: sl(),
      ));
  sl.registerFactory<AuthCubit>(() =>
      AuthCubit(
        logInUseCase: sl(),
        signUpUseCase: sl(),
        userCheckExistUseCase: sl(),
      ));

  sl.registerFactory<UserCubit>(() =>
      UserCubit(
        savaDataUseCase: sl(),
        userCheckExistUseCase: sl(),
      ));


  // * USE CASES INJECTION


  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(
          () => VerifyPhoneNumberUseCase(repository: sl.call()));

  sl.registerLazySingleton<LogInUseCase>(
          () => LogInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignUpUseCase>(
          () => SignUpUseCase(repository: sl.call()));

  sl.registerLazySingleton<CheckUserExistsUseCase>(
          () => CheckUserExistsUseCase(repository: sl.call()));
 sl.registerLazySingleton<SavaDataUseCase>(
          () => SavaDataUseCase(userRepository: sl.call()));

  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(
              remoteDataSource: sl.call(),
              localDataSource: sl.call()
            ));


  sl.registerLazySingleton<UserRemoteDataSource>(() =>
      UserRemoteDataSourceImpl(
        auth: sl.call(),
        fireStore: sl.call(),
        storage: sl.call(),
      ));
  sl.registerLazySingleton<UserLocalDataSource>(() =>

      UserLocalDataSourceImpl(
          sharedPreferences: sl.call()
      ));
}
