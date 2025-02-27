import 'package:shared_preferences/shared_preferences.dart';

class CachedData {
  static late SharedPreferences sharedPreferences;
  CachedData._();
  static cacheInitialization() async {
    sharedPreferences =
        await SharedPreferences.getInstance(); //initialize the shared preferences in a variable
  }

  //set any type of Data
  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    } else if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    } else {
      //only if the data is not saved
      return false;
    }
  }

  //get any type of Data
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key); //can get any type of data
  }

  //delete item
  static void deleteItem({required String key}) {
    sharedPreferences.remove(key);
  }

  //clear cache
  static void clearData() {
    sharedPreferences.clear();
  }
}
