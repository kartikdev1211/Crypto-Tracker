import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme);
    return result;
  }

  static Future<String?> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currentTheme = sharedPreferences.getString("theme");
    return currentTheme;
  }

  static Future<bool> addFavourite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> fav = sharedPreferences.getStringList("favourites") ?? [];
    fav.add(id);
    return await sharedPreferences.setStringList("favourites", fav);
  }

  static Future<bool> removeFavourite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> fav = sharedPreferences.getStringList("favourites") ?? [];
    fav.remove(id);
    return await sharedPreferences.setStringList("favourites", fav);
  }

  static Future<List<String>> fetchFavourite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("favourites") ?? [];
  }
}
