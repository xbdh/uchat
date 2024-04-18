import 'package:uchat/chat/presentation/cubit/message_reply/message_reply_cubit.dart';
import 'package:uchat/chat/presentation/cubit/send_text_message/send_text_message_cubit.dart';
import 'package:uchat/main_injection_container.dart';


import 'data/data_sources/remote/message_remote_date_sources.dart';
import 'data/data_sources/remote/message_remote_date_sources.impl.dart';
import 'data/repositories/message_repositories_impl.dart';
import 'domain/repositories/message_repositories.dart';
import 'domain/use_cases/send_text_message_usecase.dart';



Future<void> chatInjectionContainer() async {
  // * CUBITS INJECTION


  sl.registerFactory<MessageReplyCubit>(() =>
      MessageReplyCubit(


      ));
  sl.registerFactory<  SendTextMessageCubit>(() =>
      SendTextMessageCubit(
        sendTextMessageUseCase: sl.call(),

      ));





  // * USE CASES INJECTION



  sl.registerLazySingleton<SendTextMessageUseCase>(
          () => SendTextMessageUseCase(repository: sl.call()));




  // * REPOSITORY & DATA SOURCES INJECTION

  sl.registerLazySingleton<MessageRepository>(
          () => MessageRepositoryImpl(
                messageDataSource: sl.call()
            ));


  sl.registerLazySingleton<MessageRemoteDataSource>(() =>
      MessageRemoteDataSourceImpl(
        fireStore: sl.call(),
        storage: sl.call(),
      ));
  // sl.registerLazySingleton<UserLocalDataSource>(() =>
  //
  //     UserLocalDataSourceImpl(
  //         sharedPreferences: sl.call()
  //     ));
}
