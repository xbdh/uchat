import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/user/user_injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'chat/chat_injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final messaging = FirebaseMessaging.instance;
  final sharedPreferences = await SharedPreferences.getInstance();
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.10.7:8080/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );


  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => storage);
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => messaging);

  await userInjectionContainer();
  await chatInjectionContainer();
  // await statusInjectionContainer();
  // await callInjectionContainer();

}