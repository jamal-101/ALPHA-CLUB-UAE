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
  static bool _isInitialized = false;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      preferences = await SharedPreferences.getInstance();
      _isInitialized = true;
      AppLogger.info('SharedPreferences initialized successfully', tag: 'STORAGE');
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to initialize SharedPreferences, using in-memory storage',
        tag: 'STORAGE',
        error: e,
        stackTrace: stackTrace,
      );
      _isInitialized = false;
    }
  }

  /// Get SharedPreferences Instance
  static Future<SharedPreferences?> _getStorage() async {
    if (!_isInitialized) {
      await init();
    }
    return preferences;
  }

  /// Get All Data From SharedPreferences
  static Future<void> getAllPrefData() async {
    try {
      final localStorage = await _getStorage();
      if (localStorage == null) {
        AppLogger.warning('SharedPreferences not available, using defaults', tag: 'STORAGE');
        return;
      }
      
      token = localStorage.getString(LocalStorageKeys.token) ?? "";
      isLogIn = localStorage.getBool(LocalStorageKeys.isLogIn) ?? false;
      userId = localStorage.getString(LocalStorageKeys.userId) ?? "";
      myName = localStorage.getString(LocalStorageKeys.myName) ?? "";
      myEmail = localStorage.getString(LocalStorageKeys.myEmail) ?? "";
      
      AppLogger.debug(
        'Loaded data from storage - isLogIn: $isLogIn, hasToken: ${token.isNotEmpty}',
        tag: 'STORAGE',
      );
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
      if (localStorage == null) {
        AppLogger.warning('SharedPreferences not available, clearing in-memory data only', tag: 'STORAGE');
        _resetLocalStorageData();
        return;
      }
      await localStorage.clear();
      _resetLocalStorageData();
      AppLogger.info('All preference data cleared - User logged out', tag: 'STORAGE');
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
      token = "";
      refreshToken = "";
      isLogIn = false;
      userId = "";
      myImage = "";
      myName = "";
      myEmail = "";
      myRoll = "";
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
      if (localStorage == null) {
        AppLogger.warning('SharedPreferences not available, cannot save $key', tag: 'STORAGE');
        return;
      }
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
      if (localStorage == null) {
        AppLogger.warning('SharedPreferences not available, cannot save $key', tag: 'STORAGE');
        return;
      }
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
      if (localStorage == null) {
        AppLogger.warning('SharedPreferences not available, cannot save $key', tag: 'STORAGE');
        return;
      }
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

  static String get getToken {
    return preferences?.getString(LocalStorageKeys.token) ?? token;
  }
}