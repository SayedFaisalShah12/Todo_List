import 'package:flutter/material.dart';
import 'package:notebook/screens/note_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoteList(),

    );
  }
}
