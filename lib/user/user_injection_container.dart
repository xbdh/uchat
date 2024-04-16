import 'package:uchat/main_injection_container.dart';
import 'package:uchat/user/data/data_sources/local/user_local_data_sources.dart';
import 'package:uchat/user/domain/use_cases/credential/is_signin_usecase.dart';
import 'package:uchat/user/domain/use_cases/credential/signout_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/get_all_user_usecase.dart';
import 'package:uchat/user/domain/use_cases/user/save_data.dart';
import 'package:uchat/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:uchat/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:uchat/user/presentation/cubit/friend_request/friend_request_cubit.dart';
import 'package:uchat/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';


import 'package:uchat/user/presentation/cubit/uid/uid_cubit.dart';
import 'package:uchat/user/presentation/cubit/user/user_cubit.dart';

import 'data/data_sources/local/user_local_data_sources_impl.dart';
import 'data/data_sources/remote/user_remote_data_sources.dart';
import 'data/data_sources/remote/user_remote_data_sources_impl.dart';
import 'data/repositories/use_repositories_impl.dart';
import 'domain/repositories/user_repositories.dart';
import 'domain/use_cases/credential/get_current_uid.dart';
import 'domain/use_cases/credential/login_usecase.dart';
import 'domain/use_cases/credential/signup_usecase.dart';
import 'domain/use_cases/credential/check_user_exists_usecase.dart';
import 'domain/use_cases/friend/accept_friend_request_usecase.dart';
import 'domain/use_cases/friend/cancle_friend_request_usecase.dart';
import 'domain/use_cases/friend/get_friend_list_usecase.dart';
import 'domain/use_cases/friend/get_friend_requests_list_usecase.dart';
import 'domain/use_cases/friend/remove_friend_usecase.dart';
import 'domain/use_cases/friend/send_friend_request_usecase.dart';
import 'domain/use_cases/user/get_data_local_usecase.dart';
import 'domain/use_cases/user/get_data_remote_usecase.dart';
import 'domain/use_cases/user/get_single_user_usecase.dart';
import 'domain/use_cases/user/save_data_local_usecase.dart';

Future<void> userInjectionContainer() async {
  // * CUBITS INJECTION


  sl.registerFactory<CredentialCubit>(() =>
      CredentialCubit(

        logInUseCase: sl(),
        signUpUseCase: sl(),
        saveUserUseCase: sl(),

      ));
  sl.registerFactory<AuthCubit>(() =>
      AuthCubit(
        getCurrentUidUseCase: sl(),
        isSignInUseCase: sl(),
        signOutUseCase: sl(),
        saveDataLocalUseCase: sl(),
        getDataRemoteUseCase: sl(),
      ));

  sl.registerFactory<UserCubit>(() =>
      UserCubit(
        savaDataUseCase: sl(),
        userCheckExistUseCase: sl(),
        getDataLocalUseCase: sl(),
        getAllUsersUseCase: sl(),
      ));


  sl.registerFactory<UidCubit>(() =>
      UidCubit(
      ));
  sl.registerFactory(() =>
      FriendRequestCubit(
          acceptFriendRequestUseCase: sl(),
          cancleFriendRequestUseCase: sl(),
          getFriendRequestListUseCase: sl(),
          getFriendListUseCase: sl(),
          sendFriendRequestUseCase: sl(),
          removeFriendUseCase:  sl(),
      ));

  sl.registerFactory(() =>
      GetSingleUserCubit(
          getSingleUserUseCase: sl(),
      ));



  // * USE CASES INJECTION



  sl.registerLazySingleton<LogInUseCase>(
          () => LogInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignUpUseCase>(
          () => SignUpUseCase(repository: sl.call()));

  sl.registerLazySingleton<CheckUserExistsUseCase>(
          () => CheckUserExistsUseCase(repository: sl.call()));

 sl.registerLazySingleton<SavaDataUseCase>(
          () => SavaDataUseCase(userRepository: sl.call()));

  sl.registerLazySingleton<GetCurrentUidUseCase>(
          () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
          () => SignOutUseCase(repository: sl.call()));


  sl.registerLazySingleton<IsSignInUseCase>(
          () => IsSignInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SaveDataLocalUseCase >(

          () => SaveDataLocalUseCase(userRepository: sl.call()));
  sl.registerLazySingleton<GetDataRemoteUseCase>(
          () => GetDataRemoteUseCase(userRepository: sl.call()));
// GetDataLocalUseCase
  sl.registerLazySingleton<GetDataLocalUseCase>(
          () => GetDataLocalUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetSingleUserUseCase>(
          () => GetSingleUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetAllUsersUseCase>(
          () => GetAllUsersUseCase(repository: sl.call()));


  sl.registerLazySingleton<AcceptFriendRequestUseCase>(
          () => AcceptFriendRequestUseCase(repository: sl.call()));
  sl.registerLazySingleton<CancleFriendRequestUseCase>(
          () => CancleFriendRequestUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetFriendRequestListUseCase>(
          () => GetFriendRequestListUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetFriendListUseCase>(
          () => GetFriendListUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendFriendRequestUseCase>(
          () => SendFriendRequestUseCase(repository: sl.call()));
  sl.registerLazySingleton<RemoveFriendUseCase>(
          () => RemoveFriendUseCase(repository: sl.call()));


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
