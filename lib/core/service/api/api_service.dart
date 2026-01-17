import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../stroge/storage_service.dart';
import '../../utils/app_string/app_string.dart';
import 'api_enpoint.dart';
import 'api_response.dart';
import '../logger/app_logger.dart';



class ApiService {
  static final Dio _dio = _getMyDio();

  /// ========== [ HTTP METHODS ] ========== ///
  static Future<ApiResponseModel> post(
      String url, {
        dynamic body,
        Map<String, String>? header,
      }) => _request(url, "POST", body: body, header: header);

  static Future<ApiResponseModel> get(
      String url, {
        Map<String, String>? header,
      }) => _request(url, "GET", header: header);

  static Future<ApiResponseModel> put(
      String url, {
        dynamic body,
        Map<String, String>? header,
      }) => _request(url, "PUT", body: body, header: header);

  static Future<ApiResponseModel> patch(
      String url, {
        dynamic body,
        Map<String, String>? header,
      }) => _request(url, "PATCH", body: body, header: header);

  static Future<ApiResponseModel> delete(
      String url, {
        dynamic body,
        Map<String, String>? header,
      }) => _request(url, "DELETE", body: body, header: header);

  // static Future<ApiResponseModel> multipart(
  //     String url, {
  //       Map<String, String> header = const {},
  //       Map<String, String> body = const {},
  //       String method = "POST",
  //       String imageName = 'image',
  //       String? imagePath,
  //     }) async {
  //   // Initialize FormData with the body fields
  //   FormData formData = FormData.fromMap(body);
  //
  //   // Check if an image path is provided
  //   if (imagePath != null) {
  //     final file = File(imagePath);
  //     if (await file.exists()) {
  //       // final compressedFile = await compressImage(file);
  //       String fileName = file.path.split('/').last;
  //       String? mimeType = lookupMimeType(file.path);
  //
  //       // Add the file to FormData
  //       formData.files.add(
  //         MapEntry(
  //           imageName, // Key as per the API documentation
  //           await MultipartFile.fromFile(
  //             file.path,
  //             filename: fileName,
  //             contentType:
  //             mimeType != null ? MediaType.parse(mimeType) : null,
  //           ),
  //         ),
  //       );
  //     }
  //   }
  //
  //
  //   FormData formData = FormData();
  //   if (imagePath != null && imagePath.isNotEmpty) {
  //     File file = File(imagePath);
  //     String extension = file.path.split('.').last.toLowerCase();
  //     String? mimeType = lookupMimeType(imagePath);
  //
  //     formData.files.add(
  //       MapEntry(
  //         imageName,
  //         await MultipartFile.fromFile(
  //           imagePath,
  //           filename: "$imageName.$extension",
  //           contentType:
  //               mimeType != null
  //                   ? DioMediaType.parse(mimeType)
  //                   : DioMediaType.parse("image/jpeg"),
  //         ),
  //       ),
  //     );
  //   }
  //
  //
  //   body.forEach((key, value) {
  //     formData.fields.add(MapEntry(key, value));
  //   });
  //
  //   header['Content-Type'] = "multipart/form-data";
  //
  //   return _request(url, method, body: formData, header: header);
  // }



  static Future<ApiResponseModel> multipart(
      String url, {
        Map<String, String> header = const {},
        Map<String, String> body = const {},
        String method = "POST",
        String imageName = 'image',
        String? imagePath,
      }) async {

    // ১. বডি ডাটা দিয়ে FormData শুরু করুন
    FormData formData = FormData.fromMap(body);

    // ২. যদি ইমেজ পাথ থাকে তবে সেটি যোগ করুন
    if (imagePath != null && imagePath.isNotEmpty) {
      final file = File(imagePath);
      if (await file.exists()) {
        String fileName = file.path.split('/').last;

        formData.files.add(
          MapEntry(
            imageName,
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
          ),
        );
      }
    }

    // ৩. হেডার সেট করুন
    Map<String, String> finalHeader = Map.from(header);
    finalHeader['Content-Type'] = "multipart/form-data";

    return _request(url, method, body: formData, header: finalHeader);
  }

  /// ========== [ API REQUEST HANDLER ] ========== ///
  static Future<ApiResponseModel> _request(
      String url,
      String method, {
        dynamic body,
        Map<String, String>? header,
      }) async {
    try {
      final startTime = DateTime.now();
      
      // Log request
      AppLogger.logRequest(
        endpoint: url,
        method: method,
        headers: header,
        body: body,
        tag: 'API_REQUEST',
      );

      final response = await _dio.request(
        url,
        data: body,
        options: Options(method: method, headers: header),
      );

      final duration = DateTime.now().difference(startTime).inMilliseconds;
      
      // Log response
      AppLogger.logResponse(
        endpoint: url,
        statusCode: response.statusCode ?? 0,
        responseData: response.data,
        duration: duration,
        tag: 'API_RESPONSE',
      );

      return _handleResponse(response);
    } catch (e, stackTrace) {
      AppLogger.error(
        'API Request Failed',
        tag: 'API_ERROR',
        error: e,
        stackTrace: stackTrace,
      );
      return _handleError(e);
    }
  }

  static ApiResponseModel _handleResponse(Response response) {
    if (response.statusCode == 201) {
      return ApiResponseModel(200, response.data);
    }
    return ApiResponseModel(response.statusCode, response.data);
  }

  static ApiResponseModel _handleError(dynamic error) {
    try {
      return _handleDioException(error);
    } catch (e) {
      return ApiResponseModel(500, {});
    }
  }

  static ApiResponseModel _handleDioException(DioException error) {
    // Log API error
    AppLogger.logApiError(
      endpoint: error.requestOptions.uri.toString(),
      method: error.requestOptions.method,
      error: error.message,
      statusCode: error.response?.statusCode,
      responseData: error.response?.data,
      tag: 'DIO_EXCEPTION',
    );

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        AppLogger.warning(
          'Request Timeout',
          tag: 'TIMEOUT',
          error: error,
        );
        return ApiResponseModel(408, {"message": AppString.requestTimeOut});

      case DioExceptionType.badResponse:
        AppLogger.error(
          'Bad Response: ${error.response?.statusCode}',
          tag: 'BAD_RESPONSE',
          error: error,
        );
        return ApiResponseModel(
          error.response?.statusCode,
          error.response?.data,
        );

      case DioExceptionType.connectionError:
        AppLogger.error(
          'Connection Error',
          tag: 'CONNECTION_ERROR',
          error: error,
        );
        return ApiResponseModel(503, {
          "message": AppString.noInternetConnection,
        });

      default:
        AppLogger.error(
          'Unknown Error',
          tag: 'UNKNOWN_ERROR',
          error: error,
        );
        return ApiResponseModel(400, {});
    }
  }
}

/// ========== [ DIO INSTANCE WITH INTERCEPTORS ] ========== ///
 Dio _getMyDio() {
   Dio dio = Dio();

  dio.interceptors.add(apiLog());

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options
          ..headers["Authorization"] ??= "Bearer ${LocalStorage.token}"
          ..headers["Content-Type"] ??= "application/json"
          ..connectTimeout = const Duration(seconds: 30)
          ..sendTimeout = const Duration(seconds: 30)
          ..receiveDataWhenStatusError = true
          ..responseType = ResponseType.json
          ..receiveTimeout = const Duration(seconds: 30)
          ..baseUrl =
          options.baseUrl.startsWith("http") ? "" : ApiEndPoint.baseUrl;
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) {
        handler.next(error);
      },
    ),
  );

  return dio;
}


Interceptor apiLog() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      AppLogger.logRequest(
        endpoint: options.uri.toString(),
        method: options.method,
        headers: options.headers.cast<String, dynamic>(),
        body: options.data,
        tag: 'DIO_INTERCEPTOR',
      );
      handler.next(options);
    },
    onResponse: (response, handler) {
      AppLogger.logResponse(
        endpoint: response.requestOptions.uri.toString(),
        statusCode: response.statusCode ?? 0,
        responseData: response.data,
        duration: 0,
        tag: 'DIO_INTERCEPTOR',
      );
      handler.next(response);
    },
    onError: (error, handler) {
      AppLogger.logApiError(
        endpoint: error.requestOptions.uri.toString(),
        method: error.requestOptions.method,
        error: error.message,
        statusCode: error.response?.statusCode,
        responseData: error.response?.data,
        tag: 'DIO_INTERCEPTOR_ERROR',
      );
      handler.next(error);
    },
  );
}