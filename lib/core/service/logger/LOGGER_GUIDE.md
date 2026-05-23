# App Logger Guide

## Overview

The `AppLogger` is a comprehensive logging system for the Alpha Club app that provides detailed logging for:
- API requests and responses
- Errors and exceptions
- App crashes
- User actions
- Navigation events
- Performance metrics

## Features

### 1. **Log Levels**
- 🐛 **DEBUG** - Detailed debugging information
- ℹ️ **INFO** - General informational messages
- ⚠️ **WARNING** - Warning messages
- ❌ **ERROR** - Error messages
- 🔴 **CRITICAL** - Critical errors (app crashes)

### 2. **Sensitive Data Masking**
Automatically masks sensitive information:
- Passwords
- Tokens
- Authorization headers
- API keys
- Secrets

### 3. **Formatted Output**
All logs are beautifully formatted with:
- Timestamps
- Log level indicators (emojis)
- Hierarchical structure
- Color-coded output

## Usage Examples

### Basic Logging

```dart
import 'package:alpha_club/core/service/logger/app_logger.dart';

// Debug log
AppLogger.debug('Debug message');

// Info log
AppLogger.info('Information message');

// Warning log
AppLogger.warning('Warning message');

// Error log
AppLogger.error('Error message', error: exception, stackTrace: stackTrace);

// Critical log (app crash)
AppLogger.critical('Critical error', error: exception, stackTrace: stackTrace);
```

### API Request Logging

```dart
AppLogger.logRequest(
  endpoint: '/auth/login',
  method: 'POST',
  headers: {'Authorization': 'Bearer token'},
  body: {'phone': '1234567890', 'password': 'password'},
  tag: 'LOGIN_API',
);
```

**Output:**
```
📤 API REQUEST
├─ Endpoint: /auth/login
├─ Method: POST
├─ Headers:
│  ├─ Authorization: ***MASKED***
│  ├─ Content-Type: application/json
├─ Body:
│  ├─ phone: 1234567890
│  ├─ password: ***MASKED***
└─ End Request
```

### API Response Logging

```dart
AppLogger.logResponse(
  endpoint: '/auth/login',
  statusCode: 200,
  responseData: {'token': 'abc123', 'user': 'John'},
  duration: 250,
  tag: 'LOGIN_API',
);
```

**Output:**
```
📥 API RESPONSE
├─ Endpoint: /auth/login
├─ Status Code: 200
├─ Duration: 250ms
├─ Response Data:
│  ├─ token: abc123
│  ├─ user: John
└─ End Response
```

### API Error Logging

```dart
AppLogger.logApiError(
  endpoint: '/auth/login',
  method: 'POST',
  error: 'Connection timeout',
  statusCode: 408,
  responseData: {'message': 'Request timeout'},
  tag: 'LOGIN_API',
);
```

**Output:**
```
❌ API ERROR
├─ Endpoint: /auth/login
├─ Method: POST
├─ Status Code: 408
├─ Error: Connection timeout
├─ Error Response:
│  ├─ message: Request timeout
└─ End Error
```

### App Crash Logging

```dart
try {
  // Some code that might crash
} catch (e, stackTrace) {
  AppLogger.logCrash(
    message: 'Unexpected error occurred',
    error: e,
    stackTrace: stackTrace,
    tag: 'APP_CRASH',
  );
}
```

**Output:**
```
🔴 APP CRASH
├─ Message: Unexpected error occurred
├─ Error: FormatException: Invalid number
├─ Stack Trace:
│  ├─ #0 int.parse (dart:core/int.dart:563:7)
│  ├─ #1 MyClass.parseNumber (package:alpha_club/my_class.dart:10:5)
│  ├─ #2 main (package:alpha_club/main.dart:5:5)
└─ End Crash
```

### User Action Logging

```dart
AppLogger.logUserAction(
  action: 'Login Attempt',
  data: {
    'phone': '1234567890',
    'timestamp': DateTime.now().toString(),
  },
  tag: 'USER_ACTION',
);
```

**Output:**
```
👤 USER ACTION
├─ Action: Login Attempt
├─ Data:
│  ├─ phone: 1234567890
│  ├─ timestamp: 2025-01-06 10:30:45.123
└─ End Action
```

### Navigation Logging

```dart
AppLogger.logNavigation(
  from: 'LoginScreen',
  to: 'HomeScreen',
  arguments: {'userId': '123'},
  tag: 'NAVIGATION',
);
```

**Output:**
```
🧭 NAVIGATION
├─ From: LoginScreen
├─ To: HomeScreen
├─ Arguments:
│  ├─ userId: 123
└─ End Navigation
```

### Performance Logging

```dart
final startTime = DateTime.now();
// Some operation
final duration = DateTime.now().difference(startTime).inMilliseconds;

AppLogger.logPerformance(
  operation: 'Database Query',
  duration: duration,
  tag: 'PERFORMANCE',
);
```

**Output:**
```
⏱️ Performance: Database Query took 150ms
```

## Integration with API Service

The logger is automatically integrated with the API service:

```dart
// In api_service.dart
static Future<ApiResponseModel> _request(...) async {
  try {
    final startTime = DateTime.now();
    
    // Log request
    AppLogger.logRequest(
      endpoint: url,
      method: method,
      headers: header,
      body: body,
    );

    final response = await _dio.request(...);
    final duration = DateTime.now().difference(startTime).inMilliseconds;
    
    // Log response
    AppLogger.logResponse(
      endpoint: url,
      statusCode: response.statusCode ?? 0,
      responseData: response.data,
      duration: duration,
    );

    return _handleResponse(response);
  } catch (e, stackTrace) {
    AppLogger.error('API Request Failed', error: e, stackTrace: stackTrace);
    return _handleError(e);
  }
}
```

## Best Practices

1. **Use Appropriate Log Levels**
   - Use `debug()` for development information
   - Use `info()` for important events
   - Use `warning()` for potential issues
   - Use `error()` for errors that don't crash the app
   - Use `critical()` for app crashes

2. **Add Meaningful Tags**
   ```dart
   AppLogger.info('User logged in', tag: 'AUTH');
   AppLogger.error('Database error', tag: 'DATABASE', error: e);
   ```

3. **Include Context**
   ```dart
   AppLogger.logUserAction(
     action: 'Button Clicked',
     data: {'button': 'submit', 'form': 'login'},
   );
   ```

4. **Log Errors with Stack Traces**
   ```dart
   try {
     // code
   } catch (e, stackTrace) {
     AppLogger.error('Operation failed', error: e, stackTrace: stackTrace);
   }
   ```

5. **Use Navigation Logging for Debugging**
   ```dart
   AppLogger.logNavigation(
     from: Get.previousRoute,
     to: AppRoute.homeScreen,
   );
   ```

## Output Format

All logs follow a consistent hierarchical format:

```
[EMOJI] [TIMESTAMP] [LEVEL] [TAG]
├─ Field1: Value1
├─ Field2: Value2
│  ├─ SubField1: SubValue1
│  ├─ SubField2: SubValue2
└─ End Log
```

## Debugging Tips

1. **Search for specific tags** in console output
2. **Monitor API calls** with request/response logs
3. **Track user actions** to understand user flow
4. **Identify crashes** with critical logs
5. **Measure performance** with performance logs

## Notes

- Logs are only printed in debug mode (`kDebugMode`)
- Sensitive data is automatically masked
- All timestamps are in local timezone
- Stack traces are limited to first 5 frames for readability
