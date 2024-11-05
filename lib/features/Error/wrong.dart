import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loja/core/shared/image_path.dart';

class Wrong extends StatelessWidget {
  const Wrong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(ImagePath.wrongImage()),
          ),
        ],
      ),
      bottomNavigationBar: TextButton(
        onPressed: () {
          GoRouter.of(context).pushReplacement('/');
        },
        child: const Text('Go Home'),
      ),
    );
  }
}
