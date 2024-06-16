import 'package:flutter/material.dart';
import 'package:garap/view/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Hive
  await Hive.initFlutter();
  await Hive.openBox('one_time_task_list');
  await Hive.openBox('daily_task_list');
  await Hive.openBox('day');
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garap',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 68, 68, 68),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Garap',
      home: const MainPage(),
    );
  }
}
