import 'package:flutter/material.dart';
import 'package:loja/core/shared/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fake Store',
      debugShowCheckedModeBanner: false,
      routerConfig: Routes.router,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
