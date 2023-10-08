import 'package:flutter/material.dart';
import 'package:flutter_bloc_with_apis/features/articles/ui/articles_page.dart';
import 'package:flutter_bloc_with_apis/features/home/ui/home_page.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArticlesPage(),
    );
  }
}