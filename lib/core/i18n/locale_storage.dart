import 'package:shared_preferences/shared_preferences.dart';

const _localeKey = 'app_locale';

/// Persists the user's manually-chosen language across launches, so a saved
/// choice takes priority over the device locale next time the app starts.
class LocaleStorage {
  const LocaleStorage();

  Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey);
  }

  Future<void> write(String localeCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, localeCode);
  }
}
