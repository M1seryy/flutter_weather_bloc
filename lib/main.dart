import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:your_app_name/ui/widgets/pages/mainScreen/mainScreen.dart';

void main() async {
  try {
    await dotenv.load();
  } catch (e) {
    print("Error loading .env file: $e");
  } //  .env file load
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: mainScreen(),
    );
  }
}
