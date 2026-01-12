import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tachyon_api_client/tachyon_api_client.dart';
import 'theme.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        // Configure the base URL for the API
        apiBaseUrlProvider.overrideWithValue('http://localhost:8183'),
      ],
      child: const TachyonApp(),
    ),
  );
}

class TachyonApp extends StatelessWidget {
  const TachyonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tachyon-5',
      theme: TachyonTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now, just show the login screen as we haven't implemented persistent auth yet
    return const LoginScreen();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TACHYON-5',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Logical Velocity',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  letterSpacing: 4,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 48),
              // We will replace this with the real login form
              ElevatedButton(
                onPressed: () {},
                child: const Text('GET STARTED'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
