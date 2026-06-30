import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';

class InAppUpdateService {
  static Future<void> checkForUpdate() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;

    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
      }
    } catch (e) {
      debugPrint("In-App Update Error: $e");
    }
  }

  static Future<void> checkAndShowUpdate() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;

    try {
      InAppUpdate.checkForUpdate().then((info) {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          InAppUpdate.performImmediateUpdate().catchError((e){
            debugPrint("Immediate Update Error: $e");
          });
        }
      }).catchError((e) {
        debugPrint("Check for Update Error: $e");
      });
    } catch (e) {
      debugPrint("In-App Update Service Error: $e");
    }
  }
}
