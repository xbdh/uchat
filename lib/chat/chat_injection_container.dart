import 'package:uchat/chat/presentation/cubit/chat_list_steam/chat_list_stream_cubit.dart';
import 'package:uchat/chat/presentation/cubit/chat_message_list_steam/chat_message_list_stream_cubit.dart';
import 'package:uchat/chat/presentation/cubit/create_group/create_group_cubit.dart';
import 'package:uchat/chat/presentation/cubit/get_single_group/get_single_group_cubit.dart';
import 'package:uchat/chat/presentation/cubit/group_list_stream/group_list_stream_cubit.dart';
import 'package:uchat/chat/presentation/cubit/message_reply/message_reply_cubit.dart';
import 'package:uchat/chat/presentation/cubit/send_message/send_message_cubit.dart';
import 'package:uchat/chat/presentation/cubit/set_message_status/set_message_status_cubit.dart';
import 'package:uchat/main_injection_container.dart';


import 'data/data_sources/remote/message_remote_date_sources.dart';
import 'data/data_sources/remote/message_remote_date_sources.impl.dart';
import 'data/repositories/message_repositories_impl.dart';
import 'domain/repositories/message_repositories.dart';
import 'domain/use_cases/create_group_usecase.dart';
import 'domain/use_cases/get_chat_list_stream_usecase.dart';
import 'domain/use_cases/get_chat_message_list_stream_usecase.dart';
import 'domain/use_cases/get_group_list_stream_usecase.dart';
import 'domain/use_cases/get_single_group_usecase.dart';
import 'domain/use_cases/send_file_message_usecase.dart';
import 'domain/use_cases/send_text_message_usecase.dart';
import 'domain/use_cases/store_file_usecase.dart';
import 'domain/use_cases/update_last_message_status_usecase.dart';
import 'domain/use_cases/update_message_status_usecase.dart';



Future<void> chatInjectionContainer() async {
  // * CUBITS INJECTION


  sl.registerFactory<MessageReplyCubit>(() =>
      MessageReplyCubit(


      ));

  sl.registerFactory<ChatMessageListStreamCubit>(() =>
      ChatMessageListStreamCubit(
        getChatMessageListStreamUseCase: sl.call(),

      ));
  sl.registerFactory<ChatListStreamCubit>(() =>
      ChatListStreamCubit(
        getChatListStreamUseCase: sl.call(),

      ));

  sl.registerFactory<SetMessageStatusCubit>(() =>
      SetMessageStatusCubit(
        updateMessageStatusUseCase: sl.call(),
        updateLastMessageStatusUseCase: sl.call(),

      ));

  // sl.registerFactory<SendFileMessageCubit>(() =>
  //     SendFileMessageCubit(
  //         sendFileMessageUseCase: sl.call(),
  //         storeFileUseCase: sl.call()
  //
  //     ));
  // sl.registerFactory<SendTextMessageCubit>(() =>
  //     SendTextMessageCubit(
  //       sendTextMessageUseCase: sl.call(),
  //
  //     ));

  sl.registerFactory<SendMessageCubit>(() =>
      SendMessageCubit(
          sendFileMessageUseCase: sl.call(),
          storeFileUseCase: sl.call(),
        sendTextMessageUseCase: sl.call(),


      ));


  sl.registerFactory<CreateGroupCubit>(() =>
      CreateGroupCubit(
        storeFileUseCase: sl.call(),

        createGroupUseCase: sl.call(),

      ));


  sl.registerFactory< GroupListStreamCubit>(() =>
      GroupListStreamCubit(
        getGroupListStreamUseCase: sl.call(),

      ));
  sl.registerFactory<GetSingleGroupCubit>(() =>
      GetSingleGroupCubit(
        getSingleGroupUseCase: sl.call(),

      ));


  // * USE CASES INJECTION



  sl.registerLazySingleton<SendTextMessageUseCase>(
          () => SendTextMessageUseCase(repository: sl.call()));


  sl.registerLazySingleton<GetChatListStreamUseCase>(
          () => GetChatListStreamUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetChatMessageListStreamUseCase>(
          () => GetChatMessageListStreamUseCase(repository: sl.call()));

  sl.registerLazySingleton<UpdateMessageStatusUseCase>(
          () => UpdateMessageStatusUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateLastMessageStatusUseCase>(
          () => UpdateLastMessageStatusUseCase(repository: sl.call()));

  sl.registerLazySingleton<SendFileMessageUseCase>(
          () => SendFileMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<StoreFileUseCase>(
          () => StoreFileUseCase(repository: sl.call()));

  sl.registerLazySingleton<CreateGroupUseCase>(
          () => CreateGroupUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetGroupListStreamUseCase>(
          () => GetGroupListStreamUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetSingleGroupUseCase>(
          () => GetSingleGroupUseCase(repository: sl.call()));


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
