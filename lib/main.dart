import 'package:flutter/material.dart';
import 'package:alpha_club/core/stroge/storage_service.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize storage first
  await LocalStorage.init();
  
  // Load saved data
  await LocalStorage.getAllPrefData();
  
  runApp(const MyApp());
}
