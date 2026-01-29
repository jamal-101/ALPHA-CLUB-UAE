//plugins {
//    id("com.android.application")
//    id("kotlin-android")
//    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//    id("dev.flutter.flutter-gradle-plugin")
//}
//
//android {
//    namespace = "com.example.alpha_club"
//    compileSdk = flutter.compileSdkVersion
//    ndkVersion = flutter.ndkVersion
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_17
//        targetCompatibility = JavaVersion.VERSION_17
//        coreLibraryDesugaringEnabled true
//        sourceCompatibility JavaVersion.VERSION_1_8
//                targetCompatibility JavaVersion.VERSION_1_8
//    }
//
//    kotlinOptions {
////        jvmTarget = JavaVersion.VERSION_17.toString()
//        jvmTarget = '1.8'
//    }
//
//    defaultConfig {
//        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//        applicationId = "com.example.alpha_club"
//        // You can update the following values to match your application needs.
//        // For more information, see: https://flutter.dev/to/review-gradle-config.
//        minSdk = flutter.minSdkVersion
//        targetSdk = flutter.targetSdkVersion
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//        multiDexEnabled true
//    }
//
//    buildTypes {
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            signingConfig = signingConfigs.getByName("debug")
//        }
//    }
//}
//
//flutter {
//    source = "../.."
//}
//
//dependencies {
//    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")
//}

plugins {
    id("com.google.gms.google-services") version "4.4.0" apply false
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
//    id("com.google.gms.google-services") // ফায়ারবেস প্লাগইনটি এখানে থাকতে হবে
}

android {
    namespace = "com.example.alpha_club"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Kotlin DSL এ এইভাবে লিখতে হয়
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8" // ডাবল কোট হবে এবং = চিহ্ন লাগবে
    }

    defaultConfig {
        applicationId = "com.example.alpha_club"
        minSdk = flutter.minSdkVersion // অন্তত ২১ রাখা ভালো নোটিফিকেশনের জন্য
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true // এখানেও = লাগবে
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // এটি জাভা ৮ ফিচারের জন্য প্রয়োজন
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
