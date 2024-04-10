import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:uchat/app/constants/store.dart';
import 'package:uchat/user/data/data_sources/local/user_local_data_sources.dart';
import 'package:uchat/user/data/models/user_model.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;
  const UserLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> savaUserDataToLocal(UserModel user) async {
    String userModelStr=jsonEncode(user.toMap());
    try {
     await sharedPreferences.setString(StoreKeyManager.userModel, userModelStr);
    } catch (e) {
      throw Exception("Error occur while saving user data to shared pref");
    }
  }

  @override
  Future<UserModel?> getUserDataFromLocal() async{
    try {
      String? userModelStr=sharedPreferences.getString(StoreKeyManager.userModel);
      if(userModelStr!=null) {
        Map<String, dynamic> userModelMap=jsonDecode(userModelStr);
        return UserModel.fromMap(userModelMap);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error occur while getting user data from shared pref");
    }
  }





}