import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/home_page.dart';
import 'Pages/sign_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TaskFirebase());
}

class TaskFirebase extends StatefulWidget {
  const TaskFirebase({super.key});

  @override
  State<TaskFirebase> createState() => _TaskFirebaseState();
}

class _TaskFirebaseState extends State<TaskFirebase> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/sign_in_page': (context) => const SignInPage(),
        '/home_page': (context) => HomePage(),
      },
      initialRoute: '/sign_in_page',
      home: const SafeArea(
        child: Scaffold(
          body: SignInPage(),
        ),
      ),
    );
  }
}
