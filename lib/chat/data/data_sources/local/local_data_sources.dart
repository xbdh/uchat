abstract class  LocalDataSource {


  Future<bool> setString(String key, String value) ;
  Future<bool> setBool(String key, bool value) ;
  Future<bool> setList(String key, List<String> value);
  String getString(String key) ;
  bool getBool(String key);
  List<String> getList(String key);
  Future<bool> remove(String key) ;
}