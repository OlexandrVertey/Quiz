import 'package:flutter/material.dart';
import 'package:quiz/di/app_dependency_provider.dart';
import 'package:quiz/questions_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runAppWithInjectedDependencies(app: const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QuestionsPage(),
    );
  }
}
