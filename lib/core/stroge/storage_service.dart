import 'package:alpha_club/core/stroge/stroge_key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alpha_club/core/service/logger/app_logger.dart';

class LocalStorage {
  static String token = "";
  static String refreshToken = "";
  static bool isLogIn = false;
  static String userId = "";
  static String myImage = "";
  static String myName = "";
  static String myEmail = "";
  static String myRoll = "";

  // Create Local Storage Instance
  static SharedPreferences? preferences;

  /// Get SharedPreferences Instance
  static Future<SharedPreferences> _getStorage() async {
    try {
      preferences ??= await SharedPreferences.getInstance();
      return preferences!;
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get SharedPreferences instance',
        tag: 'STORAGE',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  /// Get All Data From SharedPreferences
  static Future<void> getAllPrefData() async {
    try {
      final localStorage = await _getStorage();
      token = localStorage.getString(LocalStorageKeys.token) ?? "";
      AppLogger.debug('Loaded token from storage', tag: 'STORAGE');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to get all preference data',
        tag: 'STORAGE',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Remove All Data From SharedPreferences
  static Future<void> removeAllPrefData() async {
    try {
      final localStorage = await _getStorage();
      await localStorage.clear();
      _resetLocalStorageData();
      await getAllPrefData();
      AppLogger.info('All preference data cleared', tag: 'STORAGE');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to remove all preference data',
        tag: 'STORAGE',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  // Reset LocalStorage Data
  static void _resetLocalStorageData() {
    try {
      final localStorage = preferences!;
      localStorage.setString(LocalStorageKeys.token, "");
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to reset local storage data',
        tag: 'STORAGE',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  // Save Data To SharedPreferences
  static Future<void> setString(String key, String value) async {
    try {
      final localStorage = await _getStorage();
      await localStorage.setString(key, value);
      AppLogger.debug('Saved $key to storage', tag: 'STORAGE');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to set string: $key',
        tag: 'STORAGE',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<void> setBool(String key, bool value) async {
    try {
      final localStorage = await _getStorage();
      await localStorage.setBool(key, value);
      AppLogger.debug('Saved $key to storage', tag: 'STORAGE');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to set bool: $key',
        tag: 'STORAGE',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<void> setInt(String key, int value) async {
    try {
      final localStorage = await _getStorage();
      await localStorage.setInt(key, value);
      AppLogger.debug('Saved $key to storage', tag: 'STORAGE');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to set int: $key',
        tag: 'STORAGE',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}