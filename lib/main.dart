import 'package:flutter/material.dart';
import 'package:alpha_club/core/stroge/storage_service.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize storage
  await LocalStorage.getAllPrefData();
  
  runApp(const MyApp());
}
