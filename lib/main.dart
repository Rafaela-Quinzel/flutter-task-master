import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_master/config/firebase_config.dart';
import 'package:flutter_task_master/screens/auth/auth_wrapper.dart';
import 'package:flutter_task_master/screens/auth/login_screen.dart';

void main() async {
  // Serve para garantir que o Flutter esteja completamente inicializado antes de chamar o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseConfig.web);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMaster Real-time',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        fontFamily: 'Inter',
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
