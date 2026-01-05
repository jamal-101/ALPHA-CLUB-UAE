import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../utils/app_string/app_string.dart';


class ApiResponseModel {
  final int? _statusCode;
  final Map? _data;

  ApiResponseModel(this._statusCode, this._data);

  bool get isSuccess => _statusCode == 200;

  int get statusCode => _statusCode ?? 500;

  String get message {
    if (_statusCode == 502) {
      return AppString.startServer;
    }
    return _data?['message']?.toString() ?? AppString.someThingWrong;
  }

  Map get data => _data ?? {};

  void handleResponse({required Function(Map data) onSuccess}) {
    if (isSuccess) {
      onSuccess(data);
    } else {
      Get.snackbar("Error", message);
    }
  }
}