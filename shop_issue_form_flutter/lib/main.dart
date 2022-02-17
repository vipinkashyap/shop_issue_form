import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBn2QOi4yOCwBG2LNez3fxw_7Za2iGJGLc",
          appId: "1:422962188365:web:f557e418eb4140217d8c04",
          messagingSenderId: "422962188365",
          projectId: "shop-issue-form-flutter",
          storageBucket: "gs://shop-issue-form-flutter.appspot.com"));
  runApp(const MyApp());
}
