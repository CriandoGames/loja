import 'package:flutter/material.dart';
import 'package:loja/features/home_store/home_store.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fake Store',
      debugShowCheckedModeBanner: false,
      home: HomeStore(),
    );
  }
}
