import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/controller/auth_provider.dart';
import 'package:firebase_authentication/view/login_screen/login_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.watch<AuthProvider>().stream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginForm();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
            actions: [
              IconButton(
                onPressed: () => context.watch<AuthProvider>().signOut(),
                icon: const Icon(Icons.logout),
                splashRadius: 20,
              ),
            ],
          ),
          body: const Center(
            child: Text('hello world'),
          ),
        );
      },
    );
  }
}
